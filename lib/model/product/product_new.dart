import 'dart:convert';

import 'package:fooding_project/helper/izi_validate.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  String? id;
  String? idCategory;
  String? idStore;
  String? name;
  List<String>? images;
  String? price;
  String? description;
  List<String>? favorites;
  int quantity;
  String? priceDiscount;
  int? sold;
  Product({
    this.id,
    this.idCategory,
    this.idStore,
    this.name,
    this.images,
    this.price,
    this.description,
    this.favorites,
    this.quantity = 1,
    this.priceDiscount,
    this.sold,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (!IZIValidate.nullOrEmpty(id)) 'id': id,
      if (!IZIValidate.nullOrEmpty(idCategory)) 'idCategory': idCategory,
      if (!IZIValidate.nullOrEmpty(idStore)) 'idStore': idStore,
      if (!IZIValidate.nullOrEmpty(name)) 'name': name,
      if (!IZIValidate.nullOrEmpty(images)) 'images': images,
      if (!IZIValidate.nullOrEmpty(price)) 'price': price,
      if (!IZIValidate.nullOrEmpty(description)) 'description': description,
      if (!IZIValidate.nullOrEmpty(favorites)) 'favorites': favorites,
      if (!IZIValidate.nullOrEmpty(quantity)) 'quantity': quantity,
      if (!IZIValidate.nullOrEmpty(priceDiscount))
        'priceDiscount': priceDiscount,
      if (!IZIValidate.nullOrEmpty(sold)) 'sold': sold,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] != null ? map['id'] as String : null,
      idCategory:
          map['idCategory'] != null ? map['idCategory'] as String : null,
      idStore: map['idStore'] != null ? map['idStore'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      images: map['images'] != null
          ? (map['images'] as List<dynamic>).map((e) => e.toString()).toList()
          : null,
      price: map['price'] != null ? map['price'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      favorites: map['favorites'] != null
          ? (map['favorites'] as List<dynamic>)
              .map((e) => e.toString())
              .toList()
          : null,
      quantity: map['quantity'] as int,
      priceDiscount:
          map['priceDiscount'] != null ? map['priceDiscount'] as String : null,
      sold: map['sold'] != null ? map['sold'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
