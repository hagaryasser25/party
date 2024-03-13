import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:ndialog/ndialog.dart';
import 'package:party/Users/HomeUser.dart';
import 'package:party/Users/Registration.dart';
import 'package:party/admin/admin_home.dart';

class Login extends StatefulWidget {
  static const routeName = '/user_login';
  const Login({Key? key}) : super(key: key);

  IconData? get icon => Icons.lock;

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  bool obscureText = false;
  late TextEditingController Passcontroller;
  late TextEditingController emailcontroller;
  // ignore: deprecated_member_use
  late CountryCode selectedCountry = CountryCode.fromCode('EG');
  Color BackColor = Color.fromRGBO(21, 203, 149, 1);

  void initState() {
    super.initState();
    Passcontroller = TextEditingController();
    emailcontroller = TextEditingController();
    selectedCountry = CountryCode();
  }

  @override
  Widget build(BuildContext context) {
    // Replace 0xFF00FF00 with your desired hex color code

    EdgeInsetsGeometry padding = EdgeInsets.only(
      left: ScreenUtil().setWidth(131),
      right: ScreenUtil().setWidth(131),
      top: ScreenUtil().setHeight(224),
    );
    return MaterialApp(
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Container(
            child: ListView(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50),
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
                padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: emailcontroller,
                          decoration: InputDecoration(
                            labelText: "البريد الالكترونى",
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
                padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
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
                      var email = emailcontroller.text.trim();
                      var password = Passcontroller.text.trim();

                      if (email.isEmpty || password.isEmpty) {
                        MotionToast(
                                primaryColor: Colors.blue,
                                width: 300,
                                height: 50,
                                position: MotionToastPosition.center,
                                description: Text("please fill all fields"))
                            .show(context);

                        return;
                      }

                      ProgressDialog progressDialog = ProgressDialog(context,
                          title: Text('Logging In'),
                          message: Text('Please Wait'));
                      progressDialog.show();

                      try {
                        FirebaseAuth auth = FirebaseAuth.instance;
                        UserCredential userCredential =
                            await auth.signInWithEmailAndPassword(
                                email: email, password: password);

                        if (userCredential.user != null) {
                          progressDialog.dismiss();
                          Navigator.pushNamed(context, HomeUser.routeName);
                        }
                      } on FirebaseAuthException catch (e) {
                        progressDialog.dismiss();
                        if (e.code == 'user-not-found') {
                          MotionToast(
                                  primaryColor: Colors.blue,
                                  width: 300,
                                  height: 50,
                                  position: MotionToastPosition.center,
                                  description: Text("user not found"))
                              .show(context);

                          return;
                        } else if (e.code == 'wrong-password') {
                          MotionToast(
                                  primaryColor: Colors.blue,
                                  width: 300,
                                  height: 50,
                                  position: MotionToastPosition.center,
                                  description: Text("wrong email or password"))
                              .show(context);

                          return;
                        }
                      } catch (e) {
                        MotionToast(
                                primaryColor: Colors.blue,
                                width: 300,
                                height: 50,
                                position: MotionToastPosition.center,
                                description: Text("something went wrong"))
                            .show(context);

                        progressDialog.dismiss();
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
                          'تسجيل دخول',
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
                  Navigator.pushNamed(context, Registration.routeName);
                },
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    "قم بتسجيل حساب من هنا",
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
