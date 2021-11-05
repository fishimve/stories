import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:stories/models/language.dart';
import 'package:stories/models/story.dart';

import 'stoppable_service.dart';

class FirestoreService extends StoppableService {
  final _metadataRef = FirebaseFirestore.instance.collection('metadata');
  final _storiesRef = FirebaseFirestore.instance.collection('stories');
  final _indexedRef = FirebaseFirestore.instance.collection('indexedStories');

  final _storiesController = StreamController<List<Story>>.broadcast();

  final allStoriesResultsList = [<Story>[]];

  static const storiesLimit = 20;

  DocumentSnapshot? _lastDocument;
  bool _hasMorestories = true;

  Stream listenToStoriesRealTime(Set<String> languages) {
    _requestStories(languages);
    return _storiesController.stream;
  }

  Future<void> _requestStories(Set<String> languages) async {
    var storiesQuery = _storiesRef
        .orderBy('rating', descending: true)
        .where('language', whereIn: languages.toList())
        .limit(storiesLimit);

    if (_lastDocument != null) {
      storiesQuery = storiesQuery.startAfterDocument(_lastDocument!);
    }

    if (!_hasMorestories) return;

    var currentRequestIndex = allStoriesResultsList.length;

    storiesQuery.snapshots().listen(
      (storiesSnapshot) {
        if (storiesSnapshot.docs.isNotEmpty) {
          var stories = storiesSnapshot.docs
              .map((snapshot) => Story.fromMap(snapshot.data()))
              .where(
                (mappedItem) =>
                    mappedItem.title != '-' && mappedItem.content != '-',
              )
              .toList();

          var pageExists = currentRequestIndex < allStoriesResultsList.length;

          if (pageExists) {
            allStoriesResultsList[currentRequestIndex] = stories;
          } else {
            allStoriesResultsList.add(stories);
          }

          var allStories = allStoriesResultsList.fold<List<Story>>(
              <Story>[], (prev, element) => prev..addAll(element));

          // Broadcast all stories
          _storiesController.add(allStories);

          if (currentRequestIndex == allStoriesResultsList.length - 1) {
            _lastDocument = storiesSnapshot.docs.last;
          }
          _hasMorestories = stories.length == storiesLimit;
        }
      },
    );
  }

  void requestMoreStories(Set<String> languages) => _requestStories(languages);

  Future getAllLanguages() async {
    try {
      var languagesDoc = await _metadataRef.doc('languages').get();

      if (languagesDoc.exists) {
        var langs = languagesDoc
            .data()!
            .entries
            .map((d) => Language.fromMap(d.value))
            .toList();
        return langs;
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future getFavoriteStory(String id) async {
    try {
      final docSnapshot = await _storiesRef.doc(id).get();
      if (docSnapshot.exists) {
        return Story.fromMap(docSnapshot.data()!);
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future getStoriesStartBy(Set<String> languages, String startChar) async {
    try {
      var storiesDocsSnapshot = await _indexedRef
          .doc(startChar[0].toUpperCase())
          .collection('${startChar[0].toUpperCase()}_Stories')
          .orderBy('title')
          .get();

      if (storiesDocsSnapshot.docs.isNotEmpty) {
        return storiesDocsSnapshot.docs
            .map((snapshot) => Story.fromMap(snapshot.data()))
            .toList();
      } else {
        return <Story>[];
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }
}
