import 'package:dio/dio.dart';
import 'package:flutter_application/providers/auth_events.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final _storage = const FlutterSecureStorage();

  AuthInterceptor(this._dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 1. Leggiamo il token dallo storage
    final accessToken = await _storage.read(key: 'access_token');

    // 2. Se esiste, lo aggiungiamo agli header
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 3. Se l'errore è 401, proviamo a rinnovare il token
    if (err.response?.statusCode == 401) {
      final refreshToken = await _storage.read(key: 'refresh_token');

      if (refreshToken != null) {
        try {
          // Tentativo di refresh
          final success = await _refreshTokens(refreshToken);

          if (success) {
            // Se il refresh è andato a buon fine, riproviamo la chiamata originale
            final accessToken = await _storage.read(key: 'access_token');

            // Aggiorniamo l'header della vecchia richiesta
            err.requestOptions.headers['Authorization'] = 'Bearer $accessToken';

            // Rieseguiamo la chiamata con il nuovo token
            final response = await _dio.fetch(err.requestOptions);
            return handler.resolve(response);
          }
        } catch (e) {
          await _storage.deleteAll();
          AuthEvents.emitLogout();
          return handler.next(err);
        }
      }
    }

    return handler.next(err);
  }

  Future<bool> _refreshTokens(String refreshToken) async {
    try {
      final refreshDio = Dio(BaseOptions(baseUrl: _dio.options.baseUrl));
      final response = await refreshDio.post(
        '/user/token/refresh',
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200) {
        await _storage.write(
          key: 'access_token',
          value: response.data['access_token'],
        );
        if (response.data['refresh_token'] != null) {
          await _storage.write(
            key: 'refresh_token',
            value: response.data['refresh_token'],
          );
        }
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }
}
