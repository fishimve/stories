import 'package:stacked/stacked.dart';
import 'package:stories/locator.dart';
import 'package:stories/services/connectivity_service.dart';

class ConnectionModel extends StreamViewModel<bool> {
  final _connectionService = locator<ConnectivityService>();

  // keep track of changing of network
  bool get offlineStatus => data!;

  @override
  Stream<bool> get stream => _connectionService.offlineStatusController.stream;
}
