import 'package:flutter/material.dart';
import 'package:world_time_flutter/services/world_weather.dart';
import 'package:location/location.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  List<Day> week= [];
  String bgImage = "";

  void setBackgroundImage() {
    //Set Background Image
    switch (data['description']) {
      case 'clear sky':
        bgImage = 'RealSunnyDay.jpg';
        break;
      case 'few clouds':
        bgImage = 'SunnyDay.jpg';
        break;
      case 'scattered clouds':
        bgImage = 'CloudyDay.jpg';
        break;
      case 'overcast clouds':
        bgImage = 'DarkCloudyDay.jpg';
        break;
      case 'broken clouds':
        bgImage = 'DarkCloudyDay.jpg';
        break;
      case 'shower rain':
        bgImage = 'RainyDay.jpg';
        break;
      case 'heavy intensity rain':
        bgImage = 'RainyDay.jpg';
        break;
      case 'moderate rain':
        bgImage = 'RainyDay.jpg';
        break;
      case 'light rain':
        bgImage = 'RainyDay.jpg';
        break;
      case 'rain':
        bgImage = 'RainyDay.jpg';
        break;
      case 'thunderstorm':
        bgImage = 'ThunderDay.jpg';
        break;
      case 'snow':
        bgImage = 'SnowDay.jpg';
        break;
      case 'mist':
        bgImage = 'FoggyDay.jpg';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    data = data.isEmpty ? (ModalRoute.of(context)!.settings.arguments) as Map : data;
    week = data['week'];
    print(data);

    Color? bgColor = (DateTime.now().hour > 6 && DateTime.now().hour < 17)
        ? Colors.blue
        : Colors.indigo[700];

    setBackgroundImage();

    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/$bgImage'), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 120.0, 0.0, 0.0),
          child: SafeArea(
              child: Column(
            children: <Widget>[
              TextButton.icon(
                onPressed: () async {
                  dynamic result =
                      await Navigator.pushNamed(context, '/location');
                  setState(() {
                    data = {
                      'location': result['location'],
                      'flag': result['flag'],
                      'temperature': result['temperature'],
                      'description': result['description'],
                      'iconUrl': result['iconUrl'],
                      'week' : result['week']
                    };
                  });
                  setBackgroundImage();
                },
                icon: const Icon(
                  Icons.edit_location,
                  color: Colors.black,
                ),
                label: const Text(
                  'Edit Location',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data['location'],
                    style: const TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Divider(
                height: 10,
                thickness: 3.0,
                indent: 20,
                endIndent: 20,
                color: Colors.grey[500],
              ),
              Image.network(data['iconUrl']),
              Text(
                data['description'],
                style: const TextStyle(
                    fontSize: 28.0, letterSpacing: 2.0, color: Colors.black),
              ),
              Text(
                '${data['temperature'].toStringAsFixed(2)} ºC',
                style: const TextStyle(fontSize: 66.0, color: Colors.black),
              )
            ],
          )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.pushNamed(context, '/weekdetails', arguments: {
          'week' : week,
        });},
        child: const Icon(Icons.description_outlined),
      ),
    );
  }
}
