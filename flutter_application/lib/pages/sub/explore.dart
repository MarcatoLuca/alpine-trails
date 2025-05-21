import 'package:flutter/material.dart';
import 'package:flutter_application/models/mapmarkers.dart';
import 'package:flutter_application/services/domain/mapmarker_service.dart';
import 'package:flutter_application/widgets/exploremap.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  late Future<List<MapMarker>> _mapMarkersFuture;
  late List<MapMarker> _mapMarkers;
  MapMarker? _selectedMapMarker;
  final MapController _mapController = MapController();
  OverlayEntry? overlayEntry;

  @override
  void initState() {
    super.initState();
    _mapMarkersFuture = _fetchMapMarkers();
  }

  Future<List<MapMarker>> _fetchMapMarkers() async {
    final mapMarkerService = MapmarkerService();
    List<MapMarker> result = await mapMarkerService.getMapMarkerAll();

    setState(() {
      _mapMarkers = result;
    });

    return result;
  }

  void handlePlaceSelection(BuildContext context, MapMarker marker) {
    setState(() {
      _mapController.move(LatLng(marker.latitude, marker.longitude), 12);
      _selectedMapMarker = marker;
    });
    _showOverlay(context);
  }

  void _showOverlay(BuildContext context) async {
    removeHighlightOverlay();

    final double width = MediaQuery.of(context).size.width;

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
                              _selectedMapMarker!.name,
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              onPressed: () => {removeHighlightOverlay()},
                              icon: Icon(Icons.close),
                            ),
                          ],
                        ),
                        Text(_selectedMapMarker!.type),
                        Text(_selectedMapMarker!.description ?? ''),
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

    // inserting overlay entry
    Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
  }

  void removeHighlightOverlay() {
    overlayEntry?.remove();
    overlayEntry?.dispose();
    overlayEntry = null;
  }

  @override
  void dispose() {
    removeHighlightOverlay();
    super.dispose();
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
            child: Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                }
                return _mapMarkers
                    .where((marker) {
                      return marker.name.toLowerCase().contains(
                        textEditingValue.text.toLowerCase(),
                      );
                    })
                    .map((marker) => marker.name);
              },
              onSelected: (String selection) {
                var marker = _mapMarkers.singleWhere(
                  (marker) =>
                      marker.name.toLowerCase() == selection.toLowerCase(),
                );
                handlePlaceSelection(context, marker);
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
              child: ExploreMapWidget(
                mapMarkersFuture: _mapMarkersFuture,
                mapController: _mapController,
                onMapMarkerTap: handlePlaceSelection,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
