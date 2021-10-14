import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'locator.dart';
import 'utilities/configure_nonweb.dart'
    if (dart.library.html) 'utilities/configure_web.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

// initialize all services
  await setupLocator();

  // allow only portrait mode
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  final brightness = SchedulerBinding.instance!.window.platformBrightness;
  bool isDark = brightness == Brightness.dark;

  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle(
  //     statusBarColor: Colors.transparent,
  //     statusBarBrightness: isDark ? Brightness.light : Brightness.dark,
  //     statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
  //     systemNavigationBarColor:
  //         isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
  //     systemNavigationBarDividerColor:
  //         isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
  //     systemNavigationBarIconBrightness:
  //         isDark ? Brightness.light : Brightness.dark,
  //   ),
  // );

  configureApp();

  runApp(const WorldStories());
}

class WorldStories extends StatelessWidget {
  const WorldStories({Key? key}) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     title: 'Ikinyarwanda',
  //     home: const HomeView(),
  //     theme: ThemeConfig.lightTheme,
  //     darkTheme: ThemeConfig.darkTheme,
  //     themeMode: ThemeMode.system,
  //     navigatorKey: locator<NavigationService>().navigationKey,
  //     onGenerateRoute: generateRoute,
  //     builder: (context, child) => Navigator(
  //       key: locator<DialogService>().dialogNavigationKey,
  //       onGenerateRoute: (settings) => MaterialPageRoute(
  //         builder: (context) => DialogManager(
  //           child: child!,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
