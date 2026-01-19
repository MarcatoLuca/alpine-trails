import 'package:flutter/material.dart';
import '../enums.dart';

class PageNotifier extends ChangeNotifier {
  PageName? _pageName = PageName.home;
  bool _unknownPath = false;
  Object? _payload;
  bool _isInitializing = true;

  get pageName => _pageName;
  get isUnknown => _unknownPath;
  Object? get payload => _payload;
  bool get isInitializing => _isInitializing;

  void setInitializing(bool value) {
    _isInitializing = value;
    notifyListeners();
  }

  changePage({required PageName? page, required bool unknown, Object? payload,}) {
    _pageName = page;
    _unknownPath = unknown;
    _payload = payload;
    notifyListeners();
  }
  
}