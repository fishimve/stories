import 'dart:async';

import 'package:connectivity/connectivity.dart';

import 'stoppable_service.dart';

class ConnectivityService extends StoppableService {
  var offlineStatusController = StreamController<bool>();

  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      offlineStatusController.add(_isOffline(result));
    });
  }

  bool _isOffline(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      return true;
    } else {
      return false;
    }
  }
}
