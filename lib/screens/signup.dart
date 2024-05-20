import 'dart:convert';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fooddelivery_dbms/constants/colours.dart';
import 'package:fooddelivery_dbms/apiConnection/apiConnect.dart';
import 'package:fooddelivery_dbms/screens/address.dart';

class signUp extends StatelessWidget{
  var usernameCont = new TextEditingController();
  var emailCont = new TextEditingController();
  var pwCont = new TextEditingController();
  var phnoCont = new TextEditingController();

  // late final username,email,pw,phn;
  var username,email,pw,phn;


  Widget txtIpBox(txt,contr,p,iconx){
    return 
      Container(
        margin: EdgeInsets.only(left: 50,right: 50, bottom: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          
        ),
        child: TextField(
          controller: contr,
          obscureText: p,
          decoration: InputDecoration(
            prefixIcon: Icon(iconx, color: tdGrey,size: 20,),
            hintText: txt,
          ),
        ),
    );
  }


  validateUserEmail()async{
    try {
      print("pressed button");

      if(usernameCont.text == "" || emailCont.text == "" || pwCont.text == "" || phnoCont.text == ""){
        Fluttertoast.showToast(msg: "Please enter all fields");
      }
      else{
        username = usernameCont.text.toString();
        email = emailCont.text.toString();
        pw = pwCont.text.toString();
        phn = phnoCont.text.toString();
        print(username);
        print(email);
        print(pw);
        print(phn);

        var response = await http.post(
          Uri.parse(api.validateEmail),
          // passing this data
          body: {
            'email' : emailCont.text.trim(),    
          }
        );
        print("took response");

        if(response.statusCode == 200){ //from flutter app connection with api to server : successful 
            print("connection successful");
            var resBody = jsonDecode(response.body);

            // if emailFound == true i.e row with same email exists
            if(resBody['emailFound'] == true){
              print("email found");
              Fluttertoast.showToast(msg: "account with this email already exists");
            }
            else{
              print("email not found");
              // register new user

              Get.to(address(
                username: username,
                email: email,
                pw: pw,
                phn: phn,
              ));
              
            }
        }
        else{
          print("could not connect");
          print(response.statusCode);
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
              child: Text("Sign Up",style: TextStyle(fontSize: 30),),
            ),
            txtIpBox("Enter username", usernameCont,false,Icons.person),
            txtIpBox("Enter email", emailCont,false,Icons.email),
            txtIpBox("Enter phone number", phnoCont,false,Icons.phone),
            txtIpBox("Enter password", pwCont,true,Icons.password),
            ElevatedButton(
              child: Text("S I G N   U P"),
              onPressed: (){
                validateUserEmail();
              }, 
            ),
        
          ]
          ),
      ),
    );
  }
  
}


  
