import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Page/HomePageLogin.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyA1lvy1o8ZOu-MWgPHXEQEBV5_XAq1yFTw",
          authDomain: "visitor-guard.firebaseapp.com",
          databaseURL: "https://visitor-guard.firebaseio.com",
          projectId: "visitor-guard",
          storageBucket: "visitor-guard.appspot.com",
          messagingSenderId: "941591835256",
          appId: "1:941591835256:web:01340b20342f76d959f38d",
          measurementId: "G-R5D7GXB7RQ"
      ),
    );
  } on FirebaseException catch (e) {
    if (e.code == 'duplicate-app') {
      await Firebase.initializeApp();
    }
  }
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
