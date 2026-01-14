import 'package:flutter/material.dart';
import 'package:flutter_application/models/mapmarkers.dart';
import 'package:flutter_application/services/domain/mapmarker.service.dart';
import 'package:flutter_application/widgets/home/exploremap.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  late Future<List<MapMarker>> _mapMarkersFuture;
  late List<MapMarker> _mapMarkers = [];
  MapMarker? _selectedMapMarker;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _mapMarkersFuture = _fetchMapMarkers();
  }

  Future<List<MapMarker>> _fetchMapMarkers() async {
    final mapMarkerService = MapMarkerService();
    List<MapMarker> result = await mapMarkerService.getMapMarkerAll();
    setState(() => _mapMarkers = result);
    return result;
  }

  void handlePlaceSelection(BuildContext context, MapMarker marker) {
    setState(() {
      _mapController.move(LatLng(marker.latitude, marker.longitude), 13);
      _selectedMapMarker = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB), // Sfondo panna chiarissimo
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.brown, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "ESPLORA",
          style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // --- BARRA DI RICERCA ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: _buildSearchBar(),
          ),

          const SizedBox(height: 16),

          // --- CONTENITORE MAPPA ---
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: ExploreMapWidget(
                    mapMarkersFuture: _mapMarkersFuture,
                    mapController: _mapController,
                    onMapMarkerTap: (ctx, marker) => handlePlaceSelection(ctx, marker),
                  ),
                ),
              ),
            ),
          ),

          // --- SEZIONE DETTAGLI (Appare solo se selezioni un marker) ---
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _selectedMapMarker == null ? 0 : 220,
            child: _selectedMapMarker == null 
              ? const SizedBox.shrink() 
              : _buildDetailSection(theme),
          ),
          
          if (_selectedMapMarker == null) 
            const Padding(
              padding: EdgeInsets.all(32.0),
              child: Text(
                "Tocca un segnaposto sulla mappa per vedere i dettagli",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.brown.withOpacity(0.1)),
      ),
      child: Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') return const Iterable<String>.empty();
          return _mapMarkers
              .where((marker) => marker.name.toLowerCase().contains(textEditingValue.text.toLowerCase()))
              .map((marker) => marker.name);
        },
        fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
          return TextField(
            controller: controller,
            focusNode: focusNode,
            decoration: const InputDecoration(
              hintText: "Cerca un luogo meraviglioso...",
              border: InputBorder.none,
              icon: Icon(Icons.search, color: Colors.brown),
            ),
          );
        },
        onSelected: (String selection) {
          var marker = _mapMarkers.singleWhere(
            (m) => m.name.toLowerCase() == selection.toLowerCase(),
          );
          handlePlaceSelection(context, marker);
        },
      ),
    );
  }

  Widget _buildDetailSection(ThemeData theme) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _selectedMapMarker!.name,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _selectedMapMarker!.type.toUpperCase(),
                      style: const TextStyle(fontSize: 11, color: Colors.brown, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => setState(() => _selectedMapMarker = null),
                icon: const Icon(Icons.close, size: 20),
              )
            ],
          ),
          const SizedBox(height: 12),
          Text(
            _selectedMapMarker!.description ?? 'Nessuna descrizione disponibile.',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.black54),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: Colors.brown,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("VEDI DETTAGLI"),
            ),
          )
        ],
      ),
    );
  }
}