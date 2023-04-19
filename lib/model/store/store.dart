// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/user.dart';

class Store extends User {
  String? openHour;
  String? closeHour;
  bool? isOline;

  Store({
    String? id,
    String? fullName,
    String? phone,
    String? email,
    String? passWord,
    String? avatar,
    String? typeUser,
    bool? isDeleted,
    String? address,
    String? banner,
    String? dateOfBirth,
    String? gender,
    // openHour default = 8:00
    this.openHour = '8:00',
    // closeHour default = 22:00
    this.closeHour = '10:30',
    this.isOline,
  }) : super(
            id: id,
            fullName: fullName,
            email: email,
            passWord: passWord,
            avatar: avatar,
            typeUser: typeUser,
            isDeleted: isDeleted,
            address: address,
            dateOfBirth: dateOfBirth,
            gender: gender);

  @override
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
      if (!IZIValidate.nullOrEmpty(openHour)) 'openHour': openHour,
      if (!IZIValidate.nullOrEmpty(closeHour)) 'closeHour': closeHour,
      if (!IZIValidate.nullOrEmpty(isOline)) 'isOline': isOline,
    };
  }

  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(
      id: map['id'] != null ? map['id'] as String : null,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      passWord: map['passWord'] != null ? map['passWord'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : 'https://scontent.fhan2-5.fna.fbcdn.net/v/t1.15752-9/342070550_923272142250296_1881831047475036228_n.png?_nc_cat=104&ccb=1-7&_nc_sid=ae9488&_nc_ohc=t2GycJz-I4cAX8Cxmx3&_nc_ht=scontent.fhan2-5.fna&oh=03_AdRG_tSsBdfsfSl1BEGps-rG7XVTwRXEaMzvB6tNb5Y8PA&oe=646789F0',
      typeUser: map['typeUser'] != null ? map['typeUser'] as String : null,
      isDeleted: map['isDeleted'] != null ? map['isDeleted'] as bool : null,
      address: map['address'] != null ? map['address'] as String : '120 Lý Thái Tông',
      banner: map['banner'] != null ? map['banner'] as String : null,
      dateOfBirth:
          map['dateOfBirth'] != null ? map['dateOfBirth'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      openHour: map['openHour'] != null ? map['openHour'] as String : '8:30',
      closeHour: map['closeHour'] != null ? map['closeHour'] as String : '10:30',
      isOline: map['isOline'] != null ? map['isOline'] as bool : true,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory Store.fromJson(String source) =>
      Store.fromMap(json.decode(source) as Map<String, dynamic>);
}
