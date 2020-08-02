import 'package:flutter/material.dart';
import 'package:champion_app/services/database.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(color: Colors.redAccent,),
        Container(color:Colors.red[400])
      ],
    );
  }
}




