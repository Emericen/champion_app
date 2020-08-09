import 'package:flutter/material.dart';
import 'package:champion_app/services/database.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void connectToServer() async {
    Database connection = await Database();
    await new Future.delayed(const Duration(seconds : 1));
    Navigator.pushReplacementNamed(context, '/signin', arguments: {
      'connection': connection
    });
  }

  @override
  void initState() {
    super.initState();
    connectToServer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.green,
          size: 70,
        )
      ),
    );
  }
}




