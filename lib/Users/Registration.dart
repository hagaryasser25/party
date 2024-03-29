import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:ndialog/ndialog.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = '/signUpPage';
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 100.h),
                  child: Center(
                      child: Image.asset(
                    "assets/images/logo.png",
                    height: 150.h,
                    width: 150.w,
                  )),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.w, left: 10.w),
                  child: SizedBox(
                    height: 65.h,
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor('#2dda9f'), width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: "الأسم",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.w, left: 10.w),
                  child: SizedBox(
                    height: 65.h,
                    child: TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor('#2dda9f'), width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: "رقم الهاتف",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.w, left: 10.w),
                  child: SizedBox(
                    height: 65.h,
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor('#2dda9f'), width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'البريد الألكترونى',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.w, left: 10.w),
                  child: SizedBox(
                    height: 65.h,
                    child: TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor('#2dda9f'), width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'كلمة المرور',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
             
                Padding(
                  padding: EdgeInsets.only(right: 10.w, left: 10.w),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                        width: double.infinity, height: 65.h),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: HexColor('#2dda9f'),
                      ),
                      child: Text(
                        'انشاء حساب',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        var name = nameController.text.trim();
                        var phoneNumber = phoneController.text.trim();
                        var email = emailController.text.trim();
                        var password = passwordController.text.trim();

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
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

