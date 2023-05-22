import 'dart:convert';

import 'package:fooding_project/helper/izi_validate.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CommentRequets {
  String? id;
  String? idUser;
  String? idStore;
  String? idOrder;
  String? idShipper;
  String? idProduct;
  double? rating;
  String? satisFied;
  String? content;
  List<String>? listImage;
  String? timeComment;
  String? typeUser;
  CommentRequets({
    this.id,
    this.idUser,
    this.idStore,
    this.idOrder,
    this.idShipper,
    this.idProduct,
    this.rating,
    this.satisFied,
    this.content,
    this.listImage,
    this.timeComment,
    this.typeUser,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (!IZIValidate.nullOrEmpty(idUser)) 'id': id,
      if (!IZIValidate.nullOrEmpty(idUser)) 'idUser': idUser,
      if (!IZIValidate.nullOrEmpty(idStore)) 'idStore': idStore,
      if (!IZIValidate.nullOrEmpty(idOrder)) 'idOrder': idOrder,
      if (!IZIValidate.nullOrEmpty(idShipper)) 'idShipper': idShipper,
      if (!IZIValidate.nullOrEmpty(idProduct)) 'idProduct': idProduct,
      if (!IZIValidate.nullOrEmpty(rating)) 'rating': rating,
      if (!IZIValidate.nullOrEmpty(satisFied)) 'satisFied': satisFied,
      if (!IZIValidate.nullOrEmpty(content)) 'content': content,
      if (!IZIValidate.nullOrEmpty(listImage)) 'listImage': listImage,
      if (!IZIValidate.nullOrEmpty(timeComment)) 'timeComment': timeComment,
      if (!IZIValidate.nullOrEmpty(typeUser)) 'typeUser': typeUser,
    };
  }

  factory CommentRequets.fromMap(Map<String, dynamic> map) {
    return CommentRequets(
        id: map['id'] != null ? map['id'] as String : null,
        idUser: map['idUser'] != null ? map['idUser'] as String : null,
        idStore: map['idStore'] != null ? map['idStore'] as String : null,
        idOrder: map['idOrder'] != null ? map['idOrder'] as String : null,
        idShipper: map['idShipper'] != null ? map['idShipper'] as String : null,
        idProduct: map['idProduct'] != null ? map['idProduct'] as String : null,
        rating: map['rating'] != null ? map['rating'] as double : null,
        satisFied: map['satisFied'] != null ? map['satisFied'] as String : null,
        content: map['content'] != null ? map['content'] as String : null,
        listImage: map['listImage'] != null
            ? List<String>.from((map['listImage'] as List<dynamic>))
            : null,
        timeComment:
            map['timeComment'] != null ? map['timeComment'] as String : null,
        typeUser: map['typeUser'] != null ? map['typeUser'] as String : null);
  }

  String toJson() => json.encode(toMap());

  factory CommentRequets.fromJson(String source) =>
      CommentRequets.fromMap(json.decode(source) as Map<String, dynamic>);
}
