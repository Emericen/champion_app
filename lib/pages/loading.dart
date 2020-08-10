import 'package:flutter/material.dart';
import 'package:champion_app/services/database.dart';
import 'package:champion_app/pages/authentication.dart';
import 'package:champion_app/pages/register.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:champion_app/services/transition.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void connectToServer() async {
    Database connection = await Database();
    await new Future.delayed(const Duration(seconds : 1));
    print('eddy');
//    Navigator.pushReplacement(
//      context,
//      EnterRoute(
//        thisPage: this.widget,
//        nextPage: Register(connection: connection),
//        newPageDirection: Offset(0,0)
//      )
//    );
  }

  @override
  void initState() {
    super.initState();
    print('wtf');
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




