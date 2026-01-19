import 'package:flutter/material.dart';
import 'package:flutter_application/pages/login.dart';

import 'package:flutter_application/pages/services.dart';
import 'package:flutter_application/pages/about.dart';
import 'package:flutter_application/pages/contact.dart';
import 'package:flutter_application/pages/home.dart';
import 'package:flutter_application/pages/pagenotfound.dart';

import 'package:flutter_application/enums.dart';
import 'package:flutter_application/pages/sub/splashscreen.dart';

import 'package:flutter_application/providers/pagenotifier.dart';

import 'package:flutter_application/route/routes.dart';
import 'package:flutter_application/services/domain/auth.service.dart';

class AppRouterDelegate extends RouterDelegate<AppRoute>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoute> {
  final PageNotifier notifier;
  final AuthService authService;
  final MaterialPage<void> homePage = MaterialPage<void>(child: HomePage());
  final MaterialPage<void> aboutPage = MaterialPage<void>(child: AboutPage());
  final MaterialPage<void> contactPage = MaterialPage<void>(
    child: ContactPage(),
  );
  final MaterialPage<void> servicePage = MaterialPage<void>(
    child: ServicesPage(),
  );
  final MaterialPage<void> splashScreen = MaterialPage<void>(
    child: SplashScreen(),
  );

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  AppRouterDelegate({required this.notifier, required this.authService})
    : navigatorKey = GlobalKey<NavigatorState>() {
    notifier.addListener(notifyListeners);
    authService.addListener(notifyListeners);
  }

  @override
  void dispose() {
    notifier.removeListener(notifyListeners);
    authService.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Page<void>> pages = <Page<void>>[
      homePage,
      aboutPage,
      contactPage,
      servicePage,
      splashScreen,
    ];

    return Navigator(
      key: navigatorKey,
      pages: [
        if (notifier.isInitializing)
          const MaterialPage(key: ValueKey('Splash'), child: SplashScreen())
        else if (!authService.isLoggedIn)
          const MaterialPage(key: ValueKey('Login'), child: LoginScreen())
        else ...[
          MaterialPage(key: const ValueKey('Home'), child: HomePage()),

          if (notifier.pageName == PageName.about)
            MaterialPage(key: ValueKey('About'), child: AboutPage()),

          if (notifier.pageName == PageName.contact)
            const MaterialPage(key: ValueKey('Contact'), child: ContactPage()),

          if (notifier.pageName == PageName.services)
            const MaterialPage(
              key: ValueKey('Services'),
              child: ServicesPage(),
            ),

          // Errore 404
          if (notifier.isUnknown)
            const MaterialPage(key: ValueKey('Unknown'), child: PageNotFound()),
        ],
      ],
      onDidRemovePage: (page) => pages.remove(page),
    );
  }

  @override
  AppRoute? get currentConfiguration {
    if (notifier.isInitializing)
      return null; // Non mostrare URL durante il caricamento
    if (notifier.isUnknown) return AppRoute.unknown();
    if (notifier.pageName == PageName.about) return AppRoute.about();
    if (notifier.pageName == PageName.contact) return AppRoute.contact();
    if (notifier.pageName == PageName.services) return AppRoute.services();
    return AppRoute.home();
  }

  @override
  Future<void> setNewRoutePath(AppRoute configuration) async {
    if (notifier.isInitializing) {
      return;
    }

    if (configuration.isUnknown) {
      _updateRoute(page: null, isUnknown: true);
    } else if (configuration.isSplash) {
      _updateRoute(page: PageName.splash);
    } else if (configuration.isAbout) {
      _updateRoute(page: PageName.about);
    } else if (configuration.isContact) {
      _updateRoute(page: PageName.contact);
    } else if (configuration.isServices) {
      _updateRoute(page: PageName.services);
    } else {
      _updateRoute(page: PageName.home);
    }
  }

  void _updateRoute({PageName? page, bool isUnknown = false}) {
    notifier.changePage(page: page, unknown: isUnknown);
  }
}
