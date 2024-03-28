import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:party/Home.dart';
import 'package:party/admin/admin_coordinators.dart';
import 'package:party/coordinator/coordinator_halls.dart';
import 'package:party/coordinator/coordinator_list.dart';
import 'package:party/coordinator/add_halls.dart';
import 'package:party/models/co_model.dart';

class CoordinatorHome extends StatefulWidget {
  static const routeName = '/coordinatorHome';
  const CoordinatorHome({super.key});

  @override
  State<CoordinatorHome> createState() => _CoordinatorHomeState();
}

class _CoordinatorHomeState extends State<CoordinatorHome> {
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
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CoordinatorHalls(
                                name: '${currentUser.name}',
                              );
                            }));
                          },
                          child: card("اضافة قاعة", Icons.add)),
                      SizedBox(
                        width: 15.w,
                      ),
                      InkWell(
                          onTap: () {
                             Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CoordinatorList(
                                name: '${currentUser.name}',
                              );
                            }));
                          }, child: card("الحجوزات", Icons.list)),
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
