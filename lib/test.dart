import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('test'),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              print('add champion button pressed');
            },
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            SizedBox(height:300),
            Icon(
              Icons.error_outline,
              color: Colors.grey,
              size: 40
            ),
            SizedBox(height:20),
            Text(
              'Unable to load data.',
              style: TextStyle(
                fontSize: 25,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
