import 'package:flutter/material.dart';
import '../enums.dart';

class PageNotifier extends ChangeNotifier {
  PageName? _pageName = PageName.home;
  bool _unknownPath = false;
  Object? _payload;

  get pageName => _pageName;
  get isUnknown => _unknownPath;
  Object? get payload => _payload;

  changePage({required PageName? page, required bool unknown, Object? payload,}) {
    _pageName = page;
    _unknownPath = unknown;
    _payload = payload;
    notifyListeners();
  }
}