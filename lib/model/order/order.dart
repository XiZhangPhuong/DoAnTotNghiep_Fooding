import 'dart:convert';

import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/product/products.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class OrderResponse {
  String? id;
  String? idCustomer;
  String? idEmployee;
  double? shipPrice;
  double? totalPrice;
  double? discount;
  String? typePayment;
  String? timePeding;
  String? timeDelivering;
  String? timeCancel;
  String? timeDone;
  String? timeConfirm;
  String? statusOrder;
  String? latLong;
  String? address;
  String? note;
  String? phone;
  List<Products>? listProduct;
  String? timeDelivery;
  String? idVoucher;
  String? name;
  OrderResponse({
    this.id,
    this.idCustomer,
    this.idEmployee,
    this.shipPrice,
    this.totalPrice,
    this.discount,
    this.typePayment,
    this.timePeding,
    this.statusOrder,
    this.latLong,
    this.address,
    this.note,
    this.phone,
    this.listProduct,
    this.timeDelivery,
    this.idVoucher,
    this.timeCancel,
    this.timeDelivering,
    this.timeDone,
    this.timeConfirm,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (!IZIValidate.nullOrEmpty(id)) 'id': id,
      if (!IZIValidate.nullOrEmpty(idCustomer)) 'idCustomer': idCustomer,
      if (!IZIValidate.nullOrEmpty(idEmployee)) 'idEmployee': idEmployee,
      if (!IZIValidate.nullOrEmpty(shipPrice)) 'shipPrice': shipPrice,
      if (!IZIValidate.nullOrEmpty(totalPrice)) 'totalPrice': totalPrice,
      if (!IZIValidate.nullOrEmpty(discount)) 'discount': discount,
      if (!IZIValidate.nullOrEmpty(typePayment)) 'typePayment': typePayment,
      if (!IZIValidate.nullOrEmpty(timePeding)) 'timePeding': timePeding,
      if (!IZIValidate.nullOrEmpty(statusOrder)) 'statusOrder': statusOrder,
      if (!IZIValidate.nullOrEmpty(latLong)) 'latLong': latLong,
      if (!IZIValidate.nullOrEmpty(address)) 'address': address,
      if (!IZIValidate.nullOrEmpty(note)) 'note': note,
      if (!IZIValidate.nullOrEmpty(phone)) 'phone': phone,
      if (!IZIValidate.nullOrEmpty(timeDelivery)) 'timeDelivery': timeDelivery,
      if (!IZIValidate.nullOrEmpty(idVoucher)) 'idVoucher': idVoucher,
      if (!IZIValidate.nullOrEmpty(name)) 'name': name,
      if (!IZIValidate.nullOrEmpty(listProduct))
        'listProduct': listProduct?.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderResponse.fromMap(Map<String, dynamic> map) {
    return OrderResponse(
      id: map['id'] != null ? map['id'] as String : null,
      idCustomer:
          map['idCustomer'] != null ? map['idCustomer'] as String : null,
      idEmployee:
          map['idEmployee'] != null ? map['idEmployee'] as String : null,
      shipPrice: map['shipPrice'] != null ? map['shipPrice'] as double : null,
      totalPrice:
          map['totalPrice'] != null ? map['totalPrice'] as double : null,
      discount: map['discount'] != null ? map['discount'] as double : null,
      typePayment:
          map['typePayment'] != null ? map['typePayment'] as String : null,
      timePeding:
          map['timePeding'] != null ? map['timePeding'] as String : null,
      timeDelivering:
          map['timeDelivering'] != null ? map['timeDelivering'] as String : null,
      timeCancel: map['timeCancel'] != null ? map['timeCancel'] as String : null,
      timeDone: map['timeDone'] != null ? map['timeDone'] as String : null,
      timeConfirm:
          map['timeConfirm'] != null ? map['timeConfirm'] as String : null,
      statusOrder:
          map['statusOrder'] != null ? map['statusOrder'] as String : null,
      latLong: map['latLong'] != null ? map['latLong'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      note: map['note'] != null ? map['note'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      listProduct: map['listProduct'] != null
          ? (map['listProduct'] as List<dynamic>)
              .map((e) => Products.fromMap(e as Map<String, dynamic>))
              .toList()
          : null,
      timeDelivery:
          map['timeDelivery'] != null ? map['timeDelivery'] as String : null,
      idVoucher: map['idVoucher'] != null ? map['idVoucher'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderResponse.fromJson(String source) =>
      OrderResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
