import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Page/HomePageLogin.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Visitor-Guard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePageLogin('EN'),
    );
  }     // Otherwise, show something whilst waiting for initialization to complete
}
