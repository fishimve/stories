import 'package:tuple/tuple.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:stories/interface/shared/ui_helpers.dart';
import 'package:stories/interface/views/home/authors_view.dart';
import 'package:stories/interface/views/home/favorites_view.dart';
import 'package:stories/interface/views/home/stories_view.dart';
import 'package:stories/interface/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'connection_model.dart';
import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onModelReady: (viewModel) => viewModel.getTagsAndStories(),
      viewModelBuilder: () => HomeViewModel(),
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
            AppLocalizations.of(context)!.favorites,
            FavoritesView(viewModel: viewModel),
          ),
        ];
        return DefaultTabController(
          length: tabbedViews.length,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).backgroundColor,
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
            body: ViewModelBuilder<ConnectionModel>.reactive(
              viewModelBuilder: () => ConnectionModel(),
              builder: (context, connectionModel, child) => Column(
                children: [
                  Expanded(
                    child: TabBarView(
                      children: tabbedViews
                          .map<Widget>((Tuple2 page) => page.item2)
                          .toList(),
                    ),
                  ),
                  // const Divider(
                  //   thickness: 0,
                  //   height: 1,
                  // ),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.only(left: 10),
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: viewModel.allLanguagesStrings.map(
                          (l) {
                            return GestureDetector(
                              onTap: () {
                                viewModel.toggleLangueSelection(l);
                              },
                              child: LanguageWidget(
                                language: l,
                                isSelected:
                                    viewModel.selectedLanguages.contains(l),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ),

                  if (connectionModel.data ?? true)
                    Container(
                      padding: basePadding,
                      color: Theme.of(context).backgroundColor,
                      child: Center(
                        child: FittedBox(
                          child: TextWiget.caption(
                            AppLocalizations.of(context)!.internetIsLost,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class LanguageWidget extends StatelessWidget {
  final String language;
  final bool isSelected;
  const LanguageWidget({
    Key? key,
    required this.language,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Chip(
        labelPadding: const EdgeInsets.all(2.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        label: TextWiget.body(language),
        backgroundColor: isSelected
            ? Theme.of(context).primaryColor.withOpacity(.1)
            : Theme.of(context).backgroundColor,
        elevation: 0.0,
        shadowColor: Theme.of(context).primaryColor,
        padding: const EdgeInsets.all(4.0),
      ),
    );
  }
}
