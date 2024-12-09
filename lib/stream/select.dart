import 'package:exam_store/progress/daily.dart';
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
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan
            ),
            onPressed: (){
            Navigator.push(context, MaterialPageRoute(
          builder: (context) => HeatmapCalendarPage()),);
          }, 
          child: const Text('Progress Tracker'))
        ],
      ),
      body:const Selector() 
      
    );
  }
}