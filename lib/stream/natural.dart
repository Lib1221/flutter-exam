import 'package:exam_store/main_page/screens/quiz_screen.dart';
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
            ElevatedButton(
                  onPressed: () {
                    String collectionPath = 'Biology'; 
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(collectionPath: collectionPath),
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
              child: const Text("BIOLOGY"),
            ),


            ElevatedButton(
                onPressed: () {
                    String collectionPath = 'Chemistry'; 
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(collectionPath: collectionPath),
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
              child: const Text("CHEMISTRY"),
            ),
            ElevatedButton(
               onPressed: () {
                    String collectionPath = 'English'; 
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(collectionPath: collectionPath),
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
              child: const Text("ENGLISH"),
            ),
            ElevatedButton(
               onPressed: () {
                    String collectionPath = 'Sat'; 
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(collectionPath: collectionPath),
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
              child: const Text("SAT"),
            ),
            ElevatedButton(
               onPressed: () {
                    String collectionPath = 'Mathematics'; 
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(collectionPath: collectionPath),
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
              child: const Text("MATHEMATICS"),
            ),
            ElevatedButton(
              onPressed: () {
                    String collectionPath = 'Physics'; 
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(collectionPath: collectionPath),
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
              child: const Text("PHYSICS"),
            ),
          ],
        ),
      ),
    );
  }
}
