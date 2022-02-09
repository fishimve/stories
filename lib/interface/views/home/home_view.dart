import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:stories/interface/router.dart';
import 'package:stories/interface/shared/ui_helpers.dart';
import 'package:stories/interface/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stories/locator.dart';
import 'package:stories/routes/route_names.dart';
import 'package:stories/services/navigation_service.dart';

import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (viewModel) => viewModel.setLanguages(),
      builder: (context, viewModel, child) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: Navigator(
                  key: locator<NavigationService>().navigationKey,
                  onGenerateRoute: generateRoute,
                  initialRoute: tabsViewRoute,
                ),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.only(left: 10),
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: viewModel.allLanguagesStrings
                        .map(
                          (l) => GestureDetector(
                            onTap: () => viewModel.toggleLanguageSelection(l),
                            child: LanguageWidget(
                              language: l,
                              isSelected:
                                  viewModel.selectedLanguages.contains(l),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              ViewModelBuilder<ConnectionModel>.reactive(
                viewModelBuilder: () => ConnectionModel(),
                builder: (context, connectionModel, child) {
                  if (connectionModel.data ?? true) {
                    return Container(
                      padding: basePadding,
                      child: Center(
                        child: FittedBox(
                          child: TextWiget.caption(
                            AppLocalizations.of(context)!.internetIsLost,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
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
        label: TextWiget.body(
          language,
          color: isSelected ? Theme.of(context).backgroundColor : null,
          fontWeight: isSelected ? 2 : 1,
        ),
        backgroundColor: isSelected
            ? Theme.of(context).canvasColor
            : Theme.of(context).backgroundColor,
        elevation: 0.0,
        shadowColor: Theme.of(context).primaryColor,
        padding: const EdgeInsets.all(4.0),
      ),
    );
  }
}
