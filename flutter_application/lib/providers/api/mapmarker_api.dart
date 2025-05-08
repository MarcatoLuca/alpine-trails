import 'dart:convert';
import 'package:flutter_application/models/mapmarkers.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MapMarkerApi {
  final String baseUrl = dotenv.env['BASE_URL'] ?? 'default_url';

  Future<List<MapMarker>> getMapMarkerAll() async {
    var client = http.Client();
    var uri = Uri.parse('$baseUrl/map_markers/all');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      return mapMarkerFromJson(
        const Utf8Decoder().convert(response.bodyBytes),
      );
    }
    return [];
  }
}
