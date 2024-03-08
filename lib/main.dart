import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fooddelivery_dbms/screens/HomePage.dart';
import 'package:fooddelivery_dbms/screens/address.dart';
// import 'package:fooddelivery_dbms/screens/HomePage.dart';
import 'package:fooddelivery_dbms/screens/login.dart';
import 'package:fooddelivery_dbms/screens/orderPlaced.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:fooddelivery_dbms/screens/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    // making statusBar bg transparent
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent)
    );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo',
      home: Home(),
      // initialBinding: BindingsBuilder(() {
      //   Get.put(CartController());
      // }),
    );
  }
}

