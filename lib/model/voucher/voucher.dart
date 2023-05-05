import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Voucher {
  String? id;
  String? name;
  String? code;
  DateTime? endDate;
  int? discountMoney;
  int? minOrderPrice;
  int? limitMax;
  List<String>? listCustomer;
  bool? isShow;
  String? image;
  bool? isDeleted;
  String? description;
  Voucher({
    this.id,
    this.name,
    this.code,
    this.endDate,
    this.discountMoney,
    this.minOrderPrice,
    this.limitMax,
    this.listCustomer,
    this.isShow,
    this.image,
    this.isDeleted,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'code': code,
      'endDate': endDate?.millisecondsSinceEpoch,
      'discountMoney': discountMoney,
      'minOrderPrice': minOrderPrice,
      'limitMax': limitMax,
      'listCustomer': listCustomer,
      'isShow': isShow,
      'image': image,
      'isDeleted': isDeleted,
    };
  }

  factory Voucher.fromMap(Map<String, dynamic> map) {
    return Voucher(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      endDate: map['endDate'] != null
          ? DateTime.parse(map['endDate'] as String)
          : null,
      discountMoney:
          map['discountMoney'] != null ? map['discountMoney'] as int : null,
      minOrderPrice:
          map['minOrderPrice'] != null ? map['minOrderPrice'] as int : null,
      limitMax: map['limitMax'] != null ? map['limitMax'] as int : null,
      listCustomer: map['listCustomer'] != null
          ? (map['listCustomer'] as List<dynamic>)
              .map((e) => e.toString())
              .toList()
          : null,
      isShow: map['isShow'] != null ? map['isShow'] as bool : null,
      image: map['image'] != null ? map['image'] as String : null,
      isDeleted: map['isDeleted'] != null ? map['isDeleted'] as bool : null,
      description: map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Voucher.fromJson(String source) =>
      Voucher.fromMap(json.decode(source) as Map<String, dynamic>);
}
