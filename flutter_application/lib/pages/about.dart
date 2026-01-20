import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application/services/email_service.dart';
import 'package:flutter_application/widgets/about/contactform.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/navbar.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final EmailService emailService = EmailService();
  final contactFormKey = GlobalKey();
  final MapController _mapController = MapController();

  StreamSubscription<Position>? _positionStream;
  LatLng _currentLatLng = const LatLng(46.433334, 11.850000);
  bool _isTracking = false;

  final LatLngBounds dolomitesBounds = LatLngBounds(
    LatLng(46.20, 11.50),
    LatLng(46.80, 12.60),
  );

  @override
  void initState() {
    super.initState();
    _startLocationTracking();
  }

  @override
  void dispose() {
    // IMPORTANTE: fermare il GPS quando si esce dalla pagina
    _positionStream?.cancel();
    super.dispose();
  }

  Future<void> _startLocationTracking() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Controllo se il GPS è attivo
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    // Gestione permessi
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 3,
    );

    _positionStream = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((Position position) {
      if (!mounted) return;

      final newLatLng = LatLng(position.latitude, position.longitude);

      setState(() {
        _currentLatLng = newLatLng;
        _isTracking = true;
      });

      _checkIfUserWithinBounds(newLatLng);
    });
  }

  void _checkIfUserWithinBounds(LatLng position) {
    if (dolomitesBounds.contains(position)) {
      _mapController.move(position, 15.0);
    } else {
      _mapController.move(LatLng(46.433334, 11.850000), 15.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HEADER (Tradotto in Italiano) ---
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 80, 24, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Su Alpine Trails',
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: Colors.brown.shade900,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Benvenuti su Alpine Trails, la guida definitiva per le avventure all\'aria aperta nelle Dolomiti!',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: FilledButton.icon(
                      onPressed: () {
                        Scrollable.ensureVisible(
                          contactFormKey.currentContext!,
                          curve: Curves.easeInOut,
                          duration: const Duration(milliseconds: 800),
                        );
                      },
                      label: const Text('Invia una richiesta'),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.brown,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --- CONTATTI EMERGENZA ---
            _buildSectionContainer(
              title: 'Contatti di Emergenza',
              description: 'In caso di emergenza, si prega di contattare:',
              child: Column(
                children: [
                  _buildContactTile(
                    context,
                    icon: Icons.emergency,
                    label: 'Servizi di Emergenza',
                    value: '112',
                    color: Colors.red.shade700,
                    onTap: () => launchUrl(Uri.parse("tel:112")),
                  ),
                  const SizedBox(height: 12),
                  _buildContactTile(
                    context,
                    icon: Icons.terrain,
                    label: 'Soccorso Alpino',
                    value: '+39 987 654 321',
                    color: Colors.orange.shade800,
                    onTap: () => launchUrl(Uri.parse("tel:+39987654321")),
                  ),
                ],
              ),
            ),

            // --- CONTATTI GENERALI ---
            _buildSectionContainer(
              title: 'Informazioni di Contatto',
              description: 'Per domande generali e supporto, contattaci a:',
              child: Column(
                children: [
                  _buildContactTile(
                    context,
                    icon: Icons.email_outlined,
                    label: 'Email',
                    value: 'support@alpinetrails.com',
                    color: Colors.brown,
                    onTap: () {
                      emailService.sendEmail(
                        'Richiesta Informazioni',
                        '',
                        emailTo: 'support@alpinetrails.com',
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildContactTile(
                    context,
                    icon: Icons.phone_outlined,
                    label: 'Telefono',
                    value: '+39 123 456 789',
                    color: Colors.brown,
                    onTap: () => launchUrl(Uri.parse("tel:+39123456789")),
                  ),
                ],
              ),
            ),

            // --- MAPPA ---
            _buildSectionTitle('Mappa della Posizione'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(color: Colors.grey.shade200),
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: _currentLatLng,
                      initialZoom: 13.0,
                      cameraConstraint: CameraConstraint.contain(
                        bounds: dolomitesBounds,
                      ),
                    ),
                    children: [
                      // 1. Il layer della mappa (OpenStreetMap)
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                      ),

                      // 2. Il layer del Marker (la tua posizione)
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: _currentLatLng,
                            width: 60,
                            height: 60,
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.blue,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // --- INFO GENERALI ---
            _buildSectionContainer(
              title: 'Informazioni Generali',
              description: 'Alpine Trails offre:',
              child: Column(
                children: [
                  _buildInfoItem(
                    Icons.map_outlined,
                    'Guide dettagliate per varie attività all\'aperto',
                  ),
                  _buildInfoItem(
                    Icons.backpack_outlined,
                    'Consigli su attrezzatura e equipaggiamento',
                  ),
                  _buildInfoItem(
                    Icons.wb_sunny_outlined,
                    'Aggiornamenti meteo in tempo reale',
                  ),
                  _buildInfoItem(
                    Icons.health_and_safety_outlined,
                    'Suggerimenti sulla sicurezza e buone pratiche',
                  ),
                ],
              ),
            ),

            // --- CONSIGLI UTILI ---
            _buildSectionContainer(
              title: 'Consigli Utili',
              description:
                  'Le nostre principali raccomandazioni per la tua sicurezza:',
              child: Column(
                children: [
                  _buildInfoItem(
                    Icons.cloud_sync_outlined,
                    'Controlla sempre le previsioni del tempo prima di uscire',
                  ),
                  _buildInfoItem(
                    Icons.check_circle_outline,
                    'Assicurati di avere l\'attrezzatura e le provviste necessarie',
                  ),
                  _buildInfoItem(
                    Icons.info_outline,
                    'Familiarizza con le procedure e i contatti di emergenza',
                  ),
                  _buildInfoItem(
                    Icons.nature_people_outlined,
                    'Rispetta la natura e segui i principi "Leave No Trace"',
                  ),
                ],
              ),
            ),

            // --- FORM DI RICHIESTA (Inserito in un riquadro visibile) ---
            _buildSectionContainer(
              title: 'Richiedi Informazioni',
              description:
                  'Hai domande? Inviaci la tua richiesta direttamente. Il nostro team è qui per aiutarti.',
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.brown.withValues(alpha: 0.2),
                    width: 1.5,
                  ),
                ),
                child: ContactFormWidget(key: contactFormKey),
              ),
            ),

            // --- FOOTER ---
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(
                'Grazie per aver scelto Alpine Trails per le tue avventure nelle Dolomiti. Ti auguriamo un\'esperienza indimenticabile!',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: const NavBar(index: 3),
    );
  }

  // --- COMPONENTI DI STILE ---

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildSectionContainer({
    required String title,
    required String description,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(fontSize: 15, color: Colors.black54),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildContactTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.1)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: color.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.brown.shade400),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
