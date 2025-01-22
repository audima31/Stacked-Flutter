import 'package:flutter/material.dart';
import 'package:my_first_app/ui/views/login/login_view.form.dart';
import 'package:my_first_app/ui/views/login/login_viewmodel.dart';

class FormLogin extends StatefulWidget {
  const FormLogin(
      {super.key,
      required this.viewModel,
      required this.emailController,
      required this.passwordController,
      required this.hasEmail,
      required this.hasPassword,
      required this.hasEmailValidationMessage,
      required this.hasPasswordValidationMessage});

  final LoginViewModel viewModel;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool hasEmail;
  final bool hasPassword;
  final bool hasEmailValidationMessage;
  final bool hasPasswordValidationMessage;

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  @override
  Widget build(BuildContext context) {
    print('Email : ${widget.emailController.text}');
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: widget.emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: widget.passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ),
        const SizedBox(height: 20),
        widget.viewModel.isBusy
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () {
                  widget.viewModel.signIn(widget.emailController.text,
                      widget.passwordController.text);
                },
                child: const Text('Login'),
              ),
      ],
    );
  }
}
