import 'package:flutter/material.dart';
import 'package:world_time_flutter/services/world_weather.dart';

class DayDetailsWeather extends StatefulWidget {
  const DayDetailsWeather({Key? key}) : super(key: key);

  @override
  _DayDetailsWeatherState createState() => _DayDetailsWeatherState();
}

class _DayDetailsWeatherState extends State<DayDetailsWeather> {
  Map data = {};
  late String weekDay;
  late Day day;

  @override
  Widget build(BuildContext context) {
    data = (ModalRoute.of(context)!.settings.arguments) as Map;
    weekDay = data['weekday'];
    day = data['day'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(weekDay),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.network(
              day.iconUrl,
              width: 120,
              height: 120,
            ),
            Text(
              day.description,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                  letterSpacing: 2.0),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Divider(
              height: 5.0,
              color: Colors.black,
              thickness: 2.0,
              indent: 30.0,
              endIndent: 30.0,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Min: ${day.tempMin} ºC       ",
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Max: ${day.tempMax} ºC",
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Day: ${day.tempDay} ºC        ",
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Night: ${day.tempNight} ºC",
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Divider(
              height: 5.0,
              color: Colors.black,
              thickness: 2.0,
              indent: 30.0,
              endIndent: 30.0,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Wind: ${day.wind} m/s     ",
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Humidity: ${day.humidity}%",
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              "Pressure: ${day.pressure} hPa",
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Divider(
              height: 5.0,
              color: Colors.black,
              thickness: 2.0,
              indent: 30.0,
              endIndent: 30.0,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              "Rain Probability: ${(day.rainProb * 100).toStringAsFixed(2)}%",
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              "UV: ${(day.uv).toStringAsFixed(2)}",
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
