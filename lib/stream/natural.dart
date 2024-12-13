import 'package:exam_store/list_Question/listQ.dart';
import 'package:exam_store/progress/daily.dart';
import 'package:flutter/material.dart';

class NaturalSubjects extends StatelessWidget {
  const NaturalSubjects({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Natural subject Selection"),
        centerTitle: true,
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HeatmapCalendarPage()),
                );
              },
              child: const Text('Progress Tracker'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            course(context, 'Biology'),
            course(context, 'Physics'),
            course(context, 'Sat'),
            course(context, 'Mathematics'),
            course(context, 'Chemistry'),
            course(context, 'English'),
          ],
        ),
      ),
    );
  }
}

Widget course(BuildContext context, String collectionPath) {
  return ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListQuestions(
            collectionPath: collectionPath,
          ),
        ),
      );
    },
    style: ElevatedButton.styleFrom(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.all(20),
    ),
    child: Text(collectionPath),
  );
}

// ignore: camel_case_types
class socialSubjects extends StatelessWidget {
  const socialSubjects({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Social subject Selection"),
        centerTitle: true,
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HeatmapCalendarPage()),
                );
              },
              child: const Text('Progress Tracker'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            course(context, 'English'),
            course(context, 'History'),
            course(context, 'Geography'),
            course(context, 'Mathematics_for_social'),
            course(context, 'Sat'),
            course(context, 'Economics'),
          ],
        ),
      ),
    );
  }
}
