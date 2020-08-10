import 'package:champion_app/services/transition.dart';
import 'package:flutter/material.dart';
import 'package:champion_app/services/database.dart';
import 'package:champion_app/classes/champion.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:champion_app/pages/authentication.dart';
import 'package:champion_app/pages/selection.dart';


class Home extends StatefulWidget {
  final Database connection;
  Home({this.connection});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map size = {
    'entry_h': 0.075,
    'avatar_r': 0.03,
  };

  List<Champion> unowned;

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(widget.connection.currentUser['username']),
        centerTitle: true,
        elevation:0,
        leading: IconButton(
          icon: const Icon(Icons.navigate_before),
          onPressed: () {
            widget.connection.logout();
            Navigator.pushReplacement(
              context,
              EnterExitRoute(
                thisPage: this.widget,
                nextPage: SignIn(connection: widget.connection),
                newPageDirection: Offset(-1,0)
              )
            );
          }
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                EnterRoute(
                  thisPage: this.widget,
                  nextPage: Selection(connection: widget.connection),
                  newPageDirection: Offset(1, 0),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: widget.connection.getOwned(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Champion> champions = snapshot.data;
              return ListView.builder(
                itemCount: champions.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: size['entry_h'] * height,
                    child: Center(
                      child: ListTile(
                        title: Text(champions[index].name),
                        leading: CircleAvatar(
                          radius: size['avatar_r'] * height,
                          backgroundImage: champions[index].thumbnail,
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.grey,
                          ),
                          onPressed: () async {
                            await widget.connection.deleteChampion(champions[index].objectId);
                            setState(() {
                              champions.removeAt(index);
                            });
                          },
                        ),
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
      ),
    );
  }
}









