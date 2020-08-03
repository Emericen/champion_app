import 'package:flutter/material.dart';
import 'package:champion_app/services/database.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  Map data = {};
  Database connection;

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty? data : ModalRoute.of(context).settings.arguments;
    connection = data['connection'];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: Text(
              'Welcome!',
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
