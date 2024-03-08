import 'dart:convert';
import 'dart:core';


class User{
  final int user_id;
  final String user_name;
  final String user_email;
  final String user_pw;
  final String user_num;
  final int user_flatnum;
  final String user_street;
  final String user_area;
  final String user_city;
  final int user_pincode;


  User({
    required this.user_id,
    required this.user_name,
    required this.user_email,
    required this.user_pw,
    required this.user_num,
    required this.user_flatnum,
    required this.user_street,
    required this.user_area,
    required this.user_city,
    required this.user_pincode
  });


  factory User.fromJson(Map<String,dynamic> json) => User(
    user_id :json["userid"] is int ? json["userid"] : int.tryParse(json["userid"]) ?? 0,
    user_name:json["username"],
    user_email:json["email"],
    user_pw:json["password"],
    user_num:json["phoneNum"],
    user_flatnum:json["flatNum"] is int ? json["flatNum"] : int.tryParse(json["flatNum"]) ?? 0,
    user_street:json["street"],
    user_area:json["area"],
    user_city:json["city"],
    user_pincode:json["pincode"] is int ? json["pincode"] : int.tryParse(json["pincode"]) ?? 0,  
  );


  Map<String, dynamic> toJson() {
    return {
      "userid": user_id,
      "username": user_name,
      "email": user_email,
      "password": user_pw,
      "phoneNum": user_num,
      "flatNum": user_flatnum,
      "street": user_street,
      "area": user_area,
      "city": user_city,
      "pincode": user_pincode,
    };
  }

  
}