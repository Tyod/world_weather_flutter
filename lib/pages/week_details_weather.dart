import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:world_time_flutter/services/world_weather.dart';

class WeekDetailsWeather extends StatefulWidget {
  const WeekDetailsWeather({Key? key}) : super(key: key);

  @override
  _WeekDetailsWeatherState createState() => _WeekDetailsWeatherState();
}

class _WeekDetailsWeatherState extends State<WeekDetailsWeather> {
  Map data = {};
  List<Day> week = [];
  List<String> weekDays = [];

  void setUpWeekDays() {
    weekDays.clear();
    DateTime date = DateTime.now();

    switch (DateFormat('EEEE').format(date)) {
      case 'Monday':
        weekDays.add('Tuesday');
        weekDays.add('Wednesday');
        weekDays.add('Thursday');
        weekDays.add('Friday');
        weekDays.add('Saturday');
        weekDays.add('Sunday');
        weekDays.add('Monday');
        break;

      case 'Tuesday':
        weekDays.add('Wednesday');
        weekDays.add('Thursday');
        weekDays.add('Friday');
        weekDays.add('Saturday');
        weekDays.add('Sunday');
        weekDays.add('Monday');
        weekDays.add('Tuesday');
        break;

      case 'Wednesday':
        weekDays.add('Thursday');
        weekDays.add('Friday');
        weekDays.add('Saturday');
        weekDays.add('Sunday');
        weekDays.add('Monday');
        weekDays.add('Tuesday');
        weekDays.add('Wednesday');
        break;

      case 'Thursday':
        weekDays.add('Friday');
        weekDays.add('Saturday');
        weekDays.add('Sunday');
        weekDays.add('Monday');
        weekDays.add('Tuesday');
        weekDays.add('Wednesday');
        weekDays.add('Thursday');
        break;

      case 'Friday':
        weekDays.add('Saturday');
        weekDays.add('Sunday');
        weekDays.add('Monday');
        weekDays.add('Tuesday');
        weekDays.add('Wednesday');
        weekDays.add('Thursday');
        weekDays.add('Friday');
        break;

      case 'Saturday':
        weekDays.add('Sunday');
        weekDays.add('Monday');
        weekDays.add('Tuesday');
        weekDays.add('Wednesday');
        weekDays.add('Thursday');
        weekDays.add('Friday');
        weekDays.add('Saturday');
        break;

      case 'Sunday':
        weekDays.add('Monday');
        weekDays.add('Tuesday');
        weekDays.add('Wednesday');
        weekDays.add('Thursday');
        weekDays.add('Friday');
        weekDays.add('Saturday');
        weekDays.add('Sunday');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    data = (ModalRoute.of(context)!.settings.arguments) as Map;
    week = data['week'];
    setUpWeekDays();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text("Week Details"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: week.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
                child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  weekDays[index],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      letterSpacing: 2.0),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ListTile(
                  onTap: ()  {Navigator.pushNamed(context, '/daydetails', arguments: {
                    'weekday' : weekDays[index],
                    'day' : week[index]
                  });},
                  title: Text(
                      'Min: ${week[index].tempMin} ºC    Max: ${week[index].tempMax} ºC'),
                  subtitle: Text(
                    'Description: ${week[index].description}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14.0),
                  ),
                  leading: Image.network(week[index].iconUrl),
                )
              ],
            )),
          );
        },
      ),
    );
  }
}
