import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sliding_switch/sliding_switch.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/bloc/weather_bloc_bloc.dart';
import 'package:weather_app/data/state_manager.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/screens/air_condition_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late StateManager stateManager;

   @override
  void initState() {
    super.initState();
    stateManager = StateManager();
  }


  Widget getWeatherIcon (int code){
    switch (code) {
      case >200 && <= 300 :
        return Image.asset('assets/1.png');
        break;
      case >300 && <= 400 :
        return Image.asset('assets/2.png');
        break;
      case >500 && <= 600 :
        return Image.asset('assets/3.png');
        break;  
      case >600 && <= 700 :
        return Image.asset('assets/4.png');
        break;
      case >700 && <= 800 :
        return Image.asset('assets/5.png');
        break;
      case == 800 :
        return Image.asset('assets/6.png');
        break;
      case >800 && <= 804 :
        return Image.asset('assets/7.png');
        break;
      default:
        return Image.asset('assets/7.png');
      
    }

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
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
    
      body: Padding(
        padding: EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [
            Align(
              alignment: AlignmentDirectional(3, -0.3),
              child: Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color:colorDown),
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
              filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.transparent),
              ),
            ),
            BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
              builder: (context, state) {
                if (state is WeatherBlocSuccess) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        '📍 ${state.weather.areaName}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                       Text(
                     greeting,
                      //  'Good Morning',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      getWeatherIcon(state.weather.weatherConditionCode!),
                       Center(
                        child: Text(
                          '${state.weather.temperature!.celsius!.round()}°C ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 55,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Center(
                        child: Text(
                          '${state.weather.weatherMain!.toUpperCase()}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                       Center(
                        child: Text(
                       DateFormat('EEEE dd - ').add_jm().format(state.weather.sunrise!),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/11.png',
                                scale: 8,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Sunrise',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                 DateFormat().add_jm().format(state.weather.sunrise!),
                 
                                //    '5:34 am',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/12.png',
                                scale: 8,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Sunset',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                DateFormat().add_jm().format(state.weather.sunset!),
                         style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/13.png',
                                scale: 8,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Temp Max',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                 '${state.weather.tempMax!.celsius!.round().toString()}°C',
                                   // '12°C',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/14.png',
                                scale: 8,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Temp Min',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    ' ${state.weather.tempMax!.celsius!.round().toString() }°C',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  
                                ],
                                
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 6,),
                      Center(
                        child: SlidingSwitch(
                                  value: stateManager.isWeatherSelected,
                                  width: 250,
                                  onChanged: (bool value) {
                                    print(value);
                                  if (value) {
            // Start AirConditionScreen and handle the result.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AirConditionScreen(),
              ),
            ).then((result) {
              // Update the state based on the result.
              if (result != null && result is bool && !result) {
                setState(() {
                  stateManager.isWeatherSelected = false;
                });
              }
            });
          }
        
                                  },
                                  height: 35,
                                  animationDuration: const Duration(milliseconds: 400),
                                  onTap: () {},
                                  onDoubleTap: () {},
                                  onSwipe: () {},
                                  textOff: "Weather",
                                  textOn: "Air Condition",
                                  colorOn: const Color(0xffdc6c73),
                                  colorOff: const Color(0xff6682c0),
                                  background:  Color.fromARGB(43, 204, 203, 203),
                                  buttonColor: Color.fromARGB(42, 247, 245, 247),
                                  inactiveColor: const Color(0xff636f7b),
                                ),
                      ),
        
                    ],
                  ), 
                );   
                }else {
                  return Container();
                }
              },   
                
            )
          ]),
        ),
      ),
    );
    
  }
  


}
