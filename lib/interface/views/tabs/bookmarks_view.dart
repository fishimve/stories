import 'package:flutter/material.dart';
import 'package:stories/interface/widgets/story_widget.dart';
import 'package:stories/interface/widgets/text_widget.dart';
import 'package:stories/interface/widgets/web_centered_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'tabs_view_model.dart';

class BookmarksView extends StatefulWidget {
  final TabsViewModel viewModel;

  const BookmarksView({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<BookmarksView> createState() => _BookmarksViewState();
}

class _BookmarksViewState extends State<BookmarksView>
    with AutomaticKeepAliveClientMixin {
  // keep scrolling state
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var favorites = widget.viewModel.favoriteStories;

    if (favorites.isEmpty) {
      return Center(
        child: TextWiget.body(
          AppLocalizations.of(context)!.bookmarksEmpty,
        ),
      );
    } else {
      return WebCenteredWidget(
        child: ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => widget.viewModel.navigateToStoryView(
              widget.viewModel.favoriteStories[index],
            ),
            child: StoryWidget(
              story: widget.viewModel.favoriteStories[index],
            ),
          ),
        ),
      );
    }
  }
}
