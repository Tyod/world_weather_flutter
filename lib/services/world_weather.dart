import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  late String location; //Location Name for the UI
  late double temperature; //The temperature in that location
  late String description; //The weather description in that location
  late String icon; //The icon of the corresponding weather in that location
  late String iconUrl; //The url to the icon received
  late String flag; //URL to an asset flag icon
  late String lat, lon; //Location URL for api endpoint
  late bool isDayTime; //True of False if it's daytime or not
  List<Day> week = [];

  WorldTime({required this.location, required this.flag, required this.lat, required this.lon});


  Future<void> getWeather() async{

    week.clear();

    try{
      //Setup the parameters for the request
      final queryParameters ={
        'lat' : lat,
        'lon' : lon,
        'exclude' : 'minutely,hourly,alerts',
        'appid' : '95e38ba9c062f24b1f3654d9a0d542b1',
        'units' : 'metric',
        'lang' : 'en'
      };

      //Set up the uri for the request
     final uri = Uri.https('api.openweathermap.org', '/data/2.5/onecall', queryParameters);

     //make the request
      final response = await http.get(uri);
      Map data = jsonDecode(response.body);
      /*print(data['current']['temp']);
      print(data['current']['weather'][0]['description']);
      print(data['current']['weather'][0]['icon']);
      print(data['daily'][6]['temp']['day']);
      print('------------------');*/

      //Getting current Data
      icon = data['current']['weather'][0]['icon'];
      iconUrl = 'https://openweathermap.org/img/wn/$icon@2x.png';
      temperature = data['current']['temp'];
      description = data['current']['weather'][0]['description'];


      //Getting 7 Day data
      for(int i=0; i<7 ; i++){
        var day = Day(tempMax: double.parse(data['daily'][i]['temp']['max'].toString()), tempMin: double.parse(data['daily'][i]['temp']['min'].toString()), description: data['daily'][i]['weather'][0]['description'], iconUrl: 'https://openweathermap.org/img/wn/${data['daily'][i]['weather'][0]['icon']}@2x.png', tempDay: double.parse(data['daily'][i]['temp']['day'].toString()), tempNight: double.parse(data['daily'][i]['temp']['night'].toString()), humidity: int.parse(data['daily'][i]['humidity'].toString()), pressure: int.parse(data['daily'][i]['pressure'].toString()), wind: double.parse(data['daily'][i]['wind_speed'].toString()), rainProb: double.parse(data['daily'][i]['pop'].toString()), uv: double.parse(data['daily'][i]['uvi'].toString()));
        week.add(day);
      }

      /*for(int j=0; j<7; j++){
        print(days[j].tempMax.toString());
        print(days[j].tempMin.toString());
        print(days[j].description);
        print(days[j].iconUrl);
      }*/

    }catch(e){
      print("Caught error: $e");
      temperature = 0.0;
    }
  }

}

class Day {
  late double tempMax;
  late double tempMin;
  late String description;
  late String iconUrl;

  late double tempDay;
  late double tempNight;
  late double wind;
  late int humidity;
  late int pressure;
  late double rainProb;
  late double uv;

  Day({required this.tempMax, required this.tempMin, required this.description, required this.iconUrl, required this.tempDay, required this.tempNight, required this.humidity, required this.pressure, required this.wind, required this.rainProb, required this.uv});
}
