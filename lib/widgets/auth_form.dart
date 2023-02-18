import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travell_app/misc/colors.dart';
import 'package:travell_app/widgets/user_image_picker.dart';

import '../cubit/app_cubits.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String password, String username,
      BuildContext context, bool isLogin, File? image) submitData;
  final bool isLoading;

  const AuthForm(this.submitData, this.isLoading, {super.key});

  @override
  State<StatefulWidget> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  late String _email;
  late String _password;
  String _username = '';
  File? _userImageFile;
  bool _isLogin = true;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please pick an image!'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitData(
          _email.trim(),
          _password.trim(),
          _username.trim(),
          context, _isLogin,
          _userImageFile);

      BlocProvider.of<AppCubits>(context).getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isLogin ? 'Login' : 'Sing up',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 10.0),
                if (!_isLogin) UserImagePicker(_pickedImage),
                TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? 'Email can\'t be empty' : null,
                  onChanged: (value) => _email = value,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 10.0),
                if (!_isLogin)
                  TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? 'Username can\'t be empty' : null,
                    onChanged: (value) => _username = value,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                const SizedBox(height: 10.0),
                TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? 'Password can\'t be empty' : null,
                  obscureText: true,
                  onChanged: (value) => _password = value,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 10.0),
                if (widget.isLoading) const CircularProgressIndicator(),
                if (!widget.isLoading)
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text(
                      _isLogin ? 'Login' : 'Sing up',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                if (!widget.isLoading)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(_isLogin
                        ? 'Create new account'
                        : 'I already have an account'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
