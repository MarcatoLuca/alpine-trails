import 'package:flutter/material.dart';
import 'package:flutter_application/models/mapmarkers.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_application/constants.dart' as constants;

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  List<MapMarker> mapMarkers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
              child: Card(
                clipBehavior: Clip.hardEdge,
                child: SizedBox(
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: LatLng(46.433334, 11.850000),
                      initialZoom: 10,
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
                                child: Image(
                                  image: AssetImage(
                                    constants.markerType2IconData[marker.type]!,
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
