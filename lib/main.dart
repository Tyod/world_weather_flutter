import 'package:flutter/material.dart';
import 'package:world_time_flutter/pages/day_details_weather.dart';
import 'package:world_time_flutter/pages/week_details_weather.dart';
import 'package:world_time_flutter/pages/home.dart';
import 'package:world_time_flutter/pages/choose_location.dart';
import 'package:world_time_flutter/pages/loading.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  debugShowCheckedModeBanner: false,
  routes: {
    '/': (context) => Loading(),
    '/home': (context) => Home(),
    '/location': (context) => ChooseLocation(),
    "/weekdetails" : (context) => WeekDetailsWeather(),
    "/daydetails" :(context) => DayDetailsWeather()
  },
));



