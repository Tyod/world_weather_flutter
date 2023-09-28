import 'dart:io';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:world_time_flutter/services/world_weather.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  String myLat = "0.0", myLon = "0.0";
  Location location = Location();

  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;
  LocationData? _locationData;

  List<WorldTime> locations = [
    WorldTime(lat: '27.700769', lon: '85.300140', location: 'Kathmandu', flag: 'nepal.png'),
    WorldTime(lat: '51.509865', lon: '-0.118092', location: 'London', flag: 'uk.png'),
    WorldTime(lat: '37.983810', lon: '23.727539', location: 'Athens', flag: 'greece.png'),
    WorldTime(lat: '30.033333', lon: '31.233334', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(lat: '-1.286389', lon: '36.817223', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(lat: '41.881832', lon: '-87.623177', location: 'Chicago', flag: 'usa.png'),
    WorldTime(lat: '-22.908333', lon: '-43.196388', location: 'Rio de Janeiro', flag: 'brasil.png'),
    WorldTime(lat: '37.532600', lon: '127.024612', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(lat: '-6.200000', lon: '106.816666', location: 'Jakarta', flag: 'indonesia.png'),
    WorldTime(lat: '38.736946', lon: '-9.142685', location: 'Lisbon', flag: 'lisbon.jpg')
  ];

  @override
  void initState() {
    super.initState();
    locations.add(WorldTime(lat: myLat, lon: myLon, location: 'My Location', flag: 'myLocation.png'));
  }

  Future<void> _fetchLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    }

    await _getCoordinates();
  }


  Future<void> _getCoordinates() async {
    locations.removeAt(10);
    _locationData = await location.getLocation();
    myLat = (_locationData?.latitude).toString();
    myLon = (_locationData?.longitude).toString();
    locations.add(WorldTime(lat: myLat, lon: myLon, location: 'My Location', flag: 'myLocation.png'));
    print(myLat);
    print(myLon);
  }

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getWeather();

    //Navigate to home screen
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'temperature': instance.temperature,
      'description': instance.description,
      'iconUrl': instance.iconUrl,
      'week': instance.week
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text("Choose a location"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () async {
                  if (index == 10) {
                    await _fetchLocation();
                    if (!_serviceEnabled) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Service isn't enabled!"),
                      ));
                    } else {
                      if (_permissionGranted == PermissionStatus.denied) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Permission wasn't granted!"),
                        ));
                      } else {
                        if (_locationData == null) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Couldn't get Data Location!"),
                          ));
                        } else {
                          updateTime(index);
                        }
                      }
                    }
                  }
                  else {
                    updateTime(index);
                  }
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/${locations[index].flag}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
