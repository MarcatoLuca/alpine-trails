import '../enums.dart';

class AppRoute {
  final PageName? pageName;
  final bool _isUnknown;

  AppRoute.splash() : pageName = PageName.splash, _isUnknown = false;

  AppRoute.login() : pageName = PageName.login, _isUnknown = false;

  AppRoute.home() : pageName = PageName.home, _isUnknown = false;

  AppRoute.contact() : pageName = PageName.contact, _isUnknown = false;

  AppRoute.about() : pageName = PageName.about, _isUnknown = false;

  AppRoute.services() : pageName = PageName.services, _isUnknown = false;

  AppRoute.unknown() : pageName = null, _isUnknown = true;

  //Used to get the current path
  bool get isHome => pageName == PageName.home;
  bool get isAbout => pageName == PageName.about;
  bool get isContact => pageName == PageName.contact;
  bool get isServices => pageName == PageName.services;
  bool get isSplash => pageName == PageName.splash;
  bool get isLogin => pageName == PageName.login;
  bool get isUnknown => _isUnknown;
}
