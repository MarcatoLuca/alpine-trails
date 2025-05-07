import 'package:flutter/material.dart';
import 'package:flutter_application/enums.dart';
import 'package:flutter_application/route/routes.dart';

class AppRouteInformationParser extends RouteInformationParser<AppRoute> {
  Uri? _unknownPath;

  @override
  Future<AppRoute> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    final uri = routeInformation.uri;

    if (uri.pathSegments.isEmpty) {
      return AppRoute.home();
    }

    //If path includes more than one segement, go to 404
    if (uri.pathSegments.length > 1) {
      _unknownPath = routeInformation.uri;
      return AppRoute.unknown();
    }

    if (uri.pathSegments.length == 1) {
      if (uri.pathSegments.first == PageName.about.name) {
        return AppRoute.about();
      }

      if (uri.pathSegments.first == PageName.contact.name) {
        return AppRoute.contact();
      }

      if (uri.pathSegments.first == PageName.services.name) {
        return AppRoute.services();
      }
    }

    _unknownPath = uri;
    return AppRoute.unknown();
  }

  @override
  RouteInformation? restoreRouteInformation(AppRoute configuration) {
    if (configuration.isAbout) {
      return _getRouteInformation(configuration.pageName!.name);
    }

    if (configuration.isUnknown) {
      return RouteInformation(uri: _unknownPath);
    }

    if (configuration.isContact) {
      return _getRouteInformation(configuration.pageName!.name);
    }

    if (configuration.isServices) {
      return _getRouteInformation(configuration.pageName!.name);
    }

    return RouteInformation(uri: Uri.parse('/'));
  }

  //Get Route Information depending on the PageName passed
  RouteInformation _getRouteInformation(String page) {
    return RouteInformation(uri: Uri.parse('/$page'));
  }
}
