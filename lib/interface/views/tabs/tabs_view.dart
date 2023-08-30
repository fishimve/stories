import 'package:tuple/tuple.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'authors_view.dart';
import 'bookmarks_view.dart';
import 'stories_view.dart';
import 'tabs_view_model.dart';

class TabsView extends StatelessWidget {
  const TabsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TabsViewModel>.reactive(
      onViewModelReady: (viewModel) => viewModel.getTagsAndStories(),
      viewModelBuilder: () => TabsViewModel(),
      createNewViewModelOnInsert: true,
      builder: (context, viewModel, child) {
        final tabbedViews = [
          Tuple2(
            AppLocalizations.of(context)!.stories,
            StoriesView(viewModel: viewModel),
          ),
          Tuple2(
            AppLocalizations.of(context)!.authors,
            AuthorsView(viewModel: viewModel),
          ),
          Tuple2(
            AppLocalizations.of(context)!.bookmarks,
            BookmarksView(viewModel: viewModel),
          ),
        ];
        return DefaultTabController(
          length: tabbedViews.length,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).colorScheme.background,
              elevation: 0,
              titleSpacing: 0,
              title: TabBar(
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 3.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  insets: const EdgeInsets.symmetric(horizontal: 110.0),
                ),
                tabs: tabbedViews
                    .map<Tab>(
                      (Tuple2 tab) => Tab(text: tab.item1),
                    )
                    .toList(),
              ),
            ),
            body: TabBarView(
              children: tabbedViews
                  .map<Widget>(
                    (Tuple2 page) => page.item2,
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
