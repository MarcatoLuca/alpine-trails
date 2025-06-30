
import 'package:flutter_application/models/mapmarkers.dart';
import 'package:flutter_application/providers/api/mapmarker_api.dart';

class MapmarkerService {
  final _api = MapMarkerApi();

  Future<List<MapMarker>> getMapMarkerAll() async {
    return _api.getMapMarkerAll();
  }
}