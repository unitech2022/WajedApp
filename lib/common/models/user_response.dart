import 'dart:convert';

import 'package:equatable/equatable.dart';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse extends Equatable{
  String? token;
  User? user;
  DateTime? expiration;
  bool? status;
  // Address? address;

   UserResponse({
    required this.token,
    required this.user,
    required this.expiration,
    required this.status,
    // required this.address,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        token: json["token"],
        user: User.fromJson(json["user"]),
        expiration: DateTime.parse(json["expiration"]),
        status: json["status"],
        // address: Address.fromJson(json["address"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user!.toJson(),
        "expiration": expiration.toString(),
        "status": status,
        // "address": address!.toJson(),
      };
      
        @override
      
        List<Object?> get props => [token,user,expiration,status];
}

class Address extends Equatable{
 final int id;
 final String userId;
 final String description;
 final String name;
 final double lat;
 final double lng;
 final bool defaultAddress;
 final DateTime createdAt;

  const Address({
    required this.id,
    required this.userId,
    required this.description,
    required this.name,
    required this.lat,
    required this.lng,
    required this.defaultAddress,
    required this.createdAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        userId: json["userId"],
        description: json["description"],
        name: json["name"],
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        defaultAddress: json["defaultAddress"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "description": description,
        "name": name,
        "lat": lat,
        "lng": lng,
        "defaultAddress": defaultAddress,
        "createdAt": createdAt.toIso8601String(),
      };
      
        @override
      
        List<Object?> get props => [id,userId,defaultAddress,description,lat,lng,createdAt];
}

class User extends Equatable{
final  String id;
final  String fullName;
final  String userName;
final  String email;
final  String profileImage;
 final String role;
final  String deviceToken;
final  String status;
final  String code;
final  String gender;
final  String city;
 final String birth;
 final String points;
final  String surveysBalance;
final  DateTime createdAt;

  const User({
    required this.id,
    required this.fullName,
    required this.userName,
    required this.email,
   required this.profileImage,
    required this.role,
    required this.deviceToken,
    required this.status,
    required this.code,
   required this.gender,
    required this.city,
   required this.birth,
    required this.points,
    required this.surveysBalance,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullName: json["fullName"],
        userName: json["userName"],
        email: json["email"],
        profileImage: json["profileImage"]?? "notFound",
        role: json["role"],
        deviceToken: json["deviceToken"],
        status: json["status"],
        code: json["code"],
        gender: json["gender"]?? "",
        city: json["city"],
        birth: json["birth"]?? "" ,
        points: json["points"],
        surveysBalance: json["surveysBalance"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "userName": userName,
        "email": email,
        "profileImage": profileImage,
        "role": role,
        "deviceToken": deviceToken,
        "status": status,
        "code": code,
        "gender": gender,
        "city": city,
        "birth": birth,
        "points": points,
        "surveysBalance": surveysBalance,
        "createdAt": createdAt.toIso8601String(),
      };
      
        @override
        // TODO: implement props
        List<Object?> get props => [
          id,fullName,userName,email,profileImage,role,deviceToken,status,
          code,gender,city,birth,points,surveysBalance,createdAt
        ];
}
