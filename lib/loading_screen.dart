import 'package:flutter/material.dart';
import 'package:weather/location.dart';
import 'package:weather/networkhelper.dart';
import 'package:weather/location_screen.dart';


class Home extends StatefulWidget {

  @override
  State<Home> createState() => _homeState();
}

class _homeState extends State<Home> {
  var appid = "6baeb26e22c6fadd4406fed2b0b29d1e";

  @override
  void initState() {
    // TODO: implement initState
    getlocation();
    super.initState();
  }

  Future<void> getlocation() async {
    Location location = Location();
    await location.getcurrentlocation();


    Networkhelper helper = Networkhelper("https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$appid&units=metric");
    var weatherdata =  await helper.getdata();
    print(location.latitude);
    print(location.longitude);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(weatherdata: weatherdata,);
    }));


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              getlocation();
            },
            child: Text('Get Location'),
          ),
        ),
      );
  }
}
