// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:fooding_project/helper/izi_validate.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Category {
   String? id_category;
   String? image_Category;
   String? name_Category;

   
  Category({
    this.id_category,
    this.image_Category,
    this.name_Category,
  });


   

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if(!IZIValidate.nullOrEmpty(id_category)) 'id_category': id_category,
      if(!IZIValidate.nullOrEmpty(image_Category)) 'image_Category': image_Category,
      if(!IZIValidate.nullOrEmpty(name_Category)) 'name_Category': name_Category,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id_category: map['id_category'] != null ? map['id_category'] as String : null,
      image_Category: map['image_Category'] != null ? map['image_Category'] as String : null,
      name_Category: map['name_Category'] != null ? map['name_Category'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) => Category.fromMap(json.decode(source) as Map<String, dynamic>);
}
