import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  const Question({
    required this.correctAnswerIndex,
    required this.question,
    required this.options,
  });

  // Factory constructor to create a Question from a Firestore document
  factory Question.fromDocument(DocumentSnapshot doc) {
    return Question(
      question: doc['Question'] as String,
      options: List<String>.from(doc['options'] as List),
      correctAnswerIndex: doc['correctAnswer'] as int,
    );
  }
}
