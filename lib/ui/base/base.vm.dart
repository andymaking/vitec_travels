import 'package:flutter/foundation.dart';
import 'package:vitec_travels/data/services/storage-services/appCache.dart';
import '../../data/core/view_state.dart';
import '../../data/repository/repository.dart';
import '../../data/services/navigation_service.dart';
import '../../data/services/storage-services/storage-service.dart';
import '../../locator.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _viewState = ViewState.Idle;
  String? errorMessage;
  Repository repository = locator<Repository>();
  StorageService storageService = locator<StorageService>();
  AppCache cache = locator<AppCache>();
  NavigationService navigationService = locator<NavigationService>();

  ViewState get viewState => _viewState;

  set viewState(ViewState newState) {
    _viewState = newState;
    notifyListeners();
  }

  void setError(String? error) {
    errorMessage = error;
    notifyListeners();
  }

  bool isLoading = false;

  void startLoader() {
    if (!isLoading) {
      isLoading = true;
      viewState = ViewState.Loading;
      notifyListeners();
    }
  }

  void stopLoader() {
    if (isLoading) {
      isLoading = false;
      viewState = ViewState.Loading;
      notifyListeners();
    }
  }
}