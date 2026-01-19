import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application/services/domain/auth.service.dart';
import 'package:provider/provider.dart';

class UserAvatarMenuWidget extends StatelessWidget {
  const UserAvatarMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showProfileMenu(context),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: CircleAvatar(
          radius: 24,
          backgroundColor: Colors.brown.shade700,
          child: const Icon(Icons.person_rounded, color: Colors.white, size: 24),
        ),
      ),
    );
  }

  void _showProfileMenu(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Chiudi",
      barrierColor: Colors.transparent, // Niente sfondo nero pesante
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
      transitionBuilder: (context, anim1, anim2, child) {
        return Stack(
          children: [
            // Area cliccabile per chiudere (fuori dal menu)
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(color: Colors.black.withOpacity(0.1)),
            ),
            
            // IL MENU VERO E PROPRIO
            Positioned(
              top: 70, // Sotto l'avatar
              right: 20, // Allineato all'avatar
              child: FadeTransition(
                opacity: anim1,
                child: ScaleTransition(
                  scale: CurvedAnimation(parent: anim1, curve: Curves.easeOutBack),
                  alignment: Alignment.topRight, // L'animazione parte dall'avatar
                  child: _buildMenuCard(context, authService),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMenuCard(BuildContext context, AuthService authService) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: 250,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: Colors.white.withOpacity(0.4)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
              )
            ],
          ),
          child: Material( // Necessario per l'effetto splash dei tasti
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // HEADER UTENTE
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.brown.shade100,
                        child: const Icon(Icons.person, color: Colors.brown),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Ciao!", style: TextStyle(fontSize: 12, color: Colors.black54)),
                            Text("Il mio Profilo", 
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.brown)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                const Divider(height: 1),

                // AZIONI MENU
                _menuAction(Icons.account_circle_outlined, "Profilo", () {}),
                _menuAction(Icons.settings_outlined, "Impostazioni", () {}),
                
                const Divider(height: 1),

                // LOGOUT (Rosso)
                _menuAction(
                  Icons.logout_rounded, 
                  "Esci", 
                  () async {
                    Navigator.pop(context);
                    await authService.logout();
                  },
                  isDanger: true
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuAction(IconData icon, String title, VoidCallback onTap, {bool isDanger = false}) {
    final color = isDanger ? Colors.red.shade700 : Colors.brown.shade900;
    return ListTile(
      leading: Icon(icon, color: color, size: 22),
      title: Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 15)),
      onTap: onTap,
      visualDensity: VisualDensity.compact,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    );
  }
}