import 'package:firebase_database/firebase_database.dart';

class Co {
  String? email;
  String? uid;
  String? phoneNumber;
  String? name;
  String? address;
  String? password;

  Co({this.email, this.uid, this.phoneNumber, this.name, this.address, this.password});

  Co.fromSnapshot(DataSnapshot dataSnapshot) {
    uid = (dataSnapshot.child("uid").value.toString());
    email = (dataSnapshot.child("email").value.toString());
    name = (dataSnapshot.child("name").value.toString());
    phoneNumber = (dataSnapshot.child("phoneNumber").value.toString());
    address = (dataSnapshot.child("address").value.toString());
    password = (dataSnapshot.child("password").value.toString());
  }
}