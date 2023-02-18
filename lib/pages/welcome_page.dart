import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travell_app/cubit/app_cubits.dart';
import 'package:travell_app/misc/colors.dart';
import 'package:travell_app/widgets/text/app_large_text.dart';
import 'package:travell_app/widgets/factory/button_widget_factory.dart';

import '../widgets/text/app_text.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  var images = {
    "welcome-one.png":
        "Camping is an excellent way to escape from the commotion of our day-to-day lives. It can do magical things for the soul: it can reinvigorate you and leave you with a new perspective on life and our world.",
    "welcome-two.png":
        "Moraine Lake is yet another astonishing geographical location that you cannot afford to miss out on if you’re traveling along the Icefields Parkway",
    "welcome-three.png":
        "The Icefields Parkway offers you the picturesque panorama of Alberta’s most talked about mountain vistas. ",
  };

  var texts = ["Camping", "Hiking", "Fishing"];

  ButtonWidgetFactory? _factory;

  @override
  void initState() {
    if (Platform.isIOS) {
      _factory = iOSButtonFactory();
    } else if (Platform.isAndroid) {
      _factory = AndroidButtonFactory();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          onPageChanged: (index) {},
          scrollDirection: Axis.vertical,
          itemCount: images.length,
          itemBuilder: (_, index) {
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("img/${images.keys.elementAt(index)}"),
                      fit: BoxFit.cover)),
              child: Container(
                  margin: const EdgeInsets.only(top: 150, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppLargeText(text: "Trips", isBold: true,),
                          AppText(
                            text: texts[index],
                            isBold: false,
                            size: 30,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 250,
                            child: AppText(
                              text: images.values.elementAt(index),
                              color: AppColors.textColor2,
                              size: 14,
                            ),
                          ),
                          const SizedBox(
                            height: 23,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: _factory?.createButton(() {
                                  BlocProvider.of<AppCubits>(context).login();
                                }, ""),
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: List.generate(images.length, (indexDots) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 2),
                            width: 8,
                            height: index == indexDots ? 25 : 8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: index == indexDots
                                    ? AppColors.mainColor
                                    : AppColors.mainColor.withOpacity(0.3)),
                          );
                        }),
                      )
                    ],
                  )),
            );
          }),
    );
  }
}
