import 'package:flutter/material.dart';
import 'package:weather/location.dart';
import 'package:weather/networkhelper.dart';
import 'package:weather/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather/weathermodel.dart';
class Home extends StatefulWidget {


  @override
  State<Home> createState() => _homeState();
  var appid = "6baeb26e22c6fadd4406fed2b0b29d1e";
  Future<dynamic> getcityname(String cityname) async{

    Networkhelper helper = await Networkhelper("https://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=$appid&units=metric");
    var weatherdata =  await helper.getdata();
    return weatherdata;
  }
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

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(weatherdata: weatherdata,);
    }));


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SpinKitDoubleBounce(color: Colors.black,size: 100.0,),

      );
  }
}
