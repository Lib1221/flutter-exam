import 'package:exam_store/firebase_options.dart';
import 'package:exam_store/progress/daily.dart';
import 'package:exam_store/splash_Screen/splash_Screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  return runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
    home: MyHomePage1()
      
      )
      );
}

