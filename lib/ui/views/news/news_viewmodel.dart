import 'package:my_first_app/app/app.locator.dart';
import 'package:my_first_app/app/models/news/news_model.dart';
import 'package:my_first_app/services/news_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NewsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _getApiNews = locator<NewsService>();

  ResponseGetNews? _responseGetNews;
  ResponseGetNews? get responseGetNews => _responseGetNews;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void navigationBack() {
    _navigationService.back();
  }

  Future<void> getApi() async {
    setBusy(true);
    _errorMessage = null;
    final result = await _getApiNews.getApi();
    print('Masuk VM 1 : $result');

    result.fold((failure) {
      _errorMessage = failure.message;
      notifyListeners();
    }, (response) {
      _responseGetNews = response;
      print('Masuk VM 2: ${_responseGetNews?.data}');
      notifyListeners();
    });
    setBusy(false);
  }
}
