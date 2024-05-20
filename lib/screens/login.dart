import 'dart:convert';
// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fooddelivery_dbms/constants/colours.dart';
import 'package:fooddelivery_dbms/models/user.dart';
import 'package:fooddelivery_dbms/models/userPreferences/userPreferences.dart';
import 'package:fooddelivery_dbms/screens/HomePage.dart';
import 'package:fooddelivery_dbms/screens/signup.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:fooddelivery_dbms/apiConnection/apiConnect.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget{

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  var emailCont = new TextEditingController();

  var pwCont = new TextEditingController();


  @override
  void initState(){
    super.initState();
    whereToGo();
  }

  whereToGo()async{
    var sharedpref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedpref.getBool("login");
    print(isLoggedIn);
    if(isLoggedIn!){
      Get.to(Home());  
    }
  }
  
  // int uid = 0;
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

  loginUser()async{
    
    try{
      var res = await http.post(
      Uri.parse(api.login),
      body:{
        "email":emailCont.text.trim(),
        "password":pwCont.text.trim(),
      } 
      );

    if (res.statusCode == 200){
      var resBody = jsonDecode(res.body);
      print(resBody);
      // print(resBody["userData"]["userid"]);
      if(resBody['success']==true){
        Fluttertoast.showToast(msg: "Login successful");
        print("login successful");


        User userInfo = User.fromJson(resBody["userData"]);
        await rememberUser.saveCurrentUser(userInfo);
        print("saved current user data");

        emailCont.clear();
        pwCont.clear();


        Future.delayed(Duration(milliseconds: 2000),(){
          Get.to(Home());  
      });
      }
      else{
        Fluttertoast.showToast(msg: "Incorrect credentials");
      }
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
              child: Text("Login",style: TextStyle(fontSize: 30),),
            ),
            txtIpBox("Enter email", emailCont,false,Icons.email),
            txtIpBox("Enter password", pwCont,true,Icons.password),
            ElevatedButton(
              child: Text("L O G I N"),
              onPressed: (){
                if(emailCont.text == "" || pwCont.text == ""){
                    Fluttertoast.showToast(msg: "Please enter all fields");
                }
                else{
                  loginUser();
                }
              }, 
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("New user?"),
                TextButton(
                  onPressed: (){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                      builder: (context) => signUp()
                      ));
                  }, 
                  child: Text(
                    "Sign up",
                    style: TextStyle(decoration: TextDecoration.underline),
                  )
                )
              ],
            )
        
          ]
          ),
      ),
    );
  }
}



  
