import 'dart:convert';

List<MapMarker> mapMarkerFromJson(String str) => List<MapMarker>.from(json.decode(str).map((x) => MapMarker.fromJson(x)));

class MapMarker {
  final String name;
  final String type;
  final double latitude;
  final double longitude;
  final String? description;

  MapMarker({
    required this.name,
    required this.type,
    required this.latitude,
    required this.longitude,
    this.description,
  });

  factory MapMarker.fromJson(Map<String, dynamic> json) {
    return MapMarker(
      name: json['name'] as String,
      type: json['type'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'latitude': latitude,
      'longitude': longitude,
      'description': description,
    };
  }
}
