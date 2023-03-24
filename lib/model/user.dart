import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
   String? id;
   String? fullName;
   String? phoneNumber;
   String? passWord;
   
  User({
    this.id,
    this.fullName,
    this.phoneNumber,
    this.passWord,
  });

   

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'passWord': passWord,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as String : null,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      passWord: map['passWord'] != null ? map['passWord'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);
}
