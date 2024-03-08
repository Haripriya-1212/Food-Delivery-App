import 'package:flutter/material.dart';
import 'package:fooddelivery_dbms/constants/colours.dart';
import 'package:fooddelivery_dbms/screens/HomePage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class orderplacedScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 110),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Order Placed!", style: TextStyle(fontSize: 30)),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: (){
                  Get.to(
                    Home()
                  );
                }, 
                child: Text("Get back to home")
              )
        
          ],
            
            ),
      )
    );

  }

}