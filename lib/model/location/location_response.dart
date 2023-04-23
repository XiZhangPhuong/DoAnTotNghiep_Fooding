import 'dart:convert';

import 'package:fooding_project/helper/izi_validate.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LocationResponse {
  String? id;
  String? address;
  String? name;
  String? phone;
  String? latlong;
  LocationResponse({
    this.id,
    this.address,
    this.name,
    this.phone,
    this.latlong,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if(!IZIValidate.nullOrEmpty(id))'id': id,
      if(!IZIValidate.nullOrEmpty(address))'address': address,
      if(!IZIValidate.nullOrEmpty(name))'name': name,
      if(!IZIValidate.nullOrEmpty(phone))'phone': phone,
      if(!IZIValidate.nullOrEmpty(latlong))'latlong': latlong,
    };
  }

  factory LocationResponse.fromMap(Map<String, dynamic> map) {
    return LocationResponse(
      id: map['id'] != null ? map['id'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      latlong: map['latlong'] != null ? map['latlong'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationResponse.fromJson(String source) => LocationResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
