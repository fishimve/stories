import 'package:flutter/material.dart';
import 'package:stories/interface/shared/ui_helpers.dart';
import 'package:stories/interface/widgets/text_widget.dart';
import 'package:stories/models/story.dart';

class StoryWidget extends StatelessWidget {
  final Story story;

  const StoryWidget({
    Key? key,
    required this.story,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: null,
      color: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          StoryTitleWidget(title: story.title),
          StoryContent(content: story.content),
          if (story.author != '') StoryAuthorWidget(author: story.author),
          StoryTagsWidget(
            tags: story.tags,
            language: story.language,
          ),
          verticalSpaceSmall,
          // const Divider(
          //   thickness: 0,
          //   height: 1,
          // ),
        ],
      ),
    );
  }
}

class StoryTitleWidget extends StatelessWidget {
  const StoryTitleWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextWiget.headline3(title),
      ),
    );
  }
}

class StoryAuthorWidget extends StatelessWidget {
  const StoryAuthorWidget({
    Key? key,
    required this.author,
  }) : super(key: key);

  final String author;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextWiget.caption(author),
      ),
    );
  }
}

class StoryContent extends StatelessWidget {
  final String content;
  const StoryContent({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final summary = content.length < 80
        ? content
        : content.substring(0, 80).endsWith('\n')
            ? content.substring(0, 79) + '\u2026\u0020'
            : content.substring(0, 80) + '\u2026\u0020';
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: TextWiget.body(summary),
      ),
    );
  }
}

class StoryTagsWidget extends StatelessWidget {
  const StoryTagsWidget({
    Key? key,
    required this.tags,
    required this.language,
  }) : super(key: key);

  final List<String> tags;
  final String language;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextWiget.caption('$language - ${tags.join(', ')}'),
      ),
    );
  }
}
