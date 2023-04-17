// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/product/products.dart';

class CartRquest {
   String? idUser;
   List<Products>? listProduct;
  CartRquest({
    this.idUser,
    this.listProduct,
  });
  

   

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
     if(!IZIValidate.nullOrEmpty(idUser))  'idUser': idUser,
     if(!IZIValidate.nullOrEmpty(listProduct)) 'listProduct': listProduct?.map((x) => x.toMap()).toList(),
    };
  }

  factory CartRquest.fromMap(Map<String, dynamic> map) {
    return CartRquest(
      idUser: map['idUser'] != null ? map['idUser'] as String : null,
      listProduct: map['listProduct'] != null ? List<Products>.from((map['listProduct'] as List<dynamic>).map<Products?>((x) => Products.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartRquest.fromJson(String source) => CartRquest.fromMap(json.decode(source) as Map<String, dynamic>);
}
