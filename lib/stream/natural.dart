import 'package:exam_store/list_Question/listQ.dart';
import 'package:flutter/material.dart';

class NaturalSubjects extends StatelessWidget {
  const NaturalSubjects({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Natural subject Selection"),
        centerTitle: true,
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
