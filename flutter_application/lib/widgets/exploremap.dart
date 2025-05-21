import 'package:flutter/material.dart';
import 'package:flutter_application/models/mapmarkers.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import 'package:flutter_application/constants.dart' as constants;
import 'package:url_launcher/url_launcher.dart';

class ExploreMapWidget extends StatelessWidget {
  ExploreMapWidget({
    super.key,
    required this.mapMarkersFuture,
    required this.mapController,
    required this.onMapMarkerTap,
  });

  final Future<List<MapMarker>> mapMarkersFuture;
  final MapController mapController;
  final Function(BuildContext context, MapMarker marker) onMapMarkerTap;
  final Logger logger = Logger();
  final LatLng mapCenter = LatLng(46.433334, 11.850000); // Example coordinates

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MapMarker>>(
      future: mapMarkersFuture,
      builder: (BuildContext context, AsyncSnapshot<List<MapMarker>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          logger.e('Error loading map markers: ${snapshot.error}');
          return const Center(child: Text('Error loading data'));
        } else if (snapshot.hasData) {
          final List<MapMarker> loadedMapMarkers = snapshot.data!;
          return Card(
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    initialCenter: mapCenter,
                    initialZoom: 12,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(
                      markers:
                          loadedMapMarkers.map((marker) {
                            return Marker(
                              point: LatLng(marker.latitude, marker.longitude),
                              width: 40,
                              height: 40,
                              child: GestureDetector(
                                onTap: () {
                                  onMapMarkerTap(context, marker);
                                },
                                child: Image(
                                  image: AssetImage(
                                    constants.markerType2IconData[marker.type]!,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                    RichAttributionWidget(
                      attributions: [
                        // Suggested attribution for the OpenStreetMap public tile server
                        TextSourceAttribution(
                          'OpenStreetMap contributors',
                          onTap:
                              () => launchUrl(
                                Uri.parse(
                                  'https://openstreetmap.org/copyright',
                                ),
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return const Center(child: Text('No data available.'));
      },
    );
  }
}
