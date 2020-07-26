import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

SharedPreferences prefs;

class Shared {

  static Future<SharedPreferences> initShared() async {
    prefs=await SharedPreferences.getInstance();
    print('Shared Preferences initialized!');
    return Future.value(prefs);
  }

  static void storeUser(User user) {
    prefs.setString('user', json.encode(user.toMap()));
    print('User Set!');
  }

  static Future<User> getUser() {
    return Future.value(User.fromJson(json.decode(prefs.getString('user'))));
  }

  static Future<List<dynamic>> getRecords() {
    print('records fetched!');
    String events=prefs.getString('records');
    if(events==null) {
      return Future.value([]);
    }
    return Future.value(json.decode(events));
  }

  static Future<void> setRecords(List<dynamic> records) {
    print('Records set!');
    List<Map<String, String>> recordsMap=[];
    for(int i=0;i<records.length;i++) {
      recordsMap.add(records[i].toMap());
    }
    return Future.value(prefs.setString('events', json.encode(recordsMap)));
  }

  static void setLastSaved(String date) {
    prefs.setString('lastSaved', date);
  }
  
  static Future<String> getLastSaved() {
    return Future.value(prefs.getString('lastSaved'));
  }
}
