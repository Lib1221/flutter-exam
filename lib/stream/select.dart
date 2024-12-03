import 'package:exam_store/stream/selector.dart';
import 'package:flutter/material.dart';

class Select extends StatelessWidget {
  const Select({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('select your stream'),
        centerTitle: true,
      ),
      body:const Selector() 
      
    );
  }
}