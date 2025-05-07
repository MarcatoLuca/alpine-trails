import 'package:flutter/material.dart';

import '../widgets/navbar.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: MediaQuery.of(context).size.height * 0.15,
              bottom: 20.0,
            ),
            child: Image.asset("images/lake.jpg", fit: BoxFit.cover),
          ),
        ],
      ),
      bottomNavigationBar: NavBar(index: 2),
    );
  }
}
