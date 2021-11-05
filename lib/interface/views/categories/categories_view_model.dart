import 'dart:async';

import 'package:stacked/stacked.dart';
import 'package:stories/locator.dart';
import 'package:stories/models/story.dart';
import 'package:stories/routes/route_names.dart';
import 'package:stories/services/categories_service.dart';
import 'package:stories/services/firestore_service.dart';
import 'package:stories/services/languages_service.dart';
import 'package:stories/services/navigation_service.dart';

class CategoriesViewModel extends BaseViewModel {
  final _firestoreService = locator<FirestoreService>();
  final _navigationService = locator<NavigationService>();
  final _categoriesService = locator<CategoriesService>();
  final _languagesService = locator<LanguagesService>();

  Set<String> get selectedLanguages => _languagesService.selectedLanguages;

  final _categoryStories = <Story>[];
  List<Story> get categoryStories => _categoryStories;

  Future<List<Story>> searchByFirstChar(String query) async {
    List<Story> results =
        await _firestoreService.getStoriesStartBy(selectedLanguages, query);
    return results;
  }

  Future<void> getCategoryStories(String category, bool useAuthors) async {
    setBusy(true);
    await _languagesService.initSetup();
    _listenToStories(category, useAuthors);
  }

  void _listenToStories(String category, bool useAuthors) async {
    setBusy(true);

    _categoriesService
        .listenToStoriesRealTime(selectedLanguages, category, useAuthors)
        .listen((storiesData) {
      List<Story>? updatedStories = storiesData;
      if (updatedStories != null && updatedStories.isNotEmpty) {
        _categoryStories.addAll(updatedStories);
        notifyListeners();
      }
      setBusy(false);
    });
  }

  void requestMoreStories(String category, bool useAuthors) =>
      _categoriesService.requestMoreStories(
          selectedLanguages, category, useAuthors);

  void navigateToStory(Story story) async {
    await _navigationService.navigateTo(
      storyViewRoute,
      arguments: story,
    );
  }
}
