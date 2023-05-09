import 'dart:convert';

import 'package:fooding_project/helper/izi_validate.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  String? id;
  String? fullName;
  String? phone;
  String? email;
  String? passWord;
  String? avatar;
  String? typeUser;
  bool? isDeleted;
  String? address;
  String? banner;
  String? gender;
  String? dateOfBirth;
  String? latLong;
  String? idLocation;
  String? idVehicle;
  bool? isOline;
  User(
      {this.id,
      this.fullName,
      this.phone,
      this.email,
      this.passWord,
      this.avatar,
      this.typeUser,
      this.isDeleted,
      this.address,
      this.banner,
      this.dateOfBirth,
      this.gender,
      this.latLong,
      this.idLocation,
      this.idVehicle,
      this.isOline});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (!IZIValidate.nullOrEmpty(id)) 'id': id,
      if (!IZIValidate.nullOrEmpty(fullName)) 'fullName': fullName,
      if (!IZIValidate.nullOrEmpty(phone)) 'phone': phone,
      if (!IZIValidate.nullOrEmpty(email)) 'email': email,
      if (!IZIValidate.nullOrEmpty(passWord)) 'passWord': passWord,
      if (!IZIValidate.nullOrEmpty(avatar)) 'avatar': avatar,
      if (!IZIValidate.nullOrEmpty(typeUser)) 'typeUser': typeUser,
      if (!IZIValidate.nullOrEmpty(isDeleted)) 'isDeleted': isDeleted,
      if (!IZIValidate.nullOrEmpty(address)) 'address': address,
      if (!IZIValidate.nullOrEmpty(banner)) 'banner': banner,
      if (!IZIValidate.nullOrEmpty(dateOfBirth)) 'dateOfBirth': dateOfBirth,
      if (!IZIValidate.nullOrEmpty(gender)) 'gender': gender,
      if (!IZIValidate.nullOrEmpty(latLong)) 'latLong': latLong,
      if (!IZIValidate.nullOrEmpty(idLocation)) 'idLocation': idLocation,
      if (!IZIValidate.nullOrEmpty(isOline)) 'isOline': isOline,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as String : null,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      passWord: map['passWord'] != null ? map['passWord'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      typeUser: map['typeUser'] != null ? map['typeUser'] as String : null,
      isDeleted: map['isDeleted'] != null ? map['isDeleted'] as bool : null,
      address: map['address'] != null ? map['address'] as String : null,
      banner: map['banner'] != null ? map['banner'] as String : null,
      dateOfBirth:
          map['dateOfBirth'] != null ? map['dateOfBirth'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      latLong: map['latLong'] != null ? map['latLong'] as String : null,
      idLocation:
          map['idLocation'] != null ? map['idLocation'] as String : null,
      idVehicle: map['idVehicle'] != null ? map['idVehicle'] as String : null,
      isOline: map['isOline'] != null ? map['isOline'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
