import 'dart:async';
import 'dart:math';
import 'package:compass_icon/compass_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:travell_app/cubit/place_cubit_states.dart';
import 'package:travell_app/cubit/place_cubit.dart';
import 'package:travell_app/misc/colors.dart';
import 'package:travell_app/widgets/text/app_large_text.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import '../widgets/text/app_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  var images = {
    "ballooning_icon.png": "Ballooning",
    "hiking_icon.png": "Hiking",
    "camping_icon.png": "Camping",
    "swimming_icon.png": "Swimming"
  };
  List<double>? _magnetometerValues;
  CompassDirection compassDirection = CompassDirection.north;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(
      magnetometerEvents.listen(
            (MagnetometerEvent event) {
              double D = 360 - atan2(event.x, event.y) * (180 / pi);
              if (D > 337.25 || D < 22.5) {
                compassDirection = CompassDirection.north;
              } else if (D >= 292.5 && D <= 337.25) {
                compassDirection = CompassDirection.northWest;
              } else if (D >= 247.5 && D <= 292.5) {
                compassDirection = CompassDirection.west;
              } else if (D >= 202.5 && D <= 247.5) {
                compassDirection = CompassDirection.southWest;
              } else if (D >= 157.5 && D <= 202.5) {
                compassDirection = CompassDirection.south;
              } else if (D >= 112.5 && D <= 157.5) {
                compassDirection = CompassDirection.southEast;
              } else if (D >= 67.5 && D <= 112.5) {
                compassDirection = CompassDirection.east;
              } else if (D >= 0 && D <= 67.5) {
                compassDirection = CompassDirection.northEast;
              }
              setState(() {
            _magnetometerValues = <double>[event.x, event.y, event.z];
          });
        },
        onError: (e) {
          showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text("Sensor Not Found"),
                  content: Text(
                      "It seems that your device doesn't support Magnetometer Sensor"),
                );
              });
        },
        cancelOnError: true,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    _magnetometerValues?.map((double v) => v.toStringAsFixed(1)).toList();
    return Scaffold(body: BlocBuilder<PlaceCubit, PlaceState>(
      builder: (context, state) {
        if (state is LoadedState) {
          var info = state.places;
          return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("img/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //menu text
                  Container(
                    padding: const EdgeInsets.only(top: 70, left: 20),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  //discover text
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppLargeText(text: "Discover", isBold: true,),
                        const SizedBox(height: 20,),
                        AppLargeText(text: "Places", size: 25, color: AppColors.textColor2,),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            const Text("Fun fact! Your direction is "),
                            Text(compassDirection.name.toUpperCase(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600
                              ),),
                          ],
                        ),
                        CompassIcon(
                          const Icon(Typicons.compass, size:40, color: Colors.green,),
                          compassDirection: compassDirection,
                          initialDirection: compassDirection,
                        ),
                    ],),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    height: 350,
                    width: double.maxFinite,
                    child: ListView.builder(
                      itemCount: info.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            BlocProvider.of<PlaceCubit>(context)
                                .detailPage(info[index]);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 15, top: 10),
                            width: 230,
                            height: 300,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                image: DecorationImage(
                                    image: AssetImage(info[index].img),
                                    fit: BoxFit.cover)),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppLargeText(
                          text: "Categories",
                          size: 25,
                          color: AppColors.textColor2,
                        ),
                        AppText(text: "See all", hasUnderline:true, color: AppColors.textColor1)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 120,
                    width: double.maxFinite,
                    margin: const EdgeInsets.only(left: 20),
                    child: ListView.builder(
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return Container(
                            margin: const EdgeInsets.only(right: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "img/${images.keys.elementAt(index)}"),
                                          fit: BoxFit.cover)),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                AppText(
                                  text: images.values.elementAt(index),
                                  color: AppColors.textColor2,
                                )
                              ],
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    ));
  }
}
