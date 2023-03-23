
import 'package:flutter/material.dart';
import 'package:weather/loading_screen.dart';

void main() {
  runApp( Myapp());
}


class Myapp extends StatefulWidget {
  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home(),);
  }
}
