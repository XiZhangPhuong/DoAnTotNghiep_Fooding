import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  String? id;
  String? fullName;
  String? phone;
  String? passWord;
  String? avatar;
  String? typeUser;
  bool? isDeleted;
  User({
    this.id,
    this.fullName,
    this.phone,
    this.passWord,
    this.avatar,
    this.typeUser,
    this.isDeleted,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'phone': phone,
      'passWord': passWord,
      'avatar': avatar,
      'typeUser': typeUser,
      'isDeleted': isDeleted,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as String : null,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      passWord: map['passWord'] != null ? map['passWord'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      typeUser: map['typeUser'] != null ? map['typeUser'] as String : null,
      isDeleted: map['isDeleted'] != null ? map['isDeleted'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
