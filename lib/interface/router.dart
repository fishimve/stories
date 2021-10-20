import 'package:flutter/material.dart';
import 'package:stories/interface/views/categories/categories_view.dart';
import 'package:stories/models/story.dart';
import 'package:stories/routes/route_names.dart';

import 'views/story/story_view.dart';

PageRoute _pageRoute({required String routeName, required Widget view}) {
  return MaterialPageRoute(
    settings: RouteSettings(name: routeName),
    builder: (_) => view,
  );
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case storyViewRoute:
      final story = settings.arguments as Story;
      return _pageRoute(
        routeName: settings.name!,
        view: StoryView(story: story),
      );
    case categoryViewRoute:
      final category = settings.arguments as Map<String, dynamic>;
      return _pageRoute(
        routeName: settings.name!,
        view: CategoriessView(
            category: category['category'], useAuthors: category['useAuthors']),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
              child: Container(
            height: 50,
            width: 50,
            color: Colors.red.shade300,
          )),
        ),
      );
  }
}
