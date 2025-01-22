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
      body: viewModel.isBusy
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: viewModel.productModel == null ||
                        viewModel.productModel!.isEmpty
                    ? const Center(child: Text('Data Kosong'))
                    : GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: viewModel.productModel?.length,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          childAspectRatio: 0.7,
                        ),
                        itemBuilder: (context, index) {
                          final data = viewModel.productModel?[index];
                          return Card(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Image.network(
                                data!.image[0],
                                alignment: Alignment.center,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.04),
                                child: Column(
                                  children: [
                                    Text(
                                      data.brand,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ));
                        },
                      ),
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
