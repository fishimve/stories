import 'package:get_it/get_it.dart';

import 'services/categories_service.dart';
import 'services/connectivity_service.dart';
import 'services/dialog_service.dart';
import 'services/favorites_service.dart';
import 'services/firestore_service.dart';
import 'services/languages_service.dart';
import 'services/localstorage_service.dart';
import 'services/navigation_service.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => LanguagesService());
  locator.registerLazySingleton(() => FavoritesService());
  locator.registerLazySingleton(() => ConnectivityService());
  locator.registerFactory(() => CategoriesService());
  locator.registerFactory(() => FirestoreService());

  final instance = await LocalStorageService.getServiceInstance();
  locator.registerSingleton<LocalStorageService>(instance!);
}
