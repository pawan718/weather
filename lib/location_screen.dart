import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather/utility/city_screen.dart';
import 'package:weather/utility/contants.dart';
import 'package:weather/weathermodel.dart';
import 'package:weather/loading_screen.dart';
import 'networkhelper.dart';

class LocationScreen extends StatefulWidget {

  LocationScreen({this.weatherdata});
  final weatherdata;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late var temperature;
  late var weathericon;
  late var cityname;
  late String weathermessage;
WeatherModel weatherModel = WeatherModel();
LocationScreen locationScreen = LocationScreen();
Home home = Home();

  @override
  void initState() {
    updateui(widget.weatherdata);
    super.initState();
  }
  void updateui(dynamic weatherdata){
    setState(() {
     double temp = weatherdata['main']['temp'];
     temperature = temp.toInt();
     weathericon = weatherdata['weather'][0]['id'];
     weathericon = weatherModel.getWeatherIcon(weathericon);
     cityname = weatherdata['name'];
     weathermessage = weatherModel.getMessage(temperature);
    });
  }
  @override
  Widget build(BuildContext context) {
    bool shouldPop = false;
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Do you want to go back?'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/location_background.jpeg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.dstATop),
            ),
          ),
          constraints: BoxConstraints.expand(),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                       var weatherdata= locationScreen.weatherdata;
                       updateui(weatherdata);
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 50.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                    var typedname  =   await  Navigator.push(context, MaterialPageRoute(builder: (context){
                          return CityScreen();
                        }
                        ),);
                    if(typedname!=null){
                     var weatherdata = await home.getcityname(typedname);
                     updateui(weatherdata);
                    }
                      },
                      child: Icon(
                        Icons.location_city,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '$temperature°',
                        style: kTempTextStyle,
                      ),
                      Text(
                        weathericon,
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    '$weathermessage in  $cityname',
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
