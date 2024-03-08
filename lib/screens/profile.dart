import 'package:flutter/material.dart';
import 'package:fooddelivery_dbms/models/user.dart';
import 'package:fooddelivery_dbms/models/userPreferences/userPreferences.dart';

class profilePage extends StatefulWidget{
  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  User? currentUserData;

  @override
  void initState(){
    super.initState();
    loadCurrentUser();
  }

  loadCurrentUser()async{
    User? Data = await rememberUser.readCurrentUser();
    setState(() {
      currentUserData = Data;
    });

  }

  @override
  Widget build(BuildContext context) {
    String flat = currentUserData!.user_flatnum.toString();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(
          children: [
            SizedBox(height: 15,),
            Text(currentUserData!.user_name,style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700),),
            // Text("name",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700),),
            SizedBox(height: 5,),
            Text("Address",style:TextStyle(fontWeight: FontWeight.w700)),
            Text("# $flat"),
            Text(currentUserData!.user_street),
            Text(currentUserData!.user_area),
            Text(currentUserData!.user_city),
            Text(currentUserData!.user_pincode.toString()),
            SizedBox(height: 30,),
            Text("Email",style:TextStyle(fontWeight: FontWeight.w700)),
            Text(currentUserData!.user_email),
            SizedBox(height: 15,),
            Text("Phone Number",style:TextStyle(fontWeight: FontWeight.w700)),
            Text(currentUserData!.user_num),
            SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
}