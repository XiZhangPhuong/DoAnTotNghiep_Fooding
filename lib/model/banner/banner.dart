import 'dart:convert';

import 'package:fooding_project/helper/izi_validate.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Banners {
   String? id;
   String? image;
  Banners({
    this.id,
    this.image,
  });

   

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
     if(!IZIValidate.nullOrEmpty(id)) 'id': id,
     if(!IZIValidate.nullOrEmpty(image)) 'image': image,
    };
  }

  factory Banners.fromMap(Map<String, dynamic> map) {
    return Banners(
      id: map['id'] != null ? map['id'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Banners.fromJson(String source) => Banners.fromMap(json.decode(source) as Map<String, dynamic>);
}
