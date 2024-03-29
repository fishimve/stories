import 'package:flutter/material.dart';

import 'stoppable_service.dart';

class NavigationService extends StoppableService {
  final _navigationKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateReplaceTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  void pop() {
    return _navigationKey.currentState!.pop();
  }
}
