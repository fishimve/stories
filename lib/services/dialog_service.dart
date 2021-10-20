import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:stories/models/dialog.dart';
import 'stoppable_service.dart';

class DialogService extends StoppableService {
  final _dialogNavigationKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get dialogNavigationKey => _dialogNavigationKey;

  late Function _showDialogListener;
  late Completer<DialogResponse>? _dialogCompleter;

  void registerDialogListener(Function(DialogRequest) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  Future<DialogResponse>? showDialog({
    required String title,
    required String description,
    required String buttonTitle,
  }) {
    _dialogCompleter = Completer<DialogResponse>();
    _showDialogListener(DialogRequest(
        title: title, description: description, buttonTitle: buttonTitle));
    return _dialogCompleter!.future;
  }

  Future<DialogResponse>? showConfirmationDialog({
    required String title,
    required String description,
    required String confirmation,
    required String cancel,
  }) {
    _dialogCompleter = Completer<DialogResponse>();
    _showDialogListener(DialogRequest(
        title: title,
        description: description,
        buttonTitle: confirmation,
        cancelTitle: cancel));

    return _dialogCompleter!.future;
  }

  void dialogComplete(DialogResponse response) {
    _dialogNavigationKey.currentState!.pop();
    _dialogCompleter!.complete(response);
    _dialogCompleter = null;
  }
}
