import 'package:stacked/stacked.dart';
import 'package:stories/locator.dart';
import 'package:stories/services/dialog_service.dart';
import 'package:stories/services/favorites_service.dart';
import 'package:stories/services/navigation_service.dart';

class StoryViewModel extends ReactiveViewModel {
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _favoritesService = locator<FavoritesService>();

  var isFavorite = false;

  void getFavoriteStatus(String id) {
    isFavorite = _favoritesService.isFavorite(id);
  }

  void handleFavorite(
    String storyId,
    String dialogConfirm,
    String removeFromFavs,
    String confirm,
    String deny,
  ) async {
    if (isFavorite) {
      var dialogResponse = await _dialogService.showConfirmationDialog(
        title: dialogConfirm,
        description: removeFromFavs,
        confirmation: confirm,
        cancel: deny,
      )!;

      if (dialogResponse.confirmed!) {
        _favoritesService.unfavoriteStory(storyId);
        isFavorite = false;
        notifyListeners();
      }
    } else {
      _favoritesService.favoriteStory(storyId);
      isFavorite = true;
      notifyListeners();
    }
  }

  void navigatorPop() {
    _navigationService.pop();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_favoritesService];
}
