import 'package:flutter/material.dart';
import 'package:project/pages/auth.dart';
import 'package:project/pages/login_page.dart';
import 'package:project/pages/root_page.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'RemindMe',
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: RootPage(auth: Auth()),
       );
  }
}