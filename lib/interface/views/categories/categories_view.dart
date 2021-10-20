import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stories/interface/widgets/creation_aware_list_item.dart';
import 'package:stories/interface/widgets/stories_search_widget.dart';
import 'package:stories/interface/widgets/story_widget.dart';
import 'package:stories/interface/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stories/interface/widgets/web_centered_widget.dart';

import 'categories_view_model.dart';

class CategoriessView extends StatelessWidget {
  final String category;
  final bool useAuthors;
  const CategoriessView({
    Key? key,
    required this.category,
    required this.useAuthors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CategoriesViewModel>.reactive(
      viewModelBuilder: () => CategoriesViewModel(),
      createNewModelOnInsert: true,
      onModelReady: (viewModel) =>
          viewModel.getCategoryStories(category, useAuthors),
      builder: (context, viewModel, child) {
        var stories = viewModel.categoryStories;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 25,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: TextWiget.headline3(category),
            actions: [
              IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: StoriesSearchWidget(
                      stories: stories,
                      readStory: viewModel.navigateToStory,
                      searchByChar: viewModel.searchByFirstChar,
                      searchLabel: AppLocalizations.of(context)!.search,
                    ),
                  );
                },
                icon: Icon(
                  Icons.search,
                  size: 24.0,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          body: viewModel.isBusy
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                      Theme.of(context).primaryColor,
                    ),
                    strokeWidth: 3,
                  ),
                )
              : stories.isEmpty
                  ? Center(
                      child: TextWiget.body(
                        AppLocalizations.of(context)!.notAvailable,
                      ),
                    )
                  : WebCenteredWidget(
                      child: ListView.builder(
                        itemCount: stories.length,
                        itemBuilder: (context, index) {
                          return CreationAwareListItem(
                            itemCreated: () {
                              if (index % 20 == 0) {
                                viewModel.requestMoreStories(
                                    category, useAuthors);
                              }
                            },
                            child: GestureDetector(
                              onTap: () =>
                                  viewModel.navigateToStory(stories[index]),
                              child: StoryWidget(story: stories[index]),
                            ),
                          );
                        },
                      ),
                    ),
        );
      },
    );
  }
}
