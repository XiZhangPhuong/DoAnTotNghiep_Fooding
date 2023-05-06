// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

import 'package:fooding_project/helper/izi_validate.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Category {
   String? id;
   String? thumnail;
   String? name;
   bool? isDeleted;
   
  Category({
    this.id,
    this.thumnail,
    this.name,
    this.isDeleted,
  });


   

 

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
     if(!IZIValidate.nullOrEmpty(id)) 'id': id,
    if(!IZIValidate.nullOrEmpty(thumnail))  'thumnail': thumnail,
     if(!IZIValidate.nullOrEmpty(name)) 'name': name,
     if(!IZIValidate.nullOrEmpty(isDeleted)) 'isDeleted': isDeleted,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] != null ? map['id'] as String : null,
      thumnail: map['thumnail'] != null ? map['thumnail'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      isDeleted: map['isDeleted'] != null ? map['isDeleted'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) => Category.fromMap(json.decode(source) as Map<String, dynamic>);
}
