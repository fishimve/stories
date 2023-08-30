import 'package:flutter/material.dart';
import 'package:stories/locator.dart';
import 'package:stories/services/categories_service.dart';
import 'package:stories/services/connectivity_service.dart';
import 'package:stories/services/favorites_service.dart';
import 'package:stories/services/firestore_service.dart';
import 'package:stories/services/languages_service.dart';
import 'package:stories/services/localstorage_service.dart';

/// Stop and start long running services
class LifeCycleManager extends StatefulWidget {
  final Widget child;
  const LifeCycleManager({Key? key, required this.child}) : super(key: key);

  @override
  _LifeCycleManagerState createState() => _LifeCycleManagerState();
}

class _LifeCycleManagerState extends State<LifeCycleManager>
    with WidgetsBindingObserver {
  final servicesToManage = [
    locator<FirestoreService>(),
    locator<ConnectivityService>(),
    locator<LocalStorageService>(),
    locator<CategoriesService>(),
    locator<LanguagesService>(),
    locator<FavoritesService>(),
  ];

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    for (var service in servicesToManage) {
      if (state == AppLifecycleState.resumed) {
        service.startService();
      } else {
        service.stopService();
      }
    }
  }
}
