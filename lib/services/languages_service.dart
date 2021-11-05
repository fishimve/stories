import 'package:stories/locator.dart';
import 'package:stories/models/language.dart';

import 'firestore_service.dart';
import 'localstorage_service.dart';
import 'stoppable_service.dart';

class LanguagesService extends StoppableService {
  final _storageService = locator<LocalStorageService>();
  final _firestoreService = locator<FirestoreService>();

  final _selectedLanguages = <String>{};
  Set<String> get selectedLanguages => _selectedLanguages;

  final _allLanguages = <Language>{};
  Set<Language> get allLanguages => _allLanguages;
  Set<String> get allLanguagesStrings =>
      _allLanguages.map((l) => l.title).toSet();

  Future<void> initSetup() async {
    final _allLangs = await _firestoreService.getAllLanguages();
    _allLanguages.clear();
    _allLanguages.addAll(_allLangs);

    final langs = _storageService.getStringListFromDisk('userLanguages');
    if (langs.isEmpty) {
      _selectedLanguages.add('English');
    } else {
      _selectedLanguages.addAll(langs);
    }
  }

  void saveSelectedLanguages(Set<String> selected) async {
    final _l = [...selected];
    _selectedLanguages.clear();
    _selectedLanguages.addAll(_l);
    await _storageService.saveStringListToDisk('userLanguages', selected);
  }
}
