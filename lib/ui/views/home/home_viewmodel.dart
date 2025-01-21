import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:my_first_app/app/app.bottomsheets.dart';
import 'package:my_first_app/app/app.dialogs.dart';
import 'package:my_first_app/app/app.locator.dart';
import 'package:my_first_app/app/app.router.dart';
import 'package:my_first_app/services/login_service.dart';
import 'package:my_first_app/services/remote_config_firebase_service.dart';
import 'package:my_first_app/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends FutureViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<LoginService>();
  final _remoteConfigService = locator<RemoteConfigFirebaseService>();

  String get counterLabel => 'Counter is: $_counter';

  FirebaseRemoteConfig? _remoteConfig;
  FirebaseRemoteConfig? get remoteConfig => _remoteConfig;

  int _counter = 0;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void incrementCounter() {
    _counter++;
    rebuildUi();
  }

  void showDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Stacked Rocks!',
      description: 'Give stacked $_counter stars on Github',
    );
  }

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: ksHomeBottomSheetTitle,
      description: ksHomeBottomSheetDescription,
    );
  }

  void navigationToNews() {
    _navigationService.navigateTo(Routes.newsView);
  }

  void navigationToShop() {
    _navigationService.navigateTo(Routes.shopView);
  }

  void navigationToLogin() {
    _navigationService.navigateTo(Routes.loginView);
  }

  void buttonToLogout() {
    print('Masuk buttonToLogout()');
    _authenticationService.signOut();
    _navigationService.navigateTo(Routes.loginView);
  }

  Future<void> remoteConfigFirebase() async {
    print('Masuk remoteConfigFirebase()');
    final result = await runBusyFuture(
      _remoteConfigService.initializeRemoteConfig(),
    );

    result.fold((failure) {
      print('Masuk remoteConfigFirebase() Failure: $failure');
      _errorMessage = failure.message;
      notifyListeners();
    }, (value) {
      print('Masuk remoteConfigFirebase() Success: $value');
      _remoteConfig = value;

      //Biar update data secara realtime!
      // Listener untuk pembaruan
      _remoteConfig?.onConfigUpdated.listen((event) async {
        await _remoteConfig?.activate();
        print('Masuk config update di VM');
        notifyListeners(); // Pastikan UI diperbarui saat Remote Config diubah
      });

      notifyListeners();
    });
  }

  @override
  Future<void> futureToRun() async {
    // TODO: implement futureToRun
    await remoteConfigFirebase();
  }
}
