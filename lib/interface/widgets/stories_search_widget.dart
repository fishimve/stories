import 'package:flutter/material.dart';
import 'package:stories/interface/widgets/story_widget.dart';
import 'package:stories/interface/widgets/text_widget.dart';
import 'package:stories/models/story.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StoriesSearchWidget extends SearchDelegate<Story?> {
  final String searchLabel;
  final List<Story> stories;
  final Function(Story) readStory;
  final Function(String) searchByChar;

  StoriesSearchWidget({
    required this.searchByChar,
    required this.readStory,
    required this.stories,
    required this.searchLabel,
  });

  var tempStories = <Story>[];

  @override
  String get searchFieldLabel => searchLabel;

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      inputDecorationTheme:
          const InputDecorationTheme(border: InputBorder.none),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: Theme.of(context).primaryColor,
          size: 25.0,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Theme.of(context).primaryColor,
        size: 25.0,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Story>>(
      future: searchByChar(query.trim()),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(
                Theme.of(context).primaryColor,
              ),
              strokeWidth: 3,
            ),
          );
        } else {
          {
            if (snapshot.data != null && snapshot.data!.isEmpty) {
              Center(
                child: TextWiget.body(
                  AppLocalizations.of(context)!.notAvailable,
                ),
              );
            }

            List<Story> queryResults = snapshot.data ?? [];
            tempStories = queryResults
                .where(
                  (a) => a.title.toLowerCase().contains(query.toLowerCase()),
                )
                .toList();

            return ListView.builder(
              itemCount: tempStories.length,
              itemBuilder: (context, index) {
                var a = tempStories[index];
                return GestureDetector(
                  onTap: () async {
                    await readStory(a);
                    close(context, a);
                  },
                  child: StoryWidget(story: a),
                );
              },
            );
          }
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    tempStories = stories
        .where((a) => a.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: tempStories.length,
      itemBuilder: (context, index) {
        var a = tempStories[index];
        return GestureDetector(
          onTap: () async {
            await readStory(a);
            close(context, a);
          },
          child: StoryWidget(story: a),
        );
      },
    );
  }
}
