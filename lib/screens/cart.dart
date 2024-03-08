import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fooddelivery_dbms/constants/colours.dart';
import 'package:fooddelivery_dbms/models/cartItemData.dart';
import 'package:fooddelivery_dbms/models/foodData.dart';
import 'package:fooddelivery_dbms/models/user.dart';
import 'package:fooddelivery_dbms/models/userPreferences/userPreferences.dart';
import 'package:fooddelivery_dbms/screens/HomePage.dart';
import 'package:fooddelivery_dbms/screens/login.dart';
import 'package:fooddelivery_dbms/screens/orderPlaced.dart';

import 'package:fooddelivery_dbms/widgets/cartItem.dart';
import 'package:fooddelivery_dbms/widgets/fooditem.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

import 'package:http/http.dart' as http;
import 'package:fooddelivery_dbms/apiConnection/apiConnect.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';




class cartPage extends StatefulWidget{

  @override
  State<cartPage> createState() => _cartPageState();
}

class _cartPageState extends State<cartPage> {
  double totalAmt = 0.0;



  List<cartItemData> cartItems = [];

  @override
  void initState() {
    print("entered initState");
    super.initState();

    _loadCart();
  }

  void _calculateTotalAmount() {
    print("entered _calculateTotalAmount()");
    totalAmt = cartItems.fold(0.0, (sum, item) => sum + double.parse(item.price * item.qty));
    print("added prices");
    print(totalAmt);
  }


  Future<void> _loadCart() async {
    print("entered loadcart");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartData = prefs.getStringList('cart');
    print(cartData);
    if (cartData != null) {
      setState(() {
       cartItems = cartData.map((json) => cartItemData.fromJson(jsonDecode(json))).toList();
      });
      print("loaded cart");
    }
    _calculateTotalAmount();
  }



  placeOrder()async{
    User? currentUser = await rememberUser.readCurrentUser(); 
    int id = currentUser!.user_id;
    print(id);
    String s1 = id.toString();
    String s2 = totalAmt.toString();


    print("entered placeOrder");
    try{
      print(id.toString());
      print(totalAmt.toString());

      var res = await http.post(
        Uri.parse(api.placeOrder),
        body:{
          "userid": s1,
          "amount": s2,
          "status":"not delivered"
        } 
      );
      
      print("sent data");


      if (res.statusCode == 200){
        print("connection successful");
        var resBody = jsonDecode(res.body);
        // print(resBody);
        if(resBody['success']==true){
          Fluttertoast.showToast(msg: "Order Placed!");
          print("order placed");

          Get.to(orderplacedScreen());

        }
        else{
          Fluttertoast.showToast(msg: "error");
          Get.to(orderplacedScreen());

        }
      }
    }
    catch(e){
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  updateAmt(double x, int y){
    if(y == 1){
      totalAmt += x;
    }
    else{
      totalAmt -= x;
    }
    
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(
          children: [
            SizedBox(height: 20,),
            Text("Your Cart",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600),),
            SizedBox(height: 10,),

            for (cartItemData f in cartItems)
              cartItem(food: f, callback: updateAmt ,)
            ,
            SizedBox(height: 30),

            Row(
              children: [
                Text("Total = ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
                Icon(Icons.currency_rupee,color: Colors.black,size: 18,),
                Text(totalAmt.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500))
              ],
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: (){
                placeOrder();
              }, 
              child: Text("P L A C E   O R D E R",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              )
            )

          ],
        ),
      ),

    );
  }
}


