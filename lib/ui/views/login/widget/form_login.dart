import 'package:flutter/material.dart';
import 'package:my_first_app/ui/views/login/login_viewmodel.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({super.key, required this.viewModel});

  final LoginViewModel viewModel;

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          onChanged: (value) => widget.viewModel.email = value,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          onChanged: (value) => widget.viewModel.password = value,
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
                  widget.viewModel.signIn(widget.viewModel.email ?? '',
                      widget.viewModel.password ?? '');
                },
                child: const Text('Login'),
              ),
      ],
    );
  }
}
