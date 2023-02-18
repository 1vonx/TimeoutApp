import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../service/firebase_service.dart';

class MyPage extends StatelessWidget {
  MyPage({Key? key}) : super(key: key);

  final FirebaseService _firebaseService = GetIt.I.get<FirebaseService>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          _firebaseService.signOut();
        },
        child: const Text(
          'Logout',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
