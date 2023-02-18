import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travell_app/cubit/app_cubit_states.dart';
import 'package:travell_app/cubit/app_cubits.dart';
import 'package:travell_app/pages/auth/auth_page.dart';
import 'package:travell_app/pages/detail_page.dart';
import 'package:travell_app/pages/navpages/main_page.dart';
import 'package:travell_app/pages/welcome_page.dart';

class AppCubitLogics extends StatefulWidget {
  const AppCubitLogics({Key? key}) : super(key: key);

  @override
  _AppCubitLogicsState createState() => _AppCubitLogicsState();
}

class _AppCubitLogicsState extends State<AppCubitLogics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubits, CubitState>(
        builder: (context, state) {
          if (state is WelcomeState) {
            return const WelcomePage();
          }
          if (state is AuthState){
            return const AuthPage();
          }
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is LoadedState) {
            return const MainPage();
          }
          if (state is DetailState) {
            return const DetailPage();
          }
          else {
            return Container();
          }
        },
      ),
    );
  }
}
