import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'shop_viewmodel.dart';

class ShopView extends StackedView<ShopViewModel> {
  const ShopView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ShopViewModel viewModel,
    Widget? child,
  ) {
    print('Masuk ShopView : ${viewModel.productModel?.length}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: viewModel.isBusy
              ? const Center(child: CircularProgressIndicator())
              : viewModel.productModel == null ||
                      viewModel.productModel!.isEmpty
                  ? const Center(child: Text('Data Kosong'))
                  : viewModel.productModel!.isNotEmpty
                      ? GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: viewModel.productModel?.length,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.7,
                          ),
                          itemBuilder: (context, index) {
                            final data = viewModel.productModel?[index];
                            print('Masuk Shop_View : ${data!.brand}');
                            return Card(
                              child: ListTile(
                                leading: Image.network(data.image[0]),
                                title: Text(data.brand),
                                trailing: Text(data.price.toString()),
                              ),
                            );
                          },
                        )
                      : const Center(child: Text('Data Kosong')),
        ),
      ),
    );
  }

  @override
  ShopViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ShopViewModel();
}
