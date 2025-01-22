import 'package:my_first_app/app/app.locator.dart';
import 'package:my_first_app/app/app.router.dart';
import 'package:my_first_app/services/login_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _snackbarService = locator<SnackbarService>();
  final _authenticationService = locator<LoginService>();

  String? _status;
  String? get status => _status;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> signIn(String email, String password) async {
    final res = await runBusyFuture(
        _authenticationService.signIn(email: email, password: password));

    res.fold((failure) {
      _errorMessage = failure.message;
      _snackbarService.showSnackbar(
        title: 'Error',
        message: _errorMessage.toString(),
        duration: Duration(seconds: 3),
        onMainButtonTapped: () {
          print('Main button tapped!');
        },
      );
      print('Masuk VM View Error: ${failure.message}');

      notifyListeners();
    }, (res) {
      print('Masuk VM View : ${res.message}');
      _status = 'Login Success';
      _navigationService.navigateTo(Routes.shopView);

      notifyListeners();
    });
  }

  void showSuccessSnackbar() {
    _snackbarService.showSnackbar(
      title: 'Success',
      message: 'This is a success message!',
    );
  }

  void showErrorSnackbar() {}
}
