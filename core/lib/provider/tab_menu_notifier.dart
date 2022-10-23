import 'package:flutter/material.dart';

import '../core.dart';

class TabMenuNotifier extends ChangeNotifier {
  var _currentMenuTab = MenuTabState.Movie;

  MenuTabState get currentMenuTab => _currentMenuTab;

  set currentMenuTab(MenuTabState menu) {
    _currentMenuTab = menu;
    notifyListeners();
  }
}
