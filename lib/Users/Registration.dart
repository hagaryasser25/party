import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:ndialog/ndialog.dart';
import 'package:party/auth/Login.dart';

import 'HomeUser.dart';

class Registration extends StatefulWidget {
  static const routeName = '/resgistration';
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
  IconData? get icon => Icons.lock;
}

class _RegistrationState extends State<Registration> {
  bool obscureText = false;
  late TextEditingController namecontroller;
  late TextEditingController Emailcontroller;

  late TextEditingController Passcontroller;
  late TextEditingController Phonecontroller;
  // ignore: deprecated_member_use

  Color BackColor = Color.fromRGBO(21, 203, 149, 1);

  void initState() {
    super.initState();
    Passcontroller = TextEditingController();
    Phonecontroller = TextEditingController();
    namecontroller = TextEditingController();
    Emailcontroller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => Scaffold(
            body: Container(
              child: ListView(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 30.h),
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 150.0,
                      height: 150.0,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "مرحبا بك",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                  child: Container(
                    width: 260,
                    child: TextFormField(
                      controller: namecontroller!,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person), // Icon you want to add
                        border: OutlineInputBorder(),
                        labelText: "أسم المستخدم",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 20.w),
                  child: Container(
                    width: 260,
                    child: TextFormField(
                      controller: Emailcontroller!,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email), // Icon you want to add
                        border: OutlineInputBorder(),
                        labelText: "ايميل المستخدم",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.w, top: 30.w, right: 20.w),
                  child: Container(
                    child: Row(
                      children: [
                        distance.wightwidth(10),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            controller: Phonecontroller,
                            decoration: InputDecoration(
                              labelText: 'رقم هاتف المحمول',
                              prefixIcon:
                                  Icon(Icons.phone), // Icon you want to add

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
                      controller: Passcontroller,
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        prefixIcon: Icon(widget.icon), // Icon you want to add
                        border: OutlineInputBorder(),
                        labelText: "كلمة المرور",

                        suffixIcon: IconButton(
                          icon: Icon(obscureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                        ),
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
                        var name = namecontroller.text.trim();
                        var phoneNumber = Phonecontroller.text.trim();
                        var email = Emailcontroller.text.trim();
                        var password = Passcontroller.text.trim();

                        if (name.isEmpty ||
                            email.isEmpty ||
                            password.isEmpty ||
                            phoneNumber.isEmpty) {
                          MotionToast(
                                  primaryColor: Colors.blue,
                                  width: 300,
                                  height: 50,
                                  position: MotionToastPosition.center,
                                  description: Text("please fill all fields"))
                              .show(context);

                          return;
                        }

                        if (password.length < 6) {
                          // show error toast
                          MotionToast(
                                  primaryColor: Colors.blue,
                                  width: 300,
                                  height: 50,
                                  position: MotionToastPosition.center,
                                  description: Text(
                                      "Weak Password, at least 6 characters are required"))
                              .show(context);

                          return;
                        }

                        ProgressDialog progressDialog = ProgressDialog(context,
                            title: Text('Signing Up'),
                            message: Text('Please Wait'));
                        progressDialog.show();

                        try {
                          FirebaseAuth auth = FirebaseAuth.instance;

                          UserCredential userCredential =
                              await auth.createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          User? user = userCredential.user;

                          if (userCredential.user != null) {
                            DatabaseReference userRef = FirebaseDatabase
                                .instance
                                .reference()
                                .child('users');

                            String uid = userCredential.user!.uid;
                            int dt = DateTime.now().millisecondsSinceEpoch;

                            await userRef.child(uid).set({
                              'name': name,
                              'email': email,
                              'password': password,
                              'uid': uid,
                              'dt': dt,
                              'phoneNumber': phoneNumber,
                            });

                            Navigator.canPop(context)
                                ? Navigator.pop(context)
                                : null;
                          } else {
                            MotionToast(
                                    primaryColor: Colors.blue,
                                    width: 300,
                                    height: 50,
                                    position: MotionToastPosition.center,
                                    description: Text("failed"))
                                .show(context);
                          }
                          progressDialog.dismiss();
                        } on FirebaseAuthException catch (e) {
                          progressDialog.dismiss();
                          if (e.code == 'email-already-in-use') {
                            MotionToast(
                                    primaryColor: Colors.blue,
                                    width: 300,
                                    height: 50,
                                    position: MotionToastPosition.center,
                                    description: Text("email is already exist"))
                                .show(context);
                          } else if (e.code == 'weak-password') {
                            MotionToast(
                                    primaryColor: Colors.blue,
                                    width: 300,
                                    height: 50,
                                    position: MotionToastPosition.center,
                                    description: Text("password is weak"))
                                .show(context);
                          }
                        } catch (e) {
                          progressDialog.dismiss();
                          MotionToast(
                                  primaryColor: Colors.blue,
                                  width: 300,
                                  height: 50,
                                  position: MotionToastPosition.center,
                                  description: Text("something went wrong"))
                              .show(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BackColor, // Button background color.
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Add some spacing between the icon and text
                          Text(
                            'تسجيل حساب',
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
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      textAlign: TextAlign.center,
                      "عودة",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
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
