import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String year;
  final String grade;
  final String unit;

  const Question({
    required this.correctAnswerIndex,
    required this.question,
    required this.options,
    required this.year,
    required this.grade,
    required this.unit,

  });

  // Factory constructor to create a Question from a Firestore document
  factory Question.fromDocument(DocumentSnapshot doc) {
    return Question(
      question: doc['Question'] as String,
      options: List<String>.from(doc['options'] as List),
      correctAnswerIndex: doc['correctAnswer'] as int,
     year:doc['year'] as String ,
     grade:doc['grade'] as String,
     unit:doc['unit'] as String
    );
  }
}
