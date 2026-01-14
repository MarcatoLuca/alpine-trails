import 'package:flutter/material.dart';
import 'package:flutter_application/pages/sub/explore.dart';
import 'package:flutter_application/widgets/home/carousel.dart';
import 'package:flutter_application/widgets/navbar.dart';
import 'package:flutter_application/constants.dart' as constants;
import 'package:flutter_application/widgets/useravatarmenu.dart';
import 'package:flutter_sticky_widgets/flutter_sticky_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const Explore(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final Animation<double> curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.fastEaseInToSlowEaseOut,
        );
        return ScaleTransition(scale: curvedAnimation, child: child);
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(
        0xFFF8F9FA,
      ), // Un grigio chiarissimo per far risaltare le card bianche
      body: StickyContainer(
        stickyChildren: [
          StickyWidget(
            initialPosition: StickyPosition(top: 20, right: 20),
            finalPosition: StickyPosition(top: 20, right: 20),
            controller: _controller,
            child: const UserAvatarMenuWidget(),
          ),
        ],
        child: SingleChildScrollView(
          controller: _controller,
          padding: const EdgeInsets.only(bottom: 32),
          child: Column(
            children: [
              // --- HERO SECTION ---
              _buildHero(theme),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    // --- SEZIONE CATEGORIE RAPIDE ---
                    _buildSectionTitle(theme, "Esplora per attività"),
                    _buildCategoryGrid(),

                    const SizedBox(height: 40),

                    // --- SEZIONE CAROUSEL ---
                    _buildSectionTitle(theme, "Destinazioni da Sogno"),
                    Carousel(images: constants.homeCarouselImages),

                    const SizedBox(height: 40),

                    // --- SEZIONE STATISTICHE (I Numeri delle Dolomiti) ---
                    _buildSectionTitle(theme, "I nostri numeri"),
                    _buildStatsGrid(),

                    const SizedBox(height: 40),

                    // --- INFO CARD (Suggerimento Sicurezza) ---
                    _buildSafetyCard(theme),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(index: 0),
    );
  }

  // --- WIDGET: HERO SECTION ---
  Widget _buildHero(ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 100, 24, 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Benvenuto su',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.brown.shade300,
            ),
          ),
          Text(
            'Alpine Trails',
            style: theme.textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w900,
              color: Colors.brown.shade900,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'La tua guida definitiva per esplorare le meraviglie delle Dolomiti',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54, fontSize: 16),
          ),
          const SizedBox(height: 32),
          FilledButton.icon(
            onPressed: () {
              Navigator.of(context).push(_createRoute());
            },
            label: const Text('ESPLORA ORA'),
            icon: const Icon(Icons.explore_rounded),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.brown,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 36),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET: TITOLO SEZIONE ---
  Widget _buildSectionTitle(ThemeData theme, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.brown.shade900,
          ),
        ),
      ),
    );
  }

  // --- WIDGET: GRIGLIA CATEGORIE ---
  Widget _buildCategoryGrid() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _categoryIcon(Icons.hiking, "Trekking"),
        _categoryIcon(Icons.directions_bike, "Biking"),
        _categoryIcon(Icons.landscape, "Scalata"),
        _categoryIcon(Icons.camera_alt, "Foto"),
      ],
    );
  }

  Widget _categoryIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
            ],
          ),
          child: Icon(icon, color: Colors.brown, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  // --- WIDGET: GRID DELLE STATISTICHE ---
  Widget _buildStatsGrid() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.brown.shade900,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _statItem("1.200", "Km Sentieri"),
          _statItem("45", "Rifugi"),
          _statItem("12", "Cime >3k"),
        ],
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 11),
        ),
      ],
    );
  }

  // --- WIDGET: SAFETY CARD ---
  Widget _buildSafetyCard(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade300, Colors.orange.shade600],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          const Icon(Icons.wb_sunny_rounded, color: Colors.white, size: 40),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Consiglio del Giorno",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Il tempo in quota cambia rapidamente. Porta sempre una giacca a vento.",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
