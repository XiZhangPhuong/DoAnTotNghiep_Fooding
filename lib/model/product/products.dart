// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fooding_project/helper/izi_validate.dart';

class Products {
  String? id;
  String? idUser;
  String? name;
  List<dynamic>? image;
  String? idCategory;
  String? description;
  int? price;
  int? sold;
  
  Products({
    this.id,
    this.idUser,
    this.name,
    this.image,
    this.idCategory,
    this.description,
    this.price,
    this.sold
  });

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (!IZIValidate.nullOrEmpty(id)) 'id': id,
      if (!IZIValidate.nullOrEmpty(idUser)) 'idUser': idUser,
      if (!IZIValidate.nullOrEmpty(name)) 'name': name,
      if (!IZIValidate.nullOrEmpty(image)) 'image': image,
      if (!IZIValidate.nullOrEmpty(idCategory)) 'idCategory': idCategory,
      if (!IZIValidate.nullOrEmpty(description)) 'description': description,
      if (!IZIValidate.nullOrEmpty(price)) 'price': price,
      if (!IZIValidate.nullOrEmpty(sold)) 'price': sold,
    };
  }

  factory Products.fromMap(Map<String, dynamic> map) {
    return Products(
      id: map['id'] != null ? map['id'] as String : null,
      idUser: map['idUser'] != null ? map['idUser'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null
          ? List<dynamic>.from((map['image'] as List<dynamic>))
          : null,
      idCategory: map['idCategory'] != null ? map['idCategory'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      price: map['price'] != null ? map['price'] as int : null,
      sold: map['sold'] != null ? map['sold'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Products.fromJson(String source) =>
      Products.fromMap(json.decode(source) as Map<String, dynamic>);
}
