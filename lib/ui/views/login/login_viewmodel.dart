import 'package:my_first_app/app/app.locator.dart';
import 'package:my_first_app/app/app.router.dart';
import 'package:my_first_app/app/models/login/authentication_model.dart';
import 'package:my_first_app/services/failure_service.dart';
import 'package:my_first_app/services/login_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends FutureViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _authenticationService = locator<LoginService>();

  String? _status;
  String? get status => _status;

  String? _email;
  String? get email => _email;

  String? _password;
  String? get password => _password;

  set email(String? value) {
    _email = value;
    notifyListeners();
  }

  set password(String? value) {
    _password = value;
    notifyListeners();
  }

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> signIn(String email, String password) async {
    final res = await runBusyFuture(
        _authenticationService.signIn(email: email, password: password));

    res.fold((failure) {
      _errorMessage = failure.message;
      print('Masuk VM View Error: ${failure.message}');

      notifyListeners();
    }, (res) {
      print('Masuk VM View : ${res.message}');
      _status = 'Login Success';
      _navigationService.navigateTo(Routes.shopView);

      notifyListeners();
    });
  }

  @override
  Future futureToRun() async {
    return null; // Tidak melakukan apa-apa
  }
}
