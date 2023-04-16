import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductOld {
  String? id_Food;
  String? image_Food;
  String? information_Food;
  String? name_Food;
  String? price_Food;
  int? quanlity;
  ProductOld({
    this.id_Food,
    this.image_Food,
    this.information_Food,
    this.name_Food,
    this.price_Food,
    this.quanlity,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id_Food': id_Food,
      'image_Food': image_Food,
      'information_Food': information_Food,
      'name_Food': name_Food,
      'price_Food': price_Food,
      'quanlity': quanlity,
    };
  }

  factory ProductOld.fromMap(Map<String, dynamic> map) {
    return ProductOld(
      id_Food: map['id_Food'] != null ? map['id_Food'] as String : null,
      image_Food: map['image_Food'] != null ? map['image_Food'] as String : null,
      information_Food: map['information_Food'] != null ? map['information_Food'] as String : null,
      name_Food: map['name_Food'] != null ? map['name_Food'] as String : null,
      price_Food: map['price_Food'] != null ? map['price_Food'] as String : null,
      quanlity: map['quanlity'] != null ? map['quanlity'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductOld.fromJson(String source) => ProductOld.fromMap(json.decode(source) as Map<String, dynamic>);
}
