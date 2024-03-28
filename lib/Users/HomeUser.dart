import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:party/Home.dart';
import 'package:party/Users/hall_details.dart';
import 'package:party/Users/prevoiusWork.dart';
import 'package:party/Users/user_halls.dart';
import 'package:party/models/coordinator_model.dart';
import 'package:party/models/halls_model.dart';
import 'package:party/models/users_model.dart';

class HomeUser extends StatefulWidget {
  static const routeName = '/user_home';
  const HomeUser({Key? key}) : super(key: key);

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Coordinator> list = [];
  List<String> keyslist = [];
  late Users currentUser;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database
        .reference()
        .child("users")
        .child(FirebaseAuth.instance.currentUser!.uid);

    final snapshot = await base.get();
    setState(() {
      currentUser = Users.fromSnapshot(snapshot);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchCo();
  }

  @override
  void fetchCo() async {
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

  Color BackColor = Color.fromRGBO(21, 203, 149, 1);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          appBar: AppBar(
              backgroundColor: BackColor,
              title: Center(child: Text('الصفحة الرئيسية'))),
          drawer: Drawer(
            child: FutureBuilder(
              future: getUserData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (currentUser == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView(
                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        decoration: BoxDecoration(
                          color: BackColor,
                        ),
                        child: Column(
                          children: [
                            Center(
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    AssetImage('assets/images/logo.png'),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text("بيانات المستخدم",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.person,
                        ),
                        title: const Text('اسم المستخدم'),
                        subtitle: Text('${currentUser.fullName}'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.email,
                        ),
                        title: const Text('البريد الالكترونى'),
                        subtitle: Text('${currentUser.email}'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.phone,
                        ),
                        title: const Text('رقم الهاتف'),
                        subtitle: Text('${currentUser.phoneNumber}'),
                      ),
                      Divider(
                        thickness: 0.8,
                        color: Colors.grey,
                      ),
                      Material(
                          color: Colors.transparent,
                          child: InkWell(
                              splashColor: Theme.of(context).splashColor,
                              child: ListTile(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('تأكيد'),
                                          content: Text(
                                              'هل انت متأكد من تسجيل الخروج'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                FirebaseAuth.instance.signOut();
                                                Navigator.pushNamed(
                                                    context, Home.routeName);
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
                                title: Text('تسجيل الخروج'),
                                leading: Icon(Icons.exit_to_app_rounded),
                              )))
                    ],
                  );
                }
              },
            ),
          ),
          body: Column(
            children: [
              Container(
                width: 400.0,
                height: 180.0,
                child: Image.asset(
                  'assets/images/banner.jpg', // Replace with your image asset path
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 10),
                child: Center(
                  child: Text(
                    "المنسقين",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              Container(
                // Set a fixed height or adjust as needed
                child: Expanded(
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return UserHalls(
                              coName: '${list[index].name}',
                            );
                          }));
                          
                        },
                        child: Container(
                          margin: EdgeInsets.all(8.0),
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey[200],
                          ),
                          child: Column(
                            children: [
                              Image.network(
                                '${list[index].imageUrl}',
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                '${list[index].name}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
