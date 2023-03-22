import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class Location {
  late double longitude;
  late double latitude;

  Future<void> getcurrentlocation() async {
    bool serviceenabled;
    LocationPermission permission;
    serviceenabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceenabled) {
      print('location services are not enables');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permission are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      print('locations are denied paermanently');
    }
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
    }catch(e){
      print(e);
    }
  }
}