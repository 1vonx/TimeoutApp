import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travell_app/cubit/place_cubit_states.dart';
import 'package:travell_app/cubit/place_cubit.dart';
import 'package:travell_app/pages/detail_page.dart';
import 'package:travell_app/pages/navpages/main_page.dart';
import 'package:travell_app/pages/welcome_page.dart';

class CubitLogic extends StatefulWidget {
  const CubitLogic({Key? key}) : super(key: key);

  @override
  _CubitLogicState createState() => _CubitLogicState();
}

class _CubitLogicState extends State<CubitLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PlaceCubit, PlaceState>(
        builder: (context, state) {
          if (state is WelcomeState) {
            return const WelcomePage();
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
