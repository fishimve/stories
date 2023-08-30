import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stories/interface/shared/ui_helpers.dart';
import 'package:stories/interface/widgets/text_widget.dart';
import 'package:stories/interface/widgets/web_centered_widget.dart';
import 'package:stories/models/story.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'story_view_model.dart';

class StoryView extends StatelessWidget {
  final Story story;
  const StoryView({Key? key, required this.story}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StoryViewModel>.reactive(
      viewModelBuilder: () => StoryViewModel(),
      onViewModelReady: (viewModel) => viewModel.getFavoriteStatus(story.id),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 25,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: viewModel.navigatorPop,
            ),
            title: TextWiget.headline3(story.title),
            actions: [
              IconButton(
                onPressed: () => viewModel.handleFavorite(
                  story.id,
                  AppLocalizations.of(context)!.dialogTitle,
                  AppLocalizations.of(context)!.dialogConfirmation,
                  AppLocalizations.of(context)!.yes,
                  AppLocalizations.of(context)!.no,
                ),
                icon: Icon(
                  viewModel.isFavorite
                      ? Icons.bookmark_added
                      : Icons.bookmark_add_outlined,
                  size: 25,
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
          body: WebCenteredWidget(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  verticalSpaceSmall,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                    ),
                    child: TextWiget.body(story.content),
                  ),
                  if (story.author != '-') ...[
                    verticalSpaceMedium,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: TextWiget.body(
                          story.author,
                          fontWeight: 2,
                        ),
                      ),
                    ),
                  ],
                  if (story.tags != []) ...[
                    verticalSpaceSmall,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: TextWiget.caption(
                          story.tags.join(', '),
                        ),
                      ),
                    ),
                  ],
                  verticalSpaceMedium,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
