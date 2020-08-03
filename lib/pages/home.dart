import 'package:flutter/material.dart';
import 'package:champion_app/services/database.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: Text(
            'Hello there!',
            style: TextStyle(
              fontSize: 35,
              color: Colors.black,
            )
          ),
        ),
      ),
    );
  }
}









