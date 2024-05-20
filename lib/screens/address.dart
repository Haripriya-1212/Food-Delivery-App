import 'dart:convert';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fooddelivery_dbms/constants/colours.dart';
import 'package:fooddelivery_dbms/screens/HomePage.dart';
import 'package:fooddelivery_dbms/screens/cart.dart';
import 'package:fooddelivery_dbms/screens/signup.dart';
import 'package:fooddelivery_dbms/apiConnection/apiConnect.dart';

class address extends StatelessWidget{
  var doorNoCont = new TextEditingController();
  var streetCont = new TextEditingController();
  var areaCont = new TextEditingController();
  var cityCont = new TextEditingController();
  var pcCont = new TextEditingController();


  final String username;
  final String email;
  final String pw;
  final String phn;

  address({
    required this.username,
    required this.email,
    required this.pw,
    required this.phn,
  });


  Widget txtIpBox(txt,contr){
    return 
      Container(
        margin: EdgeInsets.only(left: 50,right: 50, bottom: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          
        ),
        child: TextField(
          controller: contr,
          decoration: InputDecoration(
            hintText: txt,
            contentPadding: EdgeInsets.only(left: 18)
          ),
        ),
    );
  }



  saveUser()async{
    try {
      print("entered save user");
      print("pressed button");

      if(doorNoCont.text == "" || streetCont.text == "" || areaCont.text == "" || cityCont.text == "" || pcCont.text == ""){
        Fluttertoast.showToast(msg: "Please enter all fields");
      }
      else{
        print(username);
        print(email);
        print(pw);
        print(phn);
        var response = await http.post(
          Uri.parse(api.signUp),
          // passing this data
          body: {
            'username':username,
            'email' : email,
            'password' : pw,
            'phoneNum' : phn,
            'flatNum':doorNoCont.text.trim(),
            'street' : streetCont.text.trim(),
            'area' : areaCont.text.trim(),
            'city' : cityCont.text.trim(),
            'pincode' : pcCont.text.trim(),
            
          }
        );
        print("took response");

        if(response.statusCode == 200){ //from flutter app connection with api to server : successful 
            print("connection successful");
            var resBody = jsonDecode(response.body);

            // if emailFound == true i.e row with same email exists
            if(resBody['success'] == true){
              print("sign up successful");
              // int usrid = resBody['userId'];
              
              Fluttertoast.showToast(msg: "account created successfully");

              Future.delayed(Duration(milliseconds: 2000),(){
                  Get.to(Home());  
              });
            }
            else{
              print("sign up unsuccessful");
              Fluttertoast.showToast(msg: "Error. sign up unsuccessful");
            }
        }
        else{
          print("could not connect");
        } 
      }
    } 
    catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tdBGColor,
      ),
      body: Container(
        color: tdBGColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text("Set Address",style: TextStyle(fontSize: 30),),
            ),
            txtIpBox("Flat/Door number", doorNoCont),
            txtIpBox("Street", streetCont),
            txtIpBox("Area", areaCont),
            txtIpBox("City", cityCont),
            txtIpBox("Pincode", pcCont),
            ElevatedButton(
              child: Text("F I N I S H"),
              onPressed: (){
                saveUser();
              }, 
            ),
        
          ]
          ),
      ),
    );
  }
  
}


  
