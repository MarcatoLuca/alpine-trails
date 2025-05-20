import 'package:flutter/material.dart';
import 'package:flutter_application/models/mapmarkers.dart';
import 'package:flutter_application/services/domain/mapmarker_service.dart';
import 'package:flutter_application/widgets/exploremap.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  late Future<List<MapMarker>> _mapMarkersFuture ;

  @override
  void initState() {
    super.initState();
    _mapMarkersFuture  =
        _fetchMapMarkers();
  }

  Future<List<MapMarker>> _fetchMapMarkers() async {
    final mapMarkerService = MapmarkerService();
    return await mapMarkerService.getMapMarkerAll();
  }

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
              child: ExploreMapWidget(mapMarkersFuture: _mapMarkersFuture ),
            ),
          ),
        ],
      ),
    );
  }
}
