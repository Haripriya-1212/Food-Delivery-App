import 'package:fooddelivery_dbms/models/foodData.dart';

class cartItemData{
  final int id;
  final String name;
  final String price;
   int qty;


  cartItemData({
    required this.id,
    required this.name,
    required this.price,
    required this.qty,
    
  });

  factory cartItemData.fromfoodData(foodData food){
    return cartItemData(
      id: food.id, 
      name: food.name, 
      price: food.price, 
      qty: 1
    );
  }

  factory cartItemData.fromJson(Map<String, dynamic> json) {
    return cartItemData(
      id: json['id'],
      name: json['name'],
      price: json['price'].toString(), 
      qty: 1
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'qty': 1
    };
  }
}