import 'package:flutter/material.dart';
import 'package:flutter_application/models/mapmarkers.dart';
import 'package:flutter_application/services/domain/mapmarker_service.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_application/constants.dart' as constants;

class Explore extends StatefulWidget {
  Explore({super.key});

  final Logger logger = Logger();

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  List<MapMarker> mapMarkers = [];
  bool isTooltipVisible = false;
  MapMarker? selectedMarker;
  LatLng mapCenter = LatLng(46.433334, 11.850000); // Example coordinates

  Future<void> _loadMapMarkers() async {
    final mapMarkerService = MapmarkerService();
    mapMarkers = await mapMarkerService.getMapMarkerAll();
  }

  void _onMarkerTap(MapMarker marker) {
    setState(() {
      isTooltipVisible = true;
      mapCenter = LatLng(marker.latitude, marker.longitude);
      selectedMarker = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: FutureBuilder(
        future: _loadMapMarkers(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            widget.logger.e('Error loading map markers: ${snapshot.error}');
            return const Center(child: Text('Error loading data'));
          }
          return Column(
            spacing: 32,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(8),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              Text(
                'Discover the Dolomite Wonders',
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
                child: SearchBar(
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  onTap: () {},
                  onChanged: (value) {},
                  onSubmitted: (value) {},
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    bottom: 24,
                  ),
                  child: Card(
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
                                  mapMarkers.map((marker) {
                                    return Marker(
                                      point: LatLng(
                                        marker.latitude,
                                        marker.longitude,
                                      ),
                                      width: 40,
                                      height: 40,
                                      child: GestureDetector(
                                        onTap: () => _onMarkerTap(marker),
                                        child: Image(
                                          image: AssetImage(
                                            constants.markerType2IconData[marker
                                                .type]!,
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

                        if (isTooltipVisible)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: SizedBox(
                              width: width,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      spacing: 4,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              selectedMarker!.name,
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodyLarge?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  isTooltipVisible = false;
                                                });
                                              },
                                              icon: Icon(Icons.close),
                                            ),
                                          ],
                                        ),
                                        Text(selectedMarker!.type),
                                        Text(selectedMarker!.description ?? ''),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
