import 'package:my_first_app/app/app.locator.dart';
import 'package:my_first_app/app/models/shop/shop_product_model.dart';
import 'package:my_first_app/services/shop_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ShopViewModel extends FutureViewModel {
  final _navigationService = locator<NavigationService>();
  final _shopService = locator<ShopService>();

  //Ngambil dari model
  List<ShopProductModel>? _productModel;
  List<ShopProductModel>? get productModel => _productModel;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchDataProduct() async {
    final result = await runBusyFuture(
      _shopService.fetchDataProduct(),
    );

    result.fold((failure) {
      print(
          'Masuk ShopViewModel Failure 1 : ${_shopService.fetchDataProduct()}');
      print('Masuk ShopViewModel Failure: $failure');
      _errorMessage = failure.message;
      rebuildUi();
    }, (value) {
      _productModel = value;
      print('Masuk ShopViewModel Failure: ${value.length}');
      rebuildUi();
    });
  }

  @override
  Future<List<ShopProductModel>> futureToRun() async {
    await fetchDataProduct();
    return _productModel ?? [];
  }
}
