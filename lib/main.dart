

import 'package:exam_store/backend_auth/firebase_ui.dart';
import 'package:exam_store/firebase_options.dart';
import 'package:exam_store/splash_Screen/splash_Screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  return runApp(
    const MaterialApp(
    home: MyHomePage1()
      
      )
      );
}

