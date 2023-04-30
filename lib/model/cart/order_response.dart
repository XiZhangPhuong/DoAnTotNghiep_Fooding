// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/product/product_new.dart';

class OrderResponse {
  String? id;
  String? idCustomer;
  List<Product>? idProduct;
  String? shipPrice;
  String? totalPrice;
  String? typePayment;
  String? timeOrder;
  String? statusOrder;
  String? latLong;
  String? address;
  OrderResponse({
    this.id,
    this.idCustomer,
    this.idProduct,
    this.shipPrice,
    this.totalPrice,
    this.typePayment,
    this.timeOrder,
    this.statusOrder,
    this.latLong,
    this.address,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (!IZIValidate.nullOrEmpty(id)) 'id': id,
      if (!IZIValidate.nullOrEmpty(idCustomer)) 'idCustomer': idCustomer,
      if (!IZIValidate.nullOrEmpty(idProduct))
        'idProduct': idProduct!.map((e) => e.toMap()).toList(),
      if (!IZIValidate.nullOrEmpty(shipPrice)) 'shipPrice': shipPrice,
      if (!IZIValidate.nullOrEmpty(totalPrice)) 'totalPrice': totalPrice,
      if (!IZIValidate.nullOrEmpty(typePayment)) 'typePayment': typePayment,
      if (!IZIValidate.nullOrEmpty(timeOrder)) 'timeOrder': timeOrder,
      if (!IZIValidate.nullOrEmpty(statusOrder)) 'statusOrder': statusOrder,
      if (!IZIValidate.nullOrEmpty(latLong)) 'latLong': latLong,
      if (!IZIValidate.nullOrEmpty(address)) 'latLong': address,
    };
  }

  factory OrderResponse.fromMap(Map<String, dynamic> map) {
    return OrderResponse(
      id: map['id'] != null ? map['id'] as String : null,
      idCustomer:
          map['idCustomer'] != null ? map['idCustomer'] as String : null,
      idProduct: map['idProduct'] != null
          ? (map['idProduct'] as List<dynamic>)
              .map((e) => Product.fromMap(e as Map<String, dynamic>))
              .toList()
          : null,
      shipPrice: map['shipPrice'] != null ? map['shipPrice'] as String : null,
      totalPrice:
          map['totalPrice'] != null ? map['totalPrice'] as String : null,
      typePayment:
          map['typePayment'] != null ? map['typePayment'] as String : null,
      timeOrder: map['timeOrder'] != null ? map['timeOrder'] as String : null,
      statusOrder:
          map['statusOrder'] != null ? map['statusOrder'] as String : null,
      latLong: map['latLong'] != null ? map['latLong'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderResponse.fromJson(String source) =>
      OrderResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
