import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:student_details/screens/homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCzYX6vYS0CoBt2UbS5Vth2EdAn67lYCG4",
          authDomain: "student-details-f8468.firebaseapp.com",
          projectId: "student-details-f8468",
          storageBucket: "student-details-f8468.appspot.com",
          messagingSenderId: "575913607634",
          appId: "1:575913607634:web:e383b2e6dd4c677072480b"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Details',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const HomeScreen(),
    );
  }
}
