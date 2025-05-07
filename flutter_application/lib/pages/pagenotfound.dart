import 'package:flutter/material.dart';


class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [Image.asset("images/lake.jpg", fit: BoxFit.cover)],
      ),
    );
  }
}
