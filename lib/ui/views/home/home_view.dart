import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_first_app/ui/common/app_colors.dart';
import 'package:my_first_app/ui/common/ui_helpers.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                verticalSpaceLarge,
                Column(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          viewModel.isBusy
                              ? const CircularProgressIndicator()
                              : Text(
                                  '${viewModel.remoteConfig?.getString('name')}'),
                          Text('Age'),
                          Text('Name'),
                        ],
                      ),
                    ),
                    const Text(
                      'Hello, STACKED!',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    verticalSpaceMedium,
                    MaterialButton(
                      color: Colors.black,
                      onPressed: viewModel.incrementCounter,
                      child: Text(
                        viewModel.counterLabel,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    MaterialButton(
                      color: Colors.black,
                      onPressed: viewModel.navigationToNews,
                      child: const Text(
                        'To News',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    MaterialButton(
                      color: Colors.black,
                      onPressed: viewModel.navigationToShop,
                      child: const Text(
                        'To Shop',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    MaterialButton(
                      color: Colors.black,
                      onPressed: viewModel.navigationToLogin,
                      child: const Text(
                        'To Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    MaterialButton(
                      color: Colors.black,
                      onPressed: viewModel.buttonToLogout,
                      child: const Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      color: kcDarkGreyColor,
                      onPressed: viewModel.showDialog,
                      child: const Text(
                        'Show Dialog',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    MaterialButton(
                      color: kcDarkGreyColor,
                      onPressed: viewModel.showBottomSheet,
                      child: const Text(
                        'Show Bottom Sheet',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
