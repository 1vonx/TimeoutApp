import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travell_app/cubit/app_cubit_states.dart';
import 'package:travell_app/cubit/app_cubits.dart';
import 'package:travell_app/misc/colors.dart';
import 'package:travell_app/service/data_services.dart';
import 'package:travell_app/widgets/buttons/app_buttons.dart';
import 'package:travell_app/widgets/text/app_large_text.dart';

import '../widgets/buttons/responsive_button.dart';
import '../widgets/text/app_text.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubits, CubitState>(builder: (context, state) {
      DetailState detail = state as DetailState;
      return Scaffold(
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                child: Container(
                    width: double.maxFinite,
                    height: 350,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(detail.place.img),
                          fit: BoxFit.cover),
                    )),
              ),
              Positioned(
                  left: 0,
                  top: 50,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<AppCubits>(context).goHome();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 30,
                        ),
                      )
                    ],
                  )),
              Positioned(
                  top: 320,
                  left: 0,
                  bottom: 80,
                  right: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 30),
                    width: MediaQuery.of(context).size.width,
                    //height: 500,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppLargeText(
                              text: detail.place.name,
                              isBold: true),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  color: AppColors.mainColor),
                              const SizedBox(width: 3),
                              AppText(
                                text: detail.place.location,
                                color: AppColors.textColor1,
                                size: 20,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          AppLargeText(
                            text: "People",
                            color: Colors.black.withOpacity(0.8),
                            size: 20,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          AppText(
                            text: "Number of people in your group",
                            color: AppColors.textColor3,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Wrap(
                            children: List.generate(5, (index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: AppButtons(
                                    size: 50,
                                    color: selectedIndex == index
                                        ? Colors.white
                                        : Colors.black,
                                    backgroundColor: selectedIndex == index
                                        ? AppColors.mainColor
                                        : AppColors.textColor1.withOpacity(0.4),
                                    borderColor: selectedIndex == index
                                        ? AppColors.mainColor
                                        : AppColors.textColor1.withOpacity(0),
                                    text: (index + 1).toString(),
                                  ),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SingleChildScrollView(
                            child: AppLargeText(
                                text: "Description",
                                color: Colors.black.withOpacity(0.8),
                                size: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppText(
                              text: detail.place.description,
                              color: AppColors.textColor3),
                        ],
                      ),
                    ),
                  )),
              Positioned(
                bottom: 25,
                left: 20,
                right: 20,
                child: Row(
                  children: [
                    AppButtons(
                        size: 50,
                        color: AppColors.mainColor,
                        backgroundColor: Colors.white,
                        borderColor: AppColors.mainColor,
                        isIcon: true,
                        icon: Icons.favorite_sharp),
                    SizedBox(
                      width: 20,
                    ),
                    ResponsiveButton(
                      isResponsive: true,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
