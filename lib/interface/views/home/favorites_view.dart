import 'package:flutter/material.dart';
import 'package:stories/interface/widgets/story_widget.dart';
import 'package:stories/interface/widgets/web_centered_widget.dart';

import 'home_view_model.dart';

class FavoritesView extends StatefulWidget {
  final HomeViewModel viewModel;

  const FavoritesView({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView>
    with AutomaticKeepAliveClientMixin {
  // keep scrolling state
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WebCenteredWidget(
      child: ListView.builder(
        itemCount: widget.viewModel.favoriteStories.length,
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
