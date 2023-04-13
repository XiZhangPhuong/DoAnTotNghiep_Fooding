// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/category/category.dart';

class Products {
  String? id;
  String? name;
  List<String>? image;
  Category? category;
  String? description;
  double? price;
  String? idStore;

  Products({
    this.id,
    this.name,
    this.image,
    this.category,
    this.description,
    this.price,
    this.idStore,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (!IZIValidate.nullOrEmpty(id)) 'id': id,
      if (!IZIValidate.nullOrEmpty(name)) 'name': name,
      if (!IZIValidate.nullOrEmpty(image)) 'image': image,
      if (!IZIValidate.nullOrEmpty(category)) 'category': category?.toMap(),
      if (!IZIValidate.nullOrEmpty(description)) 'description': description,
      if (!IZIValidate.nullOrEmpty(price)) 'price': price,
      if (!IZIValidate.nullOrEmpty(idStore)) 'idStore': idStore,
    };
  }

  factory Products.fromMap(Map<String, dynamic> map) {
    return Products(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null
          ? List<String>.from((map['image'] as List<String>))
          : null,
      category: map['category'] != null
          ? Category.fromMap(map['category'] as Map<String, dynamic>)
          : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      price: map['price'] != null ? map['price'] as double : null,
      idStore: map['idStore'] != null ? map['idStore'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Products.fromJson(String source) =>
      Products.fromMap(json.decode(source) as Map<String, dynamic>);
}
