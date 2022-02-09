import 'package:stacked/stacked.dart';
import 'package:stories/locator.dart';
import 'package:stories/routes/route_names.dart';
import 'package:stories/services/connectivity_service.dart';
import 'package:stories/services/languages_service.dart';
import 'package:stories/services/navigation_service.dart';

class HomeViewModel extends BaseViewModel {
  final _languagesService = locator<LanguagesService>();
  final _navigationService = locator<NavigationService>();

  List<String> get allLanguagesStrings =>
      _languagesService.allLanguagesStrings.toList()..sort();
  Set<String> get selectedLanguages => _languagesService.selectedLanguages;

  Future<void> setLanguages() async {
    setBusy(true);
    await _languagesService.initSetup();
    setBusy(false);
  }

  void toggleLanguageSelection(String lang) async {
    setBusy(true);
    final _selected = {...selectedLanguages};
    if (!selectedLanguages.contains(lang)) {
      _selected.add(lang);
      _languagesService.saveSelectedLanguages(_selected.toSet());
    } else {
      if (_selected.length == 1) {
        return;
      }
      _selected.remove(lang);
      _languagesService.saveSelectedLanguages(_selected.toSet());
    }
    await _navigationService.navigateReplaceTo(tabsViewRoute);
    setBusy(false);
  }
}

class ConnectionModel extends StreamViewModel<bool> {
  final _connectionService = locator<ConnectivityService>();

  // keep track of changing of network
  bool get offlineStatus => data!;

  @override
  Stream<bool> get stream => _connectionService.offlineStatusController.stream;
}
