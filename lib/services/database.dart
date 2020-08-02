import 'dart:convert';
import 'package:leancloud_storage/leancloud.dart';


class Database {

  LCObject currentUser;

  Database() {
    LeanCloud.initialize(
        'aAiiV2Rde8ou80vX6YMnCvAx-9Nh9j0Va',
        'DW9TsPU1DjBd6TLEKXJEAe6x',
        server: 'https://aaiiv2rd.lc-cn-e1-shared.com',
        queryCache: new LCQueryCache()
    );
  }

  void registerUser(String username, String password) async {
    LCObject newUser = LCObject('Player');
    newUser['username'] = username;
    newUser['password'] = password;
    await newUser.save();
    print('registered user $username');
  }

  void login(String username, String password) async {
    LCObject user = await _getUser(username);
    if (user != null) {
      if (user['password'] == password) {
        currentUser = user;
        print('logged in $username');
        return;
      }
    }
    print('Wrong username or password!');
  }

  void logout() async {
    String username = currentUser['username'];
    currentUser = null;
    print('logged out $username.');
  }

//  void ownChampion(String championName) async {
//    if (currentUser != null) {
//      LCObject champion = await _getChampion(championName);
//      LCObject newOwnerShip = LCObject('Ownership');
//      newOwnerShip['userId'] = _getObjectId(currentUser);
//      newOwnerShip['championId'] = _getObjectId(champion);
//      await newOwnerShip.save();
//      print('${currentUser['username']} owned ${champion['Name']}');
//    } else {
//      print('error: please log in a user first.');
//      return;
//    }
//  }

  // pre-req: championId must be in champions list.
  void ownChampion(String championId) async {
    if (currentUser != null) {
      LCObject newOwnerShip = LCObject('Ownership');
      newOwnerShip['userId'] = _getObjectId(currentUser);
      newOwnerShip['championId'] = championId;
      await newOwnerShip.save();
    } else {
      print('error: please log in a user first');
      return;
    }
  }

  Future<List<String>> getOwned() async {
    LCQuery championQuery = LCQuery('Champion');
    LCQuery ownershipQuery = LCQuery('Ownership');
    List<String> listOfNames = [];
    ownershipQuery.whereEqualTo('userId', _getObjectId(currentUser));
    List<LCObject> result = await ownershipQuery.find();
    for (LCObject ownership in result) {
      LCObject champion = await championQuery.get(ownership['championId']);
      listOfNames.add(champion['Name']);
    }
    return listOfNames;
  }


  ////////////////////// kernel /////////////////////////////

  String _getObjectId(LCObject obj) {
    return jsonDecode(obj.toString())['objectId'];
  }

  Future<LCObject> _getUser(String username) async {
    LCQuery<LCObject> userQuery = LCQuery('Player');
    userQuery.whereEqualTo('username', username);
    List<LCObject> result = await userQuery.find();
    if (result.length == 0)
      return null;
    else
      return result[0];
  }

  Future<LCObject> _getChampion(String championName) async {
    LCQuery championQuery = LCQuery('Champion');
    championQuery.whereEqualTo('Name', championName);
    List<LCObject> result = await championQuery.find();
    if (result.length == 0)
      return null;
    else
      return result[0];
  }

}













