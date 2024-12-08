import 'package:exam_store/firebase_options.dart';
import 'package:exam_store/progress/daily.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  return runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
    home: HeatmapCalendarPage()//MyHomePage1()
      
      )
      );
}

