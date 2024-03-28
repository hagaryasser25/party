import 'package:cherry_toast/cherry_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:party/admin/admin_home.dart';
import 'package:party/coordinator/coordinator_home.dart';
import 'package:party/models/co_model.dart';

class AddHalls extends StatefulWidget {
  static const routeName = '/addHalls';
  const AddHalls({Key? key}) : super(key: key);

  @override
  State<AddHalls> createState() => _AddHallsState();
}

class _AddHallsState extends State<AddHalls> {
  late TextEditingController namecontroller;
  late TextEditingController pricecontroller;
  late TextEditingController descriptioncontroller;
  late TextEditingController placecontroller;
  late TextEditingController phonecontroller;
  // ignore: deprecated_member_use

  Color BackColor = Color.fromRGBO(21, 203, 149, 1);

  void initState() {
    super.initState();
    namecontroller = TextEditingController();
    pricecontroller = TextEditingController();
    descriptioncontroller = TextEditingController();
    placecontroller = TextEditingController();
    phonecontroller = TextEditingController();
    getUserData();
  }

  String imageUrl = '';
  File? image;

  @override
  Future pickImageFromDevice() async {
    final xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFile == null) return;
    final tempImage = File(xFile.path);
    setState(() {
      image = tempImage;
      print(image!.path);
    });

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference refrenceImageToUpload = referenceDirImages.child(uniqueFileName);
    try {
      await refrenceImageToUpload.putFile(File(xFile.path));

      imageUrl = await refrenceImageToUpload.getDownloadURL();
    } catch (error) {}
    print(imageUrl);
  }

  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  late Co currentUser;

  void didChangeDependencies() {
    getUserData();
    super.didChangeDependencies();
  }


  getUserData() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database
        .reference()
        .child("coordinator")
        .child(FirebaseAuth.instance.currentUser!.uid);

    final snapshot = await base.get();
    setState(() {
      currentUser = Co.fromSnapshot(snapshot);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Container(
            child: ListView(children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 30),
                        child: CircleAvatar(
                          radius: 65,
                          backgroundColor: Color.fromARGB(255, 241, 240, 240),
                          backgroundImage:
                              image == null ? null : FileImage(image!),
                        )),
                    Positioned(
                        top: 120,
                        left: 120,
                        child: SizedBox(
                          width: 50,
                          child: RawMaterialButton(
                              // constraints: BoxConstraints.tight(const Size(45, 45)),
                              elevation: 10,
                              fillColor: BackColor,
                              child: const Align(
                                  // ignore: unnecessary_const
                                  child: Icon(Icons.add_a_photo,
                                      color: Colors.white, size: 22)),
                              padding: const EdgeInsets.all(15),
                              shape: const CircleBorder(),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Choose option',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: BackColor)),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    pickImageFromDevice();
                                                  },
                                                  splashColor:
                                                      HexColor('#F6B26B'),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Icon(Icons.image,
                                                            color: BackColor),
                                                      ),
                                                      Text('Gallery',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ))
                                                    ],
                                                  )),
                                              InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                  splashColor: BackColor,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Icon(
                                                            Icons.remove_circle,
                                                            color: BackColor),
                                                      ),
                                                      Text('Remove',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ))
                                                    ],
                                                  ))
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                child: Container(
                  width: 260,
                  child: TextFormField(
                    controller: namecontroller,
                    decoration: InputDecoration(
                      // Icon you want to add
                      border: OutlineInputBorder(),
                      labelText: "اسم القاعة",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                child: Container(
                  width: 260,
                  child: TextFormField(
                    controller: placecontroller,
                    decoration: InputDecoration(
                      // Icon you want to add
                      border: OutlineInputBorder(),
                      labelText: "مكان القاعة",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                child: Container(
                  width: 260,
                  child: TextFormField(
                    controller: phonecontroller,
                    decoration: InputDecoration(
                      // Icon you want to add
                      border: OutlineInputBorder(),
                      labelText: "رقم الهاتف",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: descriptioncontroller,
                          decoration: InputDecoration(
                            labelText: "تفاصيل القاعة",
                            // Icon you want to add

                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                child: Container(
                  width: 260,
                  child: TextFormField(
                    controller: pricecontroller,
                    maxLength: 5,
                    decoration: InputDecoration(
                      // Icon you want to add
                      border: OutlineInputBorder(),
                      labelText: "سعر القاعة",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      String name = namecontroller.text.trim();
                      String description = descriptioncontroller.text.trim();
                      String place = placecontroller.text.trim();
                      String price = pricecontroller.text.trim();
                      String phone = phonecontroller.text.trim();

                      if (name.isEmpty ||
                          price.isEmpty ||
                          place.isEmpty ||
                          imageUrl.isEmpty ||
                          description.isEmpty ||
                          phone.isEmpty) {
                        CherryToast.info(
                          title: Text('Please Fill all Fields'),
                          actionHandler: () {},
                        ).show(context);
                        return;
                      }

                      User? user = FirebaseAuth.instance.currentUser;

                      if (user != null) {
                        String uid = user.uid;
                        int date = DateTime.now().millisecondsSinceEpoch;

                        DatabaseReference companyRef = FirebaseDatabase.instance
                            .reference()
                            .child('halls')
                            .child('${currentUser.name}');

                        String? id = companyRef.push().key;

                        await companyRef.child(id!).set({
                          'imageUrl': imageUrl,
                          'id': id,
                          'name': name,
                          'price': price,
                          'place': place,
                          'description': description,
                          'phone': phone,
                          'coName': currentUser.name
                        });
                      }
                      showAlertDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BackColor, // Button background color.
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Add some spacing between the icon and text
                        Text(
                          "حفظ",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Icon(
                          Icons
                              .arrow_back_ios_new_outlined, // Icon to use (you can change it to any other icon)
                          size: 30.0, // Adjust the icon size as needed
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.0)
            ]),
          ),
        ),
      ),
    );
  }
}

class distance {
  static EdgeInsetsGeometry zero = EdgeInsets.zero;

  static EdgeInsetsGeometry only(
      {double top = 0, double right = 0, double bottom = 0, double left = 0}) {
    return EdgeInsets.only(left: left, right: right, top: top, bottom: bottom);
  }

  static wightwidth(double i) {
    return SizedBox(
      width: i,
    );
  }

  bool validatePhoneNumber(String phoneNumber) {
    // Define a regular expression pattern for Jordanian phone numbers
    // The pattern checks for +962 followed by 7 digits.
    final RegExp regex = RegExp(r'^\+962-7\d{7}$');
    return regex.hasMatch(phoneNumber);
  }
}

void showAlertDialog(BuildContext context) {
  Widget remindButton = TextButton(
    style: TextButton.styleFrom(
      primary: HexColor('#6bbcba'),
    ),
    child: Text("Ok"),
    onPressed: () {
      Navigator.pushNamed(context, CoordinatorHome.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text("تم أضافة القاعة"),
    actions: [
      remindButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
