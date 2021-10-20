import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stories/models/story.dart';

import 'stoppable_service.dart';

class CategoriesService extends StoppableService {
  final _storiesRef = FirebaseFirestore.instance.collection('stories');
  final _storiesController = StreamController<List<Story>?>.broadcast();

  final _allPagedStoriesResults = [<Story>[]];

  static const storiesLimit = 20;

  DocumentSnapshot? _lastStoryDocument;
  bool _hasMoreStories = true;

  Stream listenToStoriesRealTime(
      List<String> languages, String tag, bool useAuthors) {
    _requestStories(languages, tag, useAuthors);
    return _storiesController.stream;
  }

  void _requestStories(List<String> languages, String tag, bool useAuthors) {
    var pageStoriesQuery = useAuthors
        ? _storiesRef
            .orderBy('rating', descending: true)
            .where('author', isEqualTo: tag)
            .where('language', whereIn: languages)
            .limit(storiesLimit)
        : _storiesRef
            .orderBy('rating', descending: true)
            .where('tags', arrayContains: tag)
            .where('language', whereIn: languages)
            .limit(storiesLimit);

    if (_lastStoryDocument != null) {
      pageStoriesQuery =
          pageStoriesQuery.startAfterDocument(_lastStoryDocument!);
    }

    if (!_hasMoreStories) return;

    var currentRequestIndex = _allPagedStoriesResults.length;

    pageStoriesQuery.snapshots().listen(
      (storiesSnapshot) {
        if (storiesSnapshot.docs.isNotEmpty) {
          var stories = storiesSnapshot.docs
              .map((snapshot) => Story.fromMap(snapshot.data()))
              .toList();

          var pageExists = currentRequestIndex < _allPagedStoriesResults.length;

          if (pageExists) {
            _allPagedStoriesResults[currentRequestIndex] = stories;
          } else {
            _allPagedStoriesResults.add(stories);
          }

          var allStories = _allPagedStoriesResults.fold<List<Story>>(
              <Story>[], (prev, element) => prev..addAll(element));

          // Broadcast all stories
          _storiesController.add(allStories);

          if (currentRequestIndex == _allPagedStoriesResults.length - 1) {
            _lastStoryDocument = storiesSnapshot.docs.last;
          }
          _hasMoreStories = stories.length == storiesLimit;
        } else {
          _storiesController.add(null);
        }
      },
    );
  }

  void requestMoreStories(
          List<String> languages, String tag, bool useAuthors) =>
      _requestStories(languages, tag, useAuthors);
}
