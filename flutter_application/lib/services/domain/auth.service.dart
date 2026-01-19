import 'package:flutter/material.dart';
import 'package:flutter_application/models/user.dart';
import 'package:flutter_application/providers/api_client.dart';
import 'package:flutter_application/providers/auth_events.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthService with ChangeNotifier {
  final Logger logger = Logger();
  final _storage = const FlutterSecureStorage();
  final _apiClient = ApiClient();

  bool _isLoggedIn = false;
  User? _userData;

  AuthService() {
    AuthEvents.onLogout.listen((_) {
      _clearSession();
      notifyListeners();
    });
  }

  bool get isLoggedIn => _isLoggedIn;
  User? get userData => _userData;

  Future<void> tryAutoLogin() async {
    try {
      final accessToken = await _storage.read(key: 'access_token');
      final refreshToken = await _storage.read(key: 'refresh_token');

      if (accessToken == null) {
        await _clearSession();
        return;
      }

      bool isTokenExpired = JwtDecoder.isExpired(accessToken);

      if (isTokenExpired) {
        logger.w('Access token scaduto offline. Provo il refresh...');
        if (refreshToken != null) {
          bool refreshed = await refreshTokens();
          if (!refreshed) {
            await logout();
            return;
          }
        } else {
          await logout();
          return;
        }
      }

      final success = await fetchUserProfile();

      if (success) {
        logger.i('Auto-login completato con successo.');
        _isLoggedIn = true;
      } else {
        logger.e('Token non valido per il server (sessione revocata).');
        await logout();
      }
    } catch (e) {
      logger.e('Errore durante tryAutoLogin: $e');
      _isLoggedIn = false;
    } finally {
      notifyListeners();
    }
  }

  /// Recupera i dati del profilo utente (Verifica Online)
  Future<bool> fetchUserProfile() async {
    try {
      final response = await _apiClient.get('/user/me');

      if (response.statusCode == 200) {
        _userData = User.fromJson(response.data);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Tenta di rinnovare i token usando il Refresh Token
  Future<bool> refreshTokens() async {
    try {
      final refreshToken = await _storage.read(key: 'refresh_token');
      if (refreshToken == null) return false;

      final response = await _apiClient.post(
        '/user/refresh', // Assicurati di avere questo endpoint nel backend
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200) {
        await _storage.write(
          key: 'access_token',
          value: response.data['access_token'],
        );
        // Se il backend ne fornisce uno nuovo, aggiorna anche il refresh_token
        if (response.data['refresh_token'] != null) {
          await _storage.write(
            key: 'refresh_token',
            value: response.data['refresh_token'],
          );
        }
        return true;
      }
      return false;
    } catch (e) {
      logger.e('Errore durante il refresh del token: $e');
      return false;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final response = await _apiClient.post(
        '/user/token',
        data: {'username': email, 'password': password},
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      if (response.statusCode == 200) {
        await _storage.write(
          key: 'access_token',
          value: response.data['access_token'],
        );
        await _storage.write(
          key: 'refresh_token',
          value: response.data['refresh_token'],
        );

        _isLoggedIn = true;
        await fetchUserProfile(); // Carica i dati utente subito dopo il login
        notifyListeners();
      }
    } on DioException catch (e) {
      logger.e('Errore di login: ${e.response?.data}');
      rethrow;
    }
  }

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiClient.post(
        '/user/',
        data: {
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        logger.i('Registrazione completata con successo.');

        if (response.data['access_token'] != null) {
          final accessToken = response.data['access_token'];
          final refreshToken = response.data['refresh_token'];

          await _storage.write(key: 'access_token', value: accessToken);
          await _storage.write(key: 'refresh_token', value: refreshToken);

          _isLoggedIn = true;
          await fetchUserProfile();
          notifyListeners();
        } else {
          logger.i(
            'Token non presenti nella risposta. Eseguo il login automatico...',
          );
          await login(email, password);
        }
      }
    } on DioException catch (e) {
      logger.e('Errore durante la registrazione: ${e.response?.data}');
      rethrow;
    } catch (e) {
      logger.e('Errore generico durante la registrazione: $e');
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _clearSession();
    } finally {
      notifyListeners();
    }
  }

  /// Pulisce i dati locali
  Future<void> _clearSession() async {
    await _storage.deleteAll();
    _isLoggedIn = false;
    _userData = null;
  }
}
