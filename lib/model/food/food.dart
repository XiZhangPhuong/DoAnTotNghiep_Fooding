import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Food {
  String? id_Food;
  String? name_Food;
  String? category_Food;
  String? image_Food;
  String? information_Food;
  int? quantity;
  double? price_Food;
  Food({
    this.id_Food,
    this.name_Food,
    this.category_Food,
    this.image_Food,
    this.information_Food,
    this.quantity,
    this.price_Food,
  });

  


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id_Food': id_Food,
      'name_Food': name_Food,
      'category_Food': category_Food,
      'image_Food': image_Food,
      'information_Food': information_Food,
      'quantity': quantity,
      'price_Food': price_Food,
    };
  }

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      id_Food: map['id_Food'] != null ? map['id_Food'] as String : null,
      name_Food: map['name_Food'] != null ? map['name_Food'] as String : null,
      category_Food: map['category_Food'] != null ? map['category_Food'] as String : null,
      image_Food: map['image_Food'] != null ? map['image_Food'] as String : null,
      information_Food: map['information_Food'] != null ? map['information_Food'] as String : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      price_Food: map['price_Food'] != null ? map['price_Food'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Food.fromJson(String source) => Food.fromMap(json.decode(source) as Map<String, dynamic>);
}
