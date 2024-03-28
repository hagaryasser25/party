import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:party/admin/add_coordinator.dart';
import 'package:party/models/coordinator_model.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class AdminCoordinators extends StatefulWidget {
  static const routeName = '/adminCoordinators';
  AdminCoordinators({
    super.key,
  });

  @override
  State<AdminCoordinators> createState() => _AdminCoordinatorsState();
}

class _AdminCoordinatorsState extends State<AdminCoordinators> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Coordinator> list = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchCoordinator();
  }

  fetchCoordinator() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = await database.reference().child("coordinator");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Coordinator p = Coordinator.fromJson(event.snapshot.value);
      list.add(p);
      keyslist.add(event.snapshot.key.toString());
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => Scaffold(
            appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.white, //change your color here
                ),
                backgroundColor: Color.fromRGBO(21, 203, 149, 1),
                title: Center(
                    child: Text(
                  "المنسقين",
                  style: TextStyle(color: Colors.white),
                ))),
            floatingActionButton: Padding(
              padding: EdgeInsets.only(bottom: 40.h, left: 10.w),
              child: FloatingActionButton(
                backgroundColor: Color.fromRGBO(21, 203, 149, 1),
                onPressed: () {
                  Navigator.pushNamed(context, AddCoordinator.routeName);
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
            body: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Container(
                  child: StaggeredGridView.countBuilder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(
                        left: 15.w, right: 15.w, bottom: 15.h, top: 15.h),
                    crossAxisCount: 6,
                    itemCount: keyslist.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.w, left: 10.w),
                            child: Center(
                              child: Column(children: [
                                CircleAvatar(
                                  radius: 40,
                                  child: Image.network(
                                    '${list[index].imageUrl}',
                                  ),
                                ),
                                Text(
                                  '${list[index].name.toString()}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Marhey',
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  '${list[index].email.toString()}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Marhey',
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  '${list[index].password.toString()}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Marhey',
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  '${list[index].phoneNumber.toString()}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Marhey',
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  '${list[index].address.toString()}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Marhey',
                                      fontWeight: FontWeight.w600),
                                ),
                                InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  super.widget));
                                      base
                                          .child(list[index].uid.toString())
                                          .remove();
                                    },
                                    child: Icon(Icons.delete,
                                        color:
                                            Color.fromARGB(255, 122, 122, 122)))
                              ]),
                            ),
                          ),
                        ),
                      );
                    },
                    staggeredTileBuilder: (int index) =>
                        new StaggeredTile.count(3, index.isEven ? 3 : 3),
                    mainAxisSpacing: 40.0,
                    crossAxisSpacing: 5.0.w,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
