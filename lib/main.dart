import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:stories/interface/shared/colors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'interface/shared/themes.dart';
import 'interface/views/home/home_view.dart';
import 'l10n/l10n.dart';
import 'services/dialog_service.dart';
import 'utilities/configure_nonweb.dart'
    if (dart.library.html) 'utilities/configure_web.dart';
import 'locator.dart';
import 'utilities/dialog_manager.dart';
import 'utilities/lifecycle_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

// initialize all services
  await setupLocator();

// configure route styles
  configureRouteStyles();

  // allow only portrait mode
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  final brightness = SchedulerBinding.instance!.window.platformBrightness;
  bool isDark = brightness == Brightness.dark;

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      systemNavigationBarDividerColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      systemNavigationBarIconBrightness:
          isDark ? Brightness.light : Brightness.dark,
    ),
  );

  runApp(const WorldStories());
}

class WorldStories extends StatelessWidget {
  const WorldStories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LifeCycleManager(
      child: MaterialApp(
        scrollBehavior: CustomScrollBehavior(),
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (BuildContext context) =>
            AppLocalizations.of(context)!.title,
        home: const HomeView(),
        theme: ThemeConfig.lightTheme,
        darkTheme: ThemeConfig.darkTheme,
        themeMode: ThemeMode.system,
        builder: (context, child) => Navigator(
          key: locator<DialogService>().dialogNavigationKey,
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(
              child: child!,
            ),
          ),
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: L10n.all,
      ),
    );
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
