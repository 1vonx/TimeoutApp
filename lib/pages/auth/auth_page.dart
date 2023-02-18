import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import '../../service/firebase_service.dart';
import '../../widgets/auth_form.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<StatefulWidget> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final FirebaseService _firebaseService = GetIt.I.get<FirebaseService>();
  var _isLoading = false;

  void _submitAuthForm(String email, String password, String username,
      BuildContext context, bool isLogin, File? image) async {
    String userId;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        userId = await _firebaseService.signIn(email, password);
      } else {
        userId = await _firebaseService.signUp(email, password);

        final url = await _firebaseService.getDownloadUrl(userId, image!);

        await _firebaseService.setUserInfo(userId, username, email, url)
            .then((value) => print('User $username added'));
      }
    } on PlatformException catch (err) {
      var message = 'An error occurred, check your credentials!';
      if (err.message != null) {
        message = err.message!;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
      if (!mounted) {
        return;
      }
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      if (!mounted) {
        return;
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}
