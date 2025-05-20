import 'package:flutter/material.dart';
import 'package:flutter_application/models/mapmarkers.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import 'package:flutter_application/constants.dart' as constants;
import 'package:url_launcher/url_launcher.dart';

class ExploreMapWidget extends StatefulWidget {
  ExploreMapWidget({super.key, required this.mapMarkersFuture});

  final Future<List<MapMarker>> mapMarkersFuture; // Accetta il Future
  final Logger logger = Logger();

  @override
  State<ExploreMapWidget> createState() => _ExploreMapWidgetState();
}

class _ExploreMapWidgetState extends State<ExploreMapWidget>
    with TickerProviderStateMixin {
  LatLng mapCenter = LatLng(46.433334, 11.850000); // Example coordinates

  AnimationController? animationController;
  Animation<double>? animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animation = CurveTween(
      curve: Curves.fastOutSlowIn,
    ).animate(animationController!);
  }

  void _showOverlay(BuildContext context, {required MapMarker marker}) async {
    final double width = MediaQuery.of(context).size.width;
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            margin: EdgeInsets.only(left: 32, bottom: 32, right: 32),
            child: SizedBox(
              width: width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      spacing: 4,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              marker.name,
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              onPressed: () => {animationController!.reverse()},
                              icon: Icon(Icons.close),
                            ),
                          ],
                        ),
                        Text(marker.type),
                        Text(marker.description ?? ''),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
    animationController!.addListener(() {
      overlayState.setState(() {});

      if (animation!.value == 1 && !animation!.isForwardOrCompleted) {
        overlayEntry.remove();
      }
    });
    // inserting overlay entry
    overlayState.insert(overlayEntry);
    animationController!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MapMarker>>(
      future: widget.mapMarkersFuture,
      builder: (BuildContext context, AsyncSnapshot<List<MapMarker>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          widget.logger.e('Error loading map markers: ${snapshot.error}');
          return const Center(child: Text('Error loading data'));
        } else if (snapshot.hasData) {
          final List<MapMarker> loadedMapMarkers = snapshot.data!;
          return Card(
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                FlutterMap(
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
                                onTap:
                                    () => _showOverlay(context, marker: marker),
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
