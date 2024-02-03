import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sliding_switch/sliding_switch.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/bloc/weather_bloc_bloc.dart';
import 'package:weather_app/data/air_quality.dart';
import 'package:weather_app/data/fetch_air_data.dart';
import 'package:weather_app/data/state_manager.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/screens/painter.dart';

class AirConditionScreen extends StatefulWidget {
  final AirQuality? airQuality;
  const AirConditionScreen({super.key, this.airQuality});

  @override
  State<StatefulWidget> createState() => _AirConditionScreenState();
}

class _AirConditionScreenState extends State<AirConditionScreen> {
  late StateManager stateManager;

  @override
  void initState() {
    super.initState();
    stateManager = StateManager();
  }

  @override
  Widget build(BuildContext context) {
    // Get the current time
    DateTime now = DateTime.now();

    // Define time ranges for different greetings
    DateTime morning = DateTime(now.year, now.month, now.day, 6, 0, 0);
    DateTime afternoon = DateTime(now.year, now.month, now.day, 12, 0, 0);
    DateTime evening = DateTime(now.year, now.month, now.day, 18, 0, 0);

    String greeting;
    Color colorUp;
    Color colorDown;
    // Determine the appropriate greeting based on the current time
    if (now.isAfter(morning) && now.isBefore(afternoon)) {
      greeting = 'Good Morning';
      colorUp = Colors.yellow;
      colorDown = Colors.blue;
    } else if (now.isAfter(afternoon) && now.isBefore(evening)) {
      greeting = 'Good Afternoon';
      colorUp = Colors.orange;
      colorDown = Colors.purple;
    } else {
      greeting = 'Good Evening';
      colorUp = Colors.blue;
      colorDown = Colors.deepPurple;
    }

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Air Quality Indicator",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Return a loading indicator or any other widget while waiting for data
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // Handle error
              return Text('Error: ${snapshot.error}');
            } else {
              // Data has been loaded successfully
              AirQuality airQuality =
                  snapshot.data as AirQuality; // Cast data to AirQuality

              return Padding(
                padding: EdgeInsets.fromLTRB(
                    40, 1.2 * kToolbarHeight, 40, 20),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(children: [
                    Align(
                      alignment: AlignmentDirectional(3, -0.3),
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: colorDown),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(-3, -0.3),
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: colorDown),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, -1.2),
                      child: Container(
                        height: 300,
                        width: 600,
                        decoration: BoxDecoration(
                            // shape: BoxShape.circle,
                            color: colorUp),
                      ),
                    ),
                    BackdropFilter(
                      //makes the blur magic.
                      filter:
                          ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.transparent),
                      ),
                    ),
                    Padding(
                   padding: const EdgeInsets.only(top: kToolbarHeight * 2),
                     child: SizedBox(
								width: MediaQuery.of(context).size.width,
								height: MediaQuery.of(context).size.height,
								child: Padding(
									padding: const EdgeInsets.all(25.0),
									child:  Stack(children: [
                        CustomPaint(
												size: Size(
													MediaQuery.of(context).size.width, 
													MediaQuery.of(context).size.width
												),
												painter: AirQualityPainter(airQuality.aqi),
											),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: 400,
                            height:
                                MediaQuery.of(context).size.height * 0.5,
                            child: Column(
                              children: [
                                Container(
                                  width: 400,
                                  height:
                                      MediaQuery.of(context).size.height *
                                          0.25,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/${airQuality.emojiRef}"),
                                    ),
                                  ),
                                ),
                              Container(
																width: 400,
																height: MediaQuery.of(context).size.height * 0.15,
																decoration: BoxDecoration(
																	borderRadius: BorderRadius.circular(20),
																	color: Colors.white70,
																),
																child: Center(
																	child: Padding(
																		padding: const EdgeInsets.all(8.0),
																		child: Text(
																			airQuality.message!,
																			textAlign: TextAlign.center,
																			style: const TextStyle(
																				height: 1.5,
																				fontSize: 16,
																				color: Colors.black,
																				fontWeight: FontWeight.w700
																			),
																		),
																	),
																),
															),
                               SizedBox(height: 20,),
                    Center(
                      child: SlidingSwitch(
                        value: !stateManager.isWeatherSelected,
                        width: 250,
                        onChanged: (bool value) {
                          print(value);
                    
                          if (!value) {
                            // If the value is false, pop back to HomeScreen with a result.
                            Navigator.pop(context, false);
                          }
                        },
                        height: 35,
                        animationDuration:
                            const Duration(milliseconds: 400),
                        onTap: () {},
                        onDoubleTap: () {},
                        onSwipe: () {},
                        textOff: "Weather",
                        textOn: "Air Condition",
                        colorOn: const Color(0xffdc6c73),
                        colorOff: const Color(0xff6682c0),
                        background: Color.fromARGB(43, 204, 203, 203),
                        buttonColor: Color.fromARGB(42, 247, 245, 247),
                        inactiveColor: const Color(0xff636f7b),
                      ),
                    ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),)),
                   
                  ]),
                ),
              );
            }
          }),
    );
  }
}
