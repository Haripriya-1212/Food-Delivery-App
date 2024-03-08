import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fooddelivery_dbms/constants/colours.dart';
import 'package:fooddelivery_dbms/models/cartItemData.dart';
import 'package:fooddelivery_dbms/models/foodData.dart';
import 'package:fooddelivery_dbms/screens/cart.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';




class cartItem extends StatefulWidget{
  final cartItemData food;
  final Function(double,int)? callback;


  const cartItem({
    required this.food,
    required this.callback
  });


  @override
  State<cartItem> createState() => _cartItemState();
}

class _cartItemState extends State<cartItem> {
   

  removeFromCart(cartItemData item)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartData = prefs.getStringList('cart');
    if (cartData != null) {
      // Convert JSON strings to foodData objects
      List<foodData> cartItems = cartData.map((json) => foodData.fromJson(jsonDecode(json))).toList();
      
      // Find and remove the item from the list
      cartItems.remove(item);
      
      // Encode the updated list back to JSON strings
      List<String> updatedCartData = cartItems.map((item) => jsonEncode(item.toJson())).toList();

      // Save the updated list back to shared preferences
      await prefs.setStringList('cart', updatedCartData);
      print("updated cart data");
      
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
              margin: EdgeInsets.only(top: 30),
              width: double.infinity,
              height: 100,
              color: tdBGColor,
              child: Stack(
                children: [
                  
                  Positioned(
                    top: 20,
                    left: 18,
                    right: 18,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.food.name,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 22,color: Colors.black),),
                                Row(
                                children: [
                                  Icon(Icons.currency_rupee,color: Colors.black,size: 17,),
                                  Text(widget.food.price.toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.black),),
                                ],
                              ),
                              ],
                            ),
              
              
                          Row(
                            children: [
                              SizedBox(
                                width: 35,
                                height: 35,
                                child: TextButton(
                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                                  onPressed: (){
                                    
                                    setState(() {
                                      // if(widget.food.qty == 0){
                                      //   removeFromCart(widget.food);
                                      // }
                                      if(widget.food.qty != 0){
                                      widget.food.qty = widget.food.qty -1;
                                      widget.callback!(double.parse(widget.food.price),0);  
                                    }
                                    });
                                  }, 
                                  child: Text("-",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 15),),
                                ),
                              ),
                              SizedBox(width: 15,),
                              Text(widget.food.qty.toString(),style: TextStyle(fontWeight: FontWeight.w700,color: Colors.black,fontSize: 15)),
                              SizedBox(width: 15,),
                              SizedBox(
                                width: 35,
                                height: 35,
                                child: TextButton(
                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                                  onPressed: (){
                                    
                                    setState(() {
                                      widget.food.qty = widget.food.qty + 1;
                                      widget.callback!(double.parse(widget.food.price),1);
                                    });
                                  }, 
                                  child: Text("+",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 15),),
                                ),
                              ),
                              
                            ],
                          )
                        ],
                        ),
                    ),
                ],
              ),
            );
  }
}
