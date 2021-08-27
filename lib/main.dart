import 'package:flutter/material.dart';
import 'package:todo_application_official/database/database.dart';
import 'package:todo_application_official/screen/todo_homepage.dart';

AppDatabase? appDatabase; //singleton
void main() {
  appDatabase = AppDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: Homepage(),
    );
  }
}
