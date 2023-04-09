// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:fooding_project/helper/izi_validate.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Category {
   String? id;
   String? thumnail;
   String? name;

   
  Category({
    this.id,
    this.thumnail,
    this.name,
  });


   

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if(!IZIValidate.nullOrEmpty(id)) 'id': id,
      if(!IZIValidate.nullOrEmpty(thumnail)) 'thumnail': thumnail,
      if(!IZIValidate.nullOrEmpty(name)) 'name': name,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] != null ? map['id'] as String : null,
      thumnail: map['thumnail'] != null ? map['thumnail'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) => Category.fromMap(json.decode(source) as Map<String, dynamic>);
}
