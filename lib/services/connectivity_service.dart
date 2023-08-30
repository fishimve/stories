import 'dart:async';


import 'package:connectivity_plus/connectivity_plus.dart';

import 'stoppable_service.dart';

class ConnectivityService extends StoppableService {
  final offlineStatusController = StreamController<bool>.broadcast();

  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      offlineStatusController.add(_isOffline(result));
    });
  }

  void cancelListening() {
    offlineStatusController.close();
  }

  bool _isOffline(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      return true;
    } else {
      return false;
    }
  }
}
