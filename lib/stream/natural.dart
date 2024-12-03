import 'package:flutter/material.dart';

class  NaturalSubjects extends StatelessWidget {
  const  NaturalSubjects({super.key});

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
                    Navigator.pushNamed(context, '/selection'); },
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
                    Navigator.pushNamed(context, '/selection'); },
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
                    Navigator.pushNamed(context, '/selection'); },
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
                    Navigator.pushNamed(context, '/selection'); },
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
                    Navigator.pushNamed(context, '/selection'); },
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
                    Navigator.pushNamed(context, '/selection'); },
                  style: ElevatedButton.styleFrom(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), 
                  ),
                  padding: const EdgeInsets.all(20),
                  ),
                  child: const Text("BIOLOGY"),
                  ),
         ],
        ),
      ),
    );
  }
}