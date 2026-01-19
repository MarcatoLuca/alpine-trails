import 'package:dio/dio.dart';
import 'package:flutter_application/providers/api_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_application/models/mapmarkers.dart';
import 'package:logger/logger.dart';

class MapMarkerService {
  final Logger logger = Logger();
  final _storage = const FlutterSecureStorage();
  final _apiClient = ApiClient();

  Future<List<MapMarker>> getMapMarkerAll() async {
    try {
      final token = await _storage.read(key: 'access_token');

      final response = await _apiClient.get(
        '/map_markers/',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final List<dynamic> data = response.data;

      return data.map((json) => MapMarker.fromJson(json)).toList();
    } catch (e) {
      logger.e('Errore durante il recupero dei map marker: $e');
      return [];
    }
  }
}
