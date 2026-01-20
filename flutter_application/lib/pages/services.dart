import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Necessario per la trasparenza di sistema
import 'package:provider/provider.dart';
import '../services/activity_service.dart';
import '../widgets/navbar.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final activity = context.watch<ActivityService>();
    
    final double topPadding = MediaQuery.of(context).padding.top;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        extendBody: true, // Permette al corpo di andare sotto la NavBar
        extendBodyBehindAppBar: true, // Permette al corpo di andare sotto la Status Bar
        body: Stack(
          children: [
            // --- 2. SFONDO IMMERSIVO (OGNI SINGOLO PIXEL) ---
            Positioned.fill(
              child: Image.network(
                'https://images.unsplash.com/photo-1506744038136-46273834b3fb?q=80&w=2070&auto=format&fit=crop',
                fit: BoxFit.cover,
              ),
            ),
            
            // Blur e Overlay Sfumato
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Positioned.fill(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(24, topPadding + 20, 24, bottomPadding + 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "STRUMENTAZIONE",
                      style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 3),
                    ),
                    const Text(
                      "Apline Tracking",
                      style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900),
                    ),
                    
                    const SizedBox(height: 32),

                    _buildInstrumentCard(context, activity),

                    const SizedBox(height: 32),

                    Row(
                      children: [
                        Expanded(child: _buildQuickTool(Icons.map_outlined, "MAPPE", "Offline")),
                        const SizedBox(width: 16),
                        Expanded(child: _buildQuickTool(Icons.wb_cloudy_outlined, "METEO", "In quota")),
                      ],
                    ),
                    
                    const SizedBox(height: 32),
                    
                    Center(
                      child: Text(
                        activity.isActive ? "MONITORAGGIO IN CORSO" : "PRONTO PER IL TRACKING",
                        style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12, letterSpacing: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const NavBar(index: 2),
      ),
    );
  }

  // --- WIDGETS INTERNI ---

  Widget _buildInstrumentCard(BuildContext context, ActivityService activity) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 40)],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMainStat("DURATA", activity.formattedTime),
              _buildMainStat("DISTANZA", "${activity.distance.toStringAsFixed(2)} km"),
            ],
          ),

          // Sezione dati fittizi espandibile
          AnimatedSize(
            duration: const Duration(milliseconds: 500),
            child: activity.isActive 
              ? Column(
                  children: [
                    const Padding(padding: EdgeInsets.symmetric(vertical: 24), child: Divider(height: 1)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildExtraStat(Icons.height, "QUOTA", "1.850 m"),
                        _buildExtraStat(Icons.speed, "VENTO", "12 km/h"),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildExtraStat(Icons.trending_up, "PENDENZA", "+8%"),
                        _buildExtraStat(Icons.local_fire_department, "CALORIE", "340 kcal"),
                      ],
                    ),
                  ],
                ) 
              : const SizedBox(width: double.infinity),
          ),

          const SizedBox(height: 32),
          _buildControls(context, activity),
        ],
      ),
    );
  }

  Widget _buildMainStat(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.brown)),
      ],
    );
  }

  Widget _buildExtraStat(IconData icon, String label, String value) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          Icon(icon, size: 20, color: Colors.brown.shade300),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.grey)),
          Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildControls(BuildContext context, ActivityService activity) {
    if (!activity.isActive) {
      return SizedBox(
        width: double.infinity,
        height: 65,
        child: FilledButton(
          onPressed: () => activity.startActivity(),
          style: FilledButton.styleFrom(
            backgroundColor: Colors.brown,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          child: const Text("INIZIA TRACKING", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        ),
      );
    }
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 65,
            child: FilledButton(
              onPressed: () => activity.togglePause(),
              style: FilledButton.styleFrom(
                backgroundColor: activity.isPaused ? Colors.green.shade700 : Colors.orange.shade800,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: Text(activity.isPaused ? "RIPRENDI" : "PAUSA"),
            ),
          ),
        ),
        const SizedBox(width: 12),
        IconButton.filled(
          onPressed: () => _confirmStop(context, activity),
          style: IconButton.styleFrom(
            backgroundColor: Colors.red.shade100,
            padding: const EdgeInsets.all(18),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          icon: const Icon(Icons.stop_rounded, color: Colors.red, size: 28),
        )
      ],
    );
  }

  Widget _buildQuickTool(IconData icon, String title, String sub) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Column(
            children: [
              Icon(icon, color: Colors.white, size: 30),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 1.2)),
              Text(sub, style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 10)),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmStop(BuildContext context, ActivityService activity) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white.withOpacity(0.9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        title: const Text("Concludere?", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown)),
        content: const Text("Vuoi fermare l'escursione? I dati correnti verranno azzerati."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("ANNULLA", style: TextStyle(color: Colors.grey))),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () { activity.stopActivity(); Navigator.pop(ctx); },
            child: const Text("TERMINA"),
          ),
        ],
      ),
    );
  }
}