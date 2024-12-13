import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  final String documentId;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String year;
  final String grade;
  final String unit;

  const Question({
    required this.documentId,
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
      year: doc['year'] as String,
      grade: doc['grade'] as String,
      unit: doc['unit'] as String,
      documentId: doc.id,
    );
  }
}

class Discussions {
  final String emailAddress;
  int like;
  final String questionId;
  final List<String> discussions;
  final Timestamp timestamp; // Corrected the field name to 'timestamp'
  final String docid;

  Discussions({
    required this.timestamp,
    required this.emailAddress,
    required this.questionId,
    required this.like,
    required this.discussions,
    required this.docid
  });

  factory Discussions.fromDocument(DocumentSnapshot doc) {
    return Discussions(
      questionId: doc['QuestionId'] as String,
      like: doc['like'] as int,
      discussions: List<String>.from(doc['discussions'] as List),
      emailAddress: doc['emailAddress'] as String, 
      timestamp: doc['timestamp'] as Timestamp,
       docid: doc.id, 
    );
  }
}
