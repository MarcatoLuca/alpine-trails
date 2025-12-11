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
      pageBuilder: (context, animation, secondaryAnimation) => Explore(),
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
    return Scaffold(
      body: StickyContainer(
        stickyChildren: [
          StickyWidget(
            initialPosition: StickyPosition(top: 20, right: 20),
            finalPosition: StickyPosition(top: 20, right: 20),
            controller: _controller,
            child: UserAvatarMenuWidget(),
          ),
        ],
        child: SingleChildScrollView(
          controller: _controller,
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
          child: Column(
            spacing: 32,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 96),
                  child: Column(
                    spacing: 8,
                    children: [
                      Text(
                        'Welcome on',
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Alpine Trails',
                        style: Theme.of(context).textTheme.displayMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              Center(
                child: Text(
                  'Your ultimate guide to exploring the wonders of the Dolomites',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 32, bottom: 32),
                child: FilledButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(_createRoute());
                  },
                  label: const Text('Explore'),
                  icon: const Icon(Icons.explore),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 32,
                    ),
                  ),
                ),
              ),

              Carousel(images: constants.homeCarouselImages),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBar(index: 0),
    );
  }
}
