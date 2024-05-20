import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fooddelivery_dbms/models/cartItemData.dart';
import 'package:fooddelivery_dbms/models/foodData.dart';
import 'package:fooddelivery_dbms/screens/cart.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class fooditem extends StatelessWidget{
  final foodData x;
  // final int uid;
  List<foodData> cartItems = [];
  double Amount = 0.0;

  fooditem({
    required this.x,
    // required this.uid,
  });

  addToCart(foodData item)  async{

    cartItemData cartData = cartItemData.fromfoodData(item);

    SharedPreferences prefs = await SharedPreferences.getInstance();
  
    // Retrieve the current list from shared preferences
    List<String>? itemList = prefs.getStringList('cart');

    // If itemList is null, initialize it as an empty list
    itemList ??= [];

    // Add the new item to the list
    itemList.add(jsonEncode((cartData.toJson())));

    // Save the updated list back to shared preferences
    await prefs.setStringList('cart', itemList);

    print("item added to cart");
    Fluttertoast.showToast(msg: "item added to cart");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20,left: 10,right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          children: [
            Container(
              width: 400,
              height: 200,
              child: FittedBox(
                // margin: EdgeInsets.only(left: 25,right: 25,top: 20),
                 fit: BoxFit.fill,
                         
                child: Image.asset(x.imgPath),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: 400,
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black,Colors.black12],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter
                  )
                ),
              ),
            ),
        
            Positioned(
              bottom: 20,
              left: 18,
              right: 18,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(x.name,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 22,color: Colors.white),),
                          Text(x.desc,style: TextStyle(fontSize: 12,color: Colors.white))
                        ],
                      ),
        
        
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.currency_rupee,color: Color.fromARGB(255, 54, 224, 236),size: 17,),
                              Text(x.price.toString(),style: TextStyle(fontWeight: FontWeight.w700,fontSize: 15,color: Color.fromARGB(255, 54, 224, 236)),),
                            ],
                          ),
                          SizedBox(height: 10,),
                          SizedBox(
                            height: 20,
                            width: 70,
                            child: ElevatedButton(
                              child: Text("ADD",style: TextStyle(fontSize: 10,color: Colors.black),),
                              onPressed: (){
                                addToCart(x);
                                Amount = Amount + double.parse(x.price);
                                Get.to(cartPage());
                              },
                            )
                          )
                        ],
                      )
                    ],
                  ),
              ),
          ],
        ),
      ),
    );
  }

}