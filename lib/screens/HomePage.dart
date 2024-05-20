import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fooddelivery_dbms/constants/colours.dart';
import 'package:fooddelivery_dbms/models/foodData.dart';
import 'package:fooddelivery_dbms/models/userPreferences/userPreferences.dart';
import 'package:fooddelivery_dbms/screens/cart.dart';
import 'package:fooddelivery_dbms/screens/login.dart';
import 'package:fooddelivery_dbms/screens/orderPlaced.dart';
import 'package:fooddelivery_dbms/screens/ordersPage.dart';
import 'package:fooddelivery_dbms/screens/profile.dart';
import 'package:fooddelivery_dbms/widgets/fooditem.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:fooddelivery_dbms/apiConnection/apiConnect.dart';


class Home extends StatefulWidget{
  // final int uid;

  // final String name;
  // final double price;

  // const Home({
  //   required this.uid,
  // });
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var searchTxt = new TextEditingController();

  List<foodData> foodLst = foodData.foodList;
  List<foodData> _foundFood = [];

  List<foodData> Menu = [];

  @override
  void initState(){
    super.initState();
    fetchMenu();
    _foundFood = Menu;
  }

  Future<void> fetchMenu() async {
    try{
      final response = await http.get(Uri.parse(api.getMenu));
      if (response.statusCode == 200) {
        print("connection successful");
        var resBody = jsonDecode(response.body);
        print(resBody);

        if(resBody['success']==false){
          Fluttertoast.showToast(msg: "couldn't load menu");
          print("couldn't load menu");
        }
        else{
          print("loaded menu");
          List<dynamic> menuList = resBody['Menu'];
          List<foodData> menu = menuList.map((item) => foodData.fromJson(item)).toList();
          // If the server returns a success response, parse the JSON
          setState(() {
          Menu = menu;
        });
      }
        
      } 
      else {
        // If the server returns an error response, throw an exception
        Fluttertoast.showToast(msg: "couldn't connect");
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
        elevation: 0,
        actions: [
          Container(
          margin: EdgeInsets.only(right: 25),
          child: IconButton(
            icon:Icon(Icons.person, size: 32,color: Colors.black,), 
            onPressed: () { 
              Navigator.push(
                      context, 
                      MaterialPageRoute(
                      builder: (context) => profilePage()
                      ));
             },
            )
          ),     
        ],
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text("View",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w700)),
              decoration: BoxDecoration(
              color: Colors.black,
              ),
            ),
            // ListTile(
            //   leading: const Icon(Icons.list_alt_outlined,color: Colors.black,),
            //   title: const Text(' My Orders '),
            //   onTap: () {
            //     Get.to(userOrder()); 
            //   },
            // ),
            ListTile(
              leading: const Icon(Icons.shopping_cart,color: Colors.black,),
              title: const Text(' My Cart '),
              onTap: () {
                Get.to(cartPage()); 
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout,color: Colors.black,),
              title: const Text('LogOut'),
              onTap: () {
                rememberUser.logoutCurrentUser();
                // Get.back(result: login());
                Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(
                      builder: (context) => login()
                      ));
              },
            ),
          ],
        ),
      ),

      
      body: Container(
        color: tdBGColor,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              searchBox(),

                Expanded(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom:20.0, top: 20, left: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Today's pick", style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700),)
                          ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        height: 160,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              child: ClipRRect( 
                                borderRadius: BorderRadius.circular(10.0),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 160,
                                      height: 160,
                                      child: FittedBox(
                                        // margin: EdgeInsets.only(left: 25,right: 25,top: 20),
                                        fit: BoxFit.fill,
                                                
                                        child: Image.asset("assets/images/pizza.jpg"),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      child: Container(
                                        width: 160,
                                        height: 80,
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
                                                  Text("Pizza",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 22,color: Colors.white),),
                                                ],
                                              ),
                                            ]
                                      )
                                    )
                                  ]
                                )
                              ),
                            ),
        
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              child: ClipRRect( 
                                borderRadius: BorderRadius.circular(10.0),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 160,
                                      height: 160,
                                      child: FittedBox(
                                        // margin: EdgeInsets.only(left: 25,right: 25,top: 20),
                                        fit: BoxFit.fill,
                                                
                                        child: Image.asset("assets/images/pasta3.jpg"),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      child: Container(
                                        width: 160,
                                        height: 80,
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
                                                  Text("Pasta",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 22,color: Colors.white),),
                                                ],
                                              ),
                                            ]
                                      )
                                    )
                                  ]
                                )
                              ),
                            ),
        
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              child: ClipRRect( 
                                borderRadius: BorderRadius.circular(10.0),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 160,
                                      height: 160,
                                      child: FittedBox(
                                        // margin: EdgeInsets.only(left: 25,right: 25,top: 20),
                                        fit: BoxFit.fill,
                                                
                                        child: Image.asset("assets/images/pizza.jpg"),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      child: Container(
                                        width: 160,
                                        height: 80,
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
                                                  Text("Pizza",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 22,color: Colors.white),),
                                                ],
                                              ),
                                            ]
                                      )
                                    )
                                  ]
                                )
                              ),
                            ),
        
                            
                            for(foodData item in foodLst)
                              if(item.topPick ==1)
                                topPickItem(item)
                            
                            
                          
                          
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom:20.0, top: 30, left: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Menu", style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700),)
                          ),
                      ),



                      for (foodData food in _foundFood)
                        fooditem(x: food),
                      
                      
                    ],
                  ),
                ),
              
              
              
            ],
            
          ),
        ),
      ),
    );
  }

  Widget searchBox(){
    return Padding(
      padding: const EdgeInsets.only(left:20.0,right:20,top:20,bottom:20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          
        ),
        child: TextField(
          onChanged: (value) => _runFilter(value),
          controller: searchTxt,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: tdGrey,),
            hintText: "Search",
          ),
        ),
      ),
    );
  }


  void _runFilter(String enteredKeyword) {
    List<foodData> results = [];
    if (enteredKeyword.isEmpty) {
      results = foodLst;
    } else {
      results = foodLst
          .where((item) => item.name!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundFood = results;
    });
  }


  Widget topPickItem(foodData f){
    return Container(
            margin: EdgeInsets.only(right: 20),
            child: ClipRRect( 
            borderRadius: BorderRadius.circular(10.0),
            child: Stack(
              children: [
                Container(
                  width: 160,
                  height: 160,
                  child: FittedBox(
                  // margin: EdgeInsets.only(left: 25,right: 25,top: 20),
                  fit: BoxFit.fill,                            
                  child: Image.asset(f.imgPath),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    width: 160,
                    height: 80,
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
                              Text(f.name,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 22,color: Colors.white),),
                            ],
                          ),
                        ]
                  )
                )
              ]
            )
          ),
        );
  }

  
}
