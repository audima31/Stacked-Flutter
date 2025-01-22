import 'package:flutter/material.dart';
import 'package:my_first_app/ui/views/login/login_view.form.dart';
import 'package:my_first_app/ui/views/login/widget/form_login.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'login_viewmodel.dart';

@FormView(fields: [
  FormTextField(
    name: 'email',
  ),
  FormTextField(
    name: 'password',
  ),
])
class LoginView extends StackedView<LoginViewModel> with $LoginView {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, LoginViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Center(
          child: FormLogin(
            viewModel: viewModel,
            emailController: emailController,
            passwordController: passwordController,
            hasEmail: viewModel.hasEmail,
            hasPassword: viewModel.hasPassword,
            hasEmailValidationMessage: viewModel.hasEmailValidationMessage,
            hasPasswordValidationMessage:
                viewModel.hasPasswordValidationMessage,
          ),
        ),
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewModel();

  @override
  void onViewModelReady(LoginViewModel viewModel) {
    syncFormWithViewModel(viewModel);
  }
}
