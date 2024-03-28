import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:party/Users/hall_details.dart';
import 'package:party/coordinator/add_halls.dart';
import 'package:party/models/halls_model.dart';

import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class UserHalls extends StatefulWidget {
  String coName;
  static const routeName = '/userHalls';
  UserHalls({required this.coName});

  @override
  State<UserHalls> createState() => _UserHallsState();
}

class _UserHallsState extends State<UserHalls> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Halls> hallsList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchHalls();
  }

  @override
  void fetchHalls() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("halls").child(widget.coName);
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Halls p = Halls.fromJson(event.snapshot.value);
      hallsList.add(p);
      keyslist.add(event.snapshot.key.toString());
      if (mounted) {
        setState(() {});
      }
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
                "القاعات",
                style: TextStyle(color: Colors.white),
              ))),
          body: ListView.builder(
              itemCount: hallsList.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(right: 15.w, left: 15.w, top: 15.h),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return HallDetails(
                              name: hallsList[index].name.toString(),
                              price: hallsList[index].price.toString(),
                              phone: hallsList[index].phoneNumber.toString(),
                              place: hallsList[index].place.toString(),
                              description: hallsList[index].description.toString(),
                              imageUrl: hallsList[index].imageUrl.toString(),
                              coName: widget.coName,
                            );
                          }));
                        },
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, right: 15, left: 15, bottom: 10),
                              child: Padding(
                                padding: EdgeInsets.only(right: 10.w),
                                child: Container(
                                  width: 130.w,
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 200.h,
                                          child: Image.network(
                                            '${hallsList[index].imageUrl.toString()}',
                                          )),
                                      Text(
                                        '${hallsList[index].name.toString()}',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
