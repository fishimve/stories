import 'package:stacked/stacked.dart';
import 'package:stories/locator.dart';
import 'package:stories/models/language.dart';
import 'package:stories/models/story.dart';
import 'package:stories/routes/route_names.dart';
import 'package:stories/services/favorites_service.dart';
import 'package:stories/services/firestore_service.dart';
import 'package:stories/services/languages_service.dart';
import 'package:stories/services/navigation_service.dart';

class TabsViewModel extends ReactiveViewModel {
  final _languagesService = locator<LanguagesService>();
  final _favoritesService = locator<FavoritesService>();
  final _firestoreService = locator<FirestoreService>();
  final _navigationService = locator<NavigationService>();

  Set<String> get selectedLanguages => _languagesService.selectedLanguages;
  Set<Language> get _allLanguages => _languagesService.allLanguages;
  List<Story> get favoriteStories => _favoritesService.favoritedStories;

  final _stories = <Story>[];
  List<Story> get stories => _stories;

  final _authors = <String>{};
  List<String> get authors => _authors.toList();

  final _categories = <String>{};
  List<String> get categories => _categories.toList()..sort();

  Future<void> getTagsAndStories() async {
    await _languagesService.initSetup();
    await _favoritesService.initSetup();
    _setTagsAndAuthors();
    _listenToStories();
  }

  void _setTagsAndAuthors() {
    setBusy(true);
    final langs = _allLanguages
        .where((l) => selectedLanguages.contains(l.title))
        .toList();
    final categories = langs
        .map((l) => l.storiesTags)
        .toList()
        .fold<List<String>>([], (curr, next) => [...curr, ...next]).toSet();

    final authors = langs
        .map((l) => l.authors)
        .toList()
        .fold<List<String>>([], (curr, next) => [...curr, ...next]).toSet();
    _categories.clear();
    _categories.addAll(categories);
    _authors.clear();
    _authors.addAll(authors);
    notifyListeners();
    setBusy(false);
  }

  void _listenToStories() async {
    setBusy(true);
    _firestoreService
        .listenToStoriesRealTime(selectedLanguages)
        .listen((storiesData) {
      List<Story>? updatedStories = storiesData;
      if (updatedStories != null && updatedStories.isNotEmpty) {
        _stories.addAll(updatedStories);
        notifyListeners();
      }
      setBusy(false);
    });
  }

  void requestMoreStories() =>
      _firestoreService.requestMoreStories(selectedLanguages);

  void navigateToStoryView(Story story) async {
    await _navigationService.navigateTo(storyViewRoute, arguments: story);
    notifyListeners();
  }

  Future<List<Story>> searchByFirstChar(String query) async {
    List<Story> results =
        await _firestoreService.getStoriesStartBy(selectedLanguages, query);
    return results;
  }

  void navigateToCategoryView(String category,
      [bool useAuthors = false]) async {
    await _navigationService.navigateTo(
      categoryViewRoute,
      arguments: {'category': category, 'useAuthors': useAuthors},
    );
    notifyListeners();
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_favoritesService];
}
