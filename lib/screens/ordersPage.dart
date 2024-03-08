import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fooddelivery_dbms/constants/colours.dart';
import 'package:fooddelivery_dbms/models/user.dart';
import 'package:fooddelivery_dbms/models/userPreferences/userPreferences.dart';
import 'package:fooddelivery_dbms/apiConnection/apiConnect.dart';
import 'package:http/http.dart' as http;

class userOrder extends StatefulWidget{
  @override
  State<userOrder> createState() => _userOrderState();
}

class _userOrderState extends State<userOrder> {
  int uid = 0;

  @override
  void initState() {
    getUserid();
  }

  getUserid()async{
    print("entered getUserid");
    User? currentUser = await rememberUser.readCurrentUser();
    uid = currentUser!.user_id;
    getOrdersData(uid);
  }

  getOrdersData(int x)async{
    print("entered getOrdersData");
    try{
      var res = await http.post(
      Uri.parse(api.getOrderData),
      body:{
        "userid":uid.toString()
      } 
      );
    print("sent data");

    if (res.statusCode == 200){
      print("connection successful");
      var resBody = jsonDecode(res.body);
      print(resBody);
      if(resBody['success']==true){
        Fluttertoast.showToast(msg: "got orders");
        print("got orders");

      }
      else{
        Fluttertoast.showToast(msg: "couldn't load orders");
        print("couldn't load orders");
      }
    }
    else{
      print("couldn't connect");
      print(res.statusCode);
    }
    }
    catch(e){
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: tdBGColor,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView(
            children: [
              Text("Your Orders",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700)),
              orderBox(),
              orderBox(),
              orderBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget orderBox(){
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
          height: 100,
          color: Color.fromARGB(255, 255, 255, 255),
      
          child: Text("order")
        ),
    );

  }
}