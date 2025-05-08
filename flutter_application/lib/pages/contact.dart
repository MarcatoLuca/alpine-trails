import 'package:flutter/material.dart';
import 'package:flutter_application/widgets/useravatarmenu.dart';

import '../widgets/navbar.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
        child: Stack(
          children: [
            Column(spacing: 32, children: [
              
              ],
            ),

            // Alwasy last Stack widget
            UserAvatarMenuWidget(),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(index: 1),
    );
  }
}
