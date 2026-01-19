import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application/providers/pagenotifier.dart';
import 'package:flutter_application/services/domain/auth.service.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Animazione di apparizione del logo
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final pageNotifier = Provider.of<PageNotifier>(context, listen: false);

    await Future.wait([
      authService.tryAutoLogin(),
      Future.delayed(
        const Duration(seconds: 2),
      ), // Tempo minimo di visualizzazione
    ]);

    pageNotifier.setInitializing(false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. IMMAGINE DI SFONDO (Usa una delle immagini delle Dolomiti)
          Image.network(
            'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?q=80&w=2070',
            fit: BoxFit.cover,
          ),

          // 2. OVERLAY GRADIENTE (Per scurire lo sfondo e far risaltare il logo)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.brown.shade900.withOpacity(0.8),
                ],
              ),
            ),
          ),

          // 3. CONTENUTO CENTRALE ANIMATO
          FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icona stilizzata
                const Icon(
                  Icons.terrain_rounded,
                  size: 100,
                  color: Colors.white,
                ),
                const SizedBox(height: 16),
                // Titolo
                const Text(
                  "ALPINE TRAILS",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 6,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                // Sottotitolo
                Text(
                  "Esplora l'ignoto",
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 2,
                    color: Colors.white.withOpacity(0.7),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),

          // 4. INDICATORE DI CARICAMENTO IN BASSO
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Column(
              children: [
                const SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Preparazione dei sentieri...",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 12,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
