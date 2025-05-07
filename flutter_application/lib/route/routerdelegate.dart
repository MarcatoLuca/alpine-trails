import 'package:flutter/material.dart';

import 'package:flutter_application/pages/services.dart';
import 'package:flutter_application/pages/about.dart';
import 'package:flutter_application/pages/contact.dart';
import 'package:flutter_application/pages/home.dart';
import 'package:flutter_application/pages/pagenotfound.dart';

import 'package:flutter_application/enums.dart';

import 'package:flutter_application/providers/pagenotifier.dart';

import 'package:flutter_application/route/routes.dart';

class AppRouterDelegate extends RouterDelegate<AppRoute>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoute> {
  final PageNotifier notifier;

  AppRouterDelegate({required this.notifier});

  final MaterialPage<void> homePage = MaterialPage<void>(child: HomePage());
  final MaterialPage<void> aboutPage = MaterialPage<void>(child: AboutPage());
  final MaterialPage<void> contactPage = MaterialPage<void>(
    child: ContactPage(),
  );
  final MaterialPage<void> servicePage = MaterialPage<void>(
    child: ServicesPage(),
  );

  @override
  GlobalKey<NavigatorState>? get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final List<Page<void>> pages = <Page<void>>[
      homePage,
      aboutPage,
      contactPage,
      servicePage,
    ];
    return Navigator(
      key: navigatorKey,
      pages: [
        if (notifier.isUnknown) const MaterialPage(child: PageNotFound()),
        if (!notifier.isUnknown) homePage,
        if (notifier.pageName == PageName.home) homePage,
        if (notifier.pageName == PageName.about) aboutPage,
        if (notifier.pageName == PageName.contact) contactPage,
        if (notifier.pageName == PageName.services) servicePage,
      ],
      onDidRemovePage: (page) => pages.remove(page),
    );
  }

  //currentConfiguration is called whenever there might be a change in route
  //It checks for the current page or route and return a new route information
  //This is what populates our browser history
  @override
  AppRoute? get currentConfiguration {
    if (notifier.isUnknown) {
      return AppRoute.unknown();
    }

    if (notifier.pageName == PageName.home) {
      return AppRoute.home();
    }

    if (notifier.pageName == PageName.about) {
      return AppRoute.about();
    }

    if (notifier.pageName == PageName.contact) {
      return AppRoute.contact();
    }

    if (notifier.pageName == PageName.services) {
      return AppRoute.services();
    }

    return AppRoute.unknown();
  }

  //This is called whenever the system detects a new route is passed
  //It checks the current route through the configuration and uses that to update the notifier
  @override
  Future<void> setNewRoutePath(AppRoute configuration) async {
    if (configuration.isUnknown) {
      _updateRoute(page: null, isUnknown: true);
    }

    if (configuration.isAbout) {
      _updateRoute(page: PageName.about);
    }

    if (configuration.isContact) {
      _updateRoute(page: PageName.contact);
    }

    if (configuration.isServices) {
      _updateRoute(page: PageName.services);
    }

    if (configuration.isHome) {
      _updateRoute(page: PageName.home);
    }
  }

  _updateRoute({PageName? page, bool isUnknown = false}) {
    notifier.changePage(page: page, unknown: isUnknown);
  }
}
