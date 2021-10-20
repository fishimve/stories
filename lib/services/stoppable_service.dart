import 'package:flutter/material.dart';

abstract class StoppableService {
  var _serviceStoped = false;
  bool get serviceStopped => _serviceStoped;

  @mustCallSuper
  void stopService() {
    _serviceStoped = true;
  }

  @mustCallSuper
  void startService() {
    _serviceStoped = false;
  }
}
