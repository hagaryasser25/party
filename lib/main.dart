import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:party/Users/HomeUser.dart';
import 'package:party/Users/Registration.dart';
import 'package:party/Users/booking.dart';
import 'package:party/admin/add_coordinator.dart';
import 'package:party/coordinator/add_halls.dart';
import 'package:party/admin/admin_coordinators.dart';
import 'package:party/coordinator/coordinator_halls.dart';
import 'package:party/admin/admin_home.dart';
import 'package:party/coordinator/coordinator_list.dart';
import 'package:party/auth/Login.dart';
import 'package:party/auth/admin_login.dart';
import 'package:party/auth/coordinator_login.dart';
import 'package:party/coordinator/coordinator_home.dart';

import 'Home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: FirebaseAuth.instance.currentUser == null
            ? Login()
            : FirebaseAuth.instance.currentUser!.email == 'admin@gmail.com'
                ? const AdminHome()
                : FirebaseAuth.instance.currentUser!.displayName == 'منسق'
                    ? const CoordinatorHome()
                    : HomeUser(),
      routes: {
        AdminLogin.routeName: (ctx) => AdminLogin(),
        Registration.routeName: (ctx) => Registration(),
        AdminHome.routeName: (ctx) => AdminHome(),
        AddHalls.routeName: (ctx) => AddHalls(),
        Home.routeName: (ctx) => Home(),
        HomeUser.routeName: (ctx) => HomeUser(),
        AdminCoordinators.routeName: (ctx) => AdminCoordinators(),
        AddCoordinator.routeName: (ctx) => AddCoordinator(),
        CoordinatorLogin.routeName: (ctx) => CoordinatorLogin(),
        CoordinatorHome.routeName: (ctx) => CoordinatorHome(),
      },
    );
  }
}
