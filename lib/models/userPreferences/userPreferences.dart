import 'dart:convert';

import 'package:fooddelivery_dbms/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class rememberUser{

  // save current user data
  static Future<void> saveCurrentUser(User info) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userJsonData = jsonEncode(info);
    print(userJsonData);
    await preferences.setString("currentUserData", userJsonData);
    await preferences.setBool("login", true);
  }

  // get current user data
  static Future<User?> readCurrentUser() async{
    User? currentUserInfo;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? data = preferences.getString("currentUserData");
    if(data != null){
      Map<String, dynamic> userDataMap = jsonDecode(data);
      currentUserInfo = User.fromJson(userDataMap);
    }
    return currentUserInfo;
  }

  static Future<void> logoutCurrentUser()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool("login", false);
    List<String> cartItems = [];
    await preferences.setStringList('cart', cartItems);
  }


}