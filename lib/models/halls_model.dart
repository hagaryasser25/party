import 'package:flutter/cupertino.dart';

class Halls {
  Halls({
    String? id,
    String? description,
    String? name,
    String? imageUrl,
    String? phoneNumber,
    String? place,
    String? price,
  }) {
    _id = id;
    _description = description;
    _name = name;
    _imageUrl = imageUrl;
    _phoneNumber = phoneNumber;
    _place = place;
    _price = price;
  }

  Halls.fromJson(dynamic json) {
    _id = json['id'];
    _description = json['description'];
    _name = json['name'];
    _imageUrl = json['imageUrl'];
    _phoneNumber = json['phone'];
    _place = json['place'];
    _price = json['price'];
  }

  String? _id;
  String? _description;
  String? _name;
  String? _imageUrl;
  String? _phoneNumber;
  String? _place;
  String? _price;

  String? get id => _id;
  String? get description => _description;
  String? get name => _name;
  String? get imageUrl => _imageUrl;
  String? get phoneNumber => _phoneNumber;
  String? get place => _place;
  String? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['description'] = _description;
    map['name'] = _name;
    map['imageUrl'] = _imageUrl;
    map['phone'] = _phoneNumber;
    map['place'] = _place;
    map['price'] = _price;

    return map;
  }
}