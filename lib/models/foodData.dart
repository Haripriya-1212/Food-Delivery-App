import 'package:flutter/foundation.dart';
import 'package:fooddelivery_dbms/models/cartItemData.dart';

class foodData{
  final int id;
  final String name;
  final String imgPath;
  final String desc;
  final String price;
  final int topPick;


  foodData({
    required this.id,
    required this.name,
    required this.imgPath,
    required this.desc,
    required this.price,
    required this.topPick,
    
  });

  factory foodData.fromJson(Map<String, dynamic> json) {
    return foodData(
      id: json['id'],
      name: json['name'],
      imgPath: json['imgPath'],
      desc: json['desc'],
      price: json['price'].toString(), 
      topPick:json['topPick'] != null ? int.tryParse(json['topPick'].toString()) ?? 0 : 0,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imgPath': imgPath,
      'desc': desc,
      'price': price,
      'topPick': topPick,
    };
  }

  



  static List<foodData> foodList = [
    foodData(
      id: 1, 
      name: "Pancake", 
      imgPath: "assets/images/pancake.jpg", 
      desc: "Eggless soft and fluffy pancakes \nserved with a zesty lemon cream cheese", 
      price: "30.0",
      topPick: 0
    ),
    foodData(    
      id: 2, 
      name: "Boiled egg", 
      desc: "Perfectly cooked egg, \nseasoned to perfection", 
      price: "30.0",
      imgPath: "assets/images/boiled egg.jpg", 
      topPick: 0
    ),
    foodData(
      id: 3, 
      name: "Pizza", 
      desc: "Delicious pizza with a crispy \ncrust and flavorful toppings", 
      price: "100.0",
      imgPath: "assets/images/pizza.jpg", 
      topPick: 1
    ),
    foodData(
      id: 4, 
      name: "CheeseBurger", 
      desc: "Savory cheese goodness in a bun!", 
      price: "50.0",
      imgPath: "assets/images/cheeseburger.jpg", 
      topPick: 0
    ),
    foodData(
      id: 5, 
      name: "Caprese Salad", 
      desc: "Ripe tomatoes, mozzarella, basil, balsamic", 
      price: "30.0",
      imgPath: "assets/images/salad.jpg", 
      topPick: 0
    ),
    foodData(
      id: 5, 
      name: "Pasta", 
      desc: "Ripe tomatoes, mozzarella, basil, balsamic", 
      price: "120.0",
      imgPath: "assets/images/pasta3.jpg", 
      topPick: 1
    ),
    
  ];

}