import 'package:flutter/material.dart';
import 'package:champion_app/services/database.dart';
import 'package:champion_app/classes/champion.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map size = {
    'entry_h': 0.075,
    'avatar_r': 0.03,
  };

  Map data = {};
  Database connection;

  List<Champion> unowned;

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty? data : ModalRoute.of(context).settings.arguments;
    connection = data['connection'];
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(connection.currentUser['username']),
        centerTitle: true,
        elevation:0,
        leading: IconButton(
          icon: const Icon(Icons.navigate_before),
          onPressed: () {
            connection.logout();
            Navigator.pushReplacementNamed(context, '/signin', arguments: {
              'connection': data['connection']
            });
          }
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/selection', arguments: {
                'connection': data['connection']
              });
            },
          ),
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: connection.getOwned(),
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









