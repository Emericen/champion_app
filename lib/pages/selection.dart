import 'package:flutter/material.dart';
import 'package:champion_app/classes/champion.dart';

class Selection extends StatefulWidget {
  @override
  _SelectionState createState() => _SelectionState();
}

class _SelectionState extends State<Selection> {

  Map size = {
    'entry_h': 0.075,
    'avatar_r': 0.03,
  };

  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty? data : ModalRoute.of(context).settings.arguments;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

//    List<Champion> unowned = await data['Database'].getUnowned()


    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Add a new champion'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            height: size['entry_h'] * height,
            child: Center(
              child: ListTile(
                title: Text(data['Champion'].name),
                leading: CircleAvatar(
                  radius: size['avatar_r'] * height,
                  backgroundImage: NetworkImage(data['Champion'][index].thumbnailUrl),
                ),

              ),
            ),
          );
        },
      ),
    );
  }
}


