// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fooding_project/model/product/products.dart';

class Favorite {
  String? idUser;
  List<Products>? listProduct;
  Favorite({this.idUser, this.listProduct});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idUser': idUser,
      'listProduct': listProduct!.map((x) => x.toMap()).toList(),
    };
  }

  factory Favorite.fromMap(Map<String, dynamic> map) {
    return Favorite(
      idUser: map['idUser'] != null ? map['idUser'] as String : null,
      listProduct: map['listProduct'] != null ? List<Products>.from((map['listProduct'] as List<int>).map<Products?>((x) => Products.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Favorite.fromJson(String source) => Favorite.fromMap(json.decode(source) as Map<String, dynamic>);
}
