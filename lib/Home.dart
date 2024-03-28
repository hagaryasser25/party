import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:party/auth/Login.dart';
import 'package:party/auth/admin_login.dart';
import 'package:party/auth/coordinator_login.dart';

class Home extends StatefulWidget {
    static const routeName = '/home';
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Color BackColor = Color.fromRGBO(21, 203, 149, 1);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
            body: Column(
          children: [
            SizedBox(
              height: 50.h,
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.w, top: 50.w),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 120,
                      width: 120,
                    ),
                  )),
            ),
            SizedBox(
              height: 30.h,
            ),
            Center(
                child: Text('أهلا بك فى تطبيق بارتى بوينت',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
            SizedBox(
              height: 40.h,
            ),
            SizedBox(
              width: 170.w,
              child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: BackColor,
                      side: BorderSide(width: 3.0, color: BackColor)),
                  icon: const Icon(Icons.person),
                  label: const Text(
                    "المستخدم",
                    style: TextStyle(fontSize: 18),
                  )),
            ),
            SizedBox(height: 20.h,),
            SizedBox(
              width: 170.w,
              child: ElevatedButton.icon(
                  onPressed: () {
                      Navigator.pushNamed(context, AdminLogin.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: BackColor,
                      side: BorderSide(width: 3.0, color: BackColor)),
                  icon: const Icon(Icons.person),
                  label: const Text(
                    "مدير التطبيق",
                    style: TextStyle(fontSize: 18),
                  )),
                  
            ),
             SizedBox(height: 20.h,),
            SizedBox(
              width: 170.w,
              child: ElevatedButton.icon(
                  onPressed: () {
                      Navigator.pushNamed(context, CoordinatorLogin.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: BackColor,
                      side: BorderSide(width: 3.0, color: BackColor)),
                  icon: const Icon(Icons.person),
                  label: const Text(
                    "المنسق",
                    style: TextStyle(fontSize: 18),
                  )),
                  
            ),
            SizedBox(
              height: 15.h,
            ),
            Center(
                child: Padding(
              padding: EdgeInsets.only(
                right: 35.w,
                left: 35.w,
                top: 20.h
              ),
              child: Text(
                'تطبيق بوينت بارتى للحفلات يتطلب منك الاستعلام عن منسى الحفلات و التواصل مع احدهم و ارسال طلب لاحتياجك و التصميم المبدئى للمناسبة الخاصة بك ',
                style: TextStyle(color: Colors.grey),
              ),
            ))
          ],
        )),
      ),
    );
  }
}
