import 'package:stacked/stacked.dart';
import 'package:stories/locator.dart';
import 'package:stories/models/language.dart';

import 'firestore_service.dart';
import 'localstorage_service.dart';
import 'stoppable_service.dart';

class LanguagesService extends StoppableService with ReactiveServiceMixin {
  final _storageService = locator<LocalStorageService>();
  final _firestoreService = locator<FirestoreService>();

  final _reactiveList = ReactiveList<String>();
  List<String> get selectedLanguages => _reactiveList;

  final _allLanguages = <Language>[];
  List<Language> get allLanguages => _allLanguages;

  LanguagesService() {
    listenToReactiveValues([_reactiveList]);
  }

  Future<void> initSetup() async {
    final _allLangs = await _firestoreService.getAllLanguages();
    _allLanguages.addAll(_allLangs);

    final langs = _storageService.getStringListFromDisk('userLanguages');
    if (langs.isEmpty) {
      _reactiveList.add('English');
    } else {
      _reactiveList.addAll(langs);
    }
  }

  void saveSelectedLanguages(Set<String> selected) async {
    final _l = [...selected];
    _reactiveList.clear();
    _reactiveList.addAll(_l);
    await _storageService.saveStringListToDisk('userLanguages', selected);
  }
}
