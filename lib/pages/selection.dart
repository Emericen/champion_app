import 'package:flutter/material.dart';
import 'package:champion_app/services/database.dart';
import 'package:champion_app/classes/champion.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Selection extends StatefulWidget {
  final Database connection;
  Selection({this.connection});

  @override
  _SelectionState createState() => _SelectionState();
}

class _SelectionState extends State<Selection> {

  Map size = {
    'entry_h': 0.075,
    'avatar_r': 0.03,
  };

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Add a new champion'),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.navigate_before),
          onPressed: () {
            Navigator.pop(context);
          }
        ),
      ),
      body: FutureBuilder(
        future: widget.connection.getUnowned(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Champion> unowned = snapshot.data;
            return ListView.builder(
              itemCount: unowned.length,
              itemBuilder: (context, index) {
                return Container(
                  height: size['entry_h'] * height,
                  child: Center(
                    child: ListTile(
                      title: Text(unowned[index].name),
                      leading: CircleAvatar(
                        radius: size['avatar_r'] * height,
                        backgroundImage: unowned[index].thumbnail,
                      ),
                      onTap: () async {
                        await widget.connection.ownChampion(unowned[index].objectId);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            // show failure
            return Column(
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
            );
          } else {
            // show loading
            return Center(
              child: Container(
                alignment: Alignment.center,
                child: SpinKitFadingCircle(
                  color: Colors.green,
                  size: 70,
                ),
              ),
            );
          }
        }
      ),
    );
  }
}


