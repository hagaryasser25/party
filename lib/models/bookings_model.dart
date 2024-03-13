
class Bookings {
  Bookings({
    String? id,
    String? date,
    String? name,
    String? hallName,
    String? phoneNumber,
  }) {
    _id = id;
    _date = date;
    _name = name;
    _hallName = hallName;
    _phoneNumber = phoneNumber;

  }

  Bookings.fromJson(dynamic json) {
    _id = json['id'];
    _date = json['date'];
    _name = json['name'];
    _hallName = json['hallName'];
    _phoneNumber = json['phoneNumber'];
  }

  String? _id;
  String? _date;
  String? _name;
  String? _hallName;
  String? _phoneNumber;

  String? get id => _id;
  String? get date => _date;
  String? get name => _name;
  String? get hallName => _hallName;
  String? get phoneNumber => _phoneNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date'] = _date;
    map['name'] = _name;
    map['hallName'] = _hallName;
    map['phoneNumber'] = _phoneNumber;

    return map;
  }
}