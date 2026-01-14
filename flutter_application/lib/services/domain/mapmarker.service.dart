import 'package:flutter_application/providers/api_client.dart';
import 'package:flutter_application/models/mapmarkers.dart';
import 'package:logger/logger.dart';

class MapMarkerService {
  final Logger logger = Logger();
  final _apiClient = ApiClient();

  Future<List<MapMarker>> getMapMarkerAll() async {
    try {
      final response = await _apiClient.get('/map_markers/');
      
      final List<dynamic> data = response.data;
      
      return data.map((json) => MapMarker.fromJson(json)).toList();
      
    } catch (e) {
      logger.e('Errore durante il recupero dei map marker: $e');
      return [];
    }
  }
}