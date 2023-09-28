import 'package:flutter/material.dart';
import 'package:world_time_flutter/services/world_weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  setUpWorldWeather() async {
    WorldTime instance = WorldTime(lat: '38.736946', lon: '-9.142685', location: 'Lisbon', flag: 'lisbon.jpg');
    await instance.getWeather();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'temperature': instance.temperature,
      'description': instance.description,
      'iconUrl' : instance.iconUrl,
      'week' : instance.week
    });
  }

  @override
  void initState() {
    super.initState();
    setUpWorldWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(child: Image.asset('assets/AppIcon.png', width: 80, height: 80,)),
            const Text("Loading...",
                style: TextStyle(
                    fontSize: 28.0,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 20.0,),
            const SpinKitRing(
              color: Colors.white,
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
