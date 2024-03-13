import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:party/Home.dart';
import 'package:party/admin/admin_halls.dart';
import 'package:party/admin/admin_list.dart';

class AdminHome extends StatefulWidget {
  static const routeName = '/adminHome';
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    Color BackColor = Color.fromRGBO(21, 203, 149, 1);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.white, //change your color here
              ),
              backgroundColor: BackColor,
              title: Center(
                  child: Text(
                'الصفحة الرئيسية',
                style: TextStyle(color: Colors.white),
              )),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  tooltip: 'Open shopping cart',
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('تأكيد'),
                            content: Text('هل انت متأكد من تسجيل الخروج'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  FirebaseAuth.instance.signOut();
                                  Navigator.pushNamed(context, Home.routeName);
                                },
                                child: Text('نعم'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('لا'),
                              ),
                            ],
                          );
                        });
                  },
                ),
              ],
            ),
            body: Column(
              children: [
                Center(
                    child:
                        Image.asset("assets/images/banner.jpg", height: 320.h)),
                Text(
                  "الخدمات",
                  style: TextStyle(
                    fontSize: 26,
                    fontFamily: 'Lemonada',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, AdminHalls.routeName);
                          },
                          child: card("أضافة قاعة", Icons.add)),
                      SizedBox(
                        width: 15.w,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, AdminList.routeName);
                          },
                          child: card("الحجوزات", Icons.list)),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

Widget card(String text, IconData icon) {
  return Container(
    color: HexColor('#ffffff'),
    child: Card(
      elevation: 0.5,
      color: HexColor('#ffffff'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        width: 130.w,
        height: 160.h,
        child: Column(children: [
          SizedBox(
            height: 20.h,
          ),
          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(166, 229, 210, 1),
            ),
            child: Icon(
              icon,
              color: Color.fromRGBO(21, 203, 149, 1),
            ),
            alignment: Alignment.center,
          ),
          SizedBox(height: 5),
          Text(text,
              style: TextStyle(
                fontSize: 16,
              ))
        ]),
      ),
    ),
  );
}
