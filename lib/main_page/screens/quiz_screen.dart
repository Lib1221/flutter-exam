import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_store/main_page/answer_card.dart';
import 'package:exam_store/main_page/models/question.dart';
import 'package:exam_store/main_page/next_button.dart';
import 'package:exam_store/main_page/screens/result_screen.dart';
import 'package:exam_store/progress/daily.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class QuizScreen extends StatefulWidget {
  final String collectionPath;
  final String year;
  final String unit;
  final String grade;
  const QuizScreen({
    required this.collectionPath,
    required this.year,
    required this.unit,
    required this.grade,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int? selectedAnswerIndex;
  int questionIndex = 0;
  int score = 0;
  List<Question> questions = [];
  String prompt = "";

  @override
  void initState() {
    super.initState();
    dataRetrive(
        widget.grade, widget.year, widget.unit); // Call dataRetrive here
  }

  final String apiKey =
      'AIzaSyCU1LfkMOGQoUG5O6sebLsktl5E_CJ4r70'; // Replace with your actual API key
  String responseText = '';

  Future<void> generateResponse(String prompt) async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest', // Specify the model you want to use
      apiKey: apiKey,
    );

    final content = [Content.text(prompt)];
    try {
      final response = await model.generateContent(content);
      setState(() {
        responseText = response.text ??
            'No response received'; // Update state with response text
      });
    } catch (error) {
      setState(() {
        responseText = 'Error: $error'; // Handle errors gracefully
      });
    }
  }

  Future<void> showMarkdownBottomSheet(BuildContext context, String prompt) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true, // Allows bottom sheet to be scrollable
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                prompt.isNotEmpty?Text(prompt):Text('fetching the data'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> dataRetrive(String grade, String year, String unit) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection(widget.collectionPath)
          .where('grade', isEqualTo: grade)
          .where('year', isEqualTo: year)
          .where('unit', isEqualTo: unit)
          .get();

      if (snapshot.docs.isNotEmpty) {
        questions = snapshot.docs.map((doc) {
          return Question.fromDocument(doc);
        }).toList();
        setState(() {});
      } else {
        print("No questions found.");
      }
    } catch (e) {
      print("Error retrieving data: $e");
    }
  }

  void pickAnswer(int value) {
    selectedAnswerIndex = value;
    final question = questions[questionIndex];
    if (selectedAnswerIndex == question.correctAnswerIndex) {
      score++;
    }
    setState(() {});
  }

  void goToNextQuestion() {
    if (questionIndex < questions.length - 1) {
      questionIndex++;
      selectedAnswerIndex = null;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      // Show loading or empty state while fetching questions
      return const Center(child: CircularProgressIndicator());
    }

    final question = questions[questionIndex];
    bool isLastQuestion = questionIndex == questions.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Room'),
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
              child: const Text('Progress Tracker')),
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/profile');
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              question.question,
              style: const TextStyle(fontSize: 21),
              textAlign: TextAlign.center,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: question.options.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: selectedAnswerIndex == null
                      ? () => pickAnswer(index)
                      : null,
                  child: AnswerCard(
                    currentIndex: index,
                    question: question.options[index],
                    isSelected: selectedAnswerIndex == index,
                    selectedAnswerIndex: selectedAnswerIndex,
                    correctAnswerIndex: question.correctAnswerIndex,
                  ),
                );
              },
            ),
            Row(
              children: [
                Expanded(
                    child: RectangularButton(
                        onPressed: () {
                          prompt =
                              "anwer these question briefly and detailed also suggest the anwer" +
                                  question.question +
                                  "here it is the chooses";
                          for (String i in question.options) {
                            prompt += i + " ";
                          }
                          generateResponse(prompt);
                          prompt = "";
                          showMarkdownBottomSheet(context, responseText);
                        },
                        label: 'Ai Detailed Answer')),
                Expanded(
                    child: RectangularButton(
                        onPressed: () {}, label: 'Discussion')),
              ],
            ),
            isLastQuestion
                ? RectangularButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => ResultScreen(
                            score: score,
                            len: questions.length,
                          ),
                        ),
                      );
                    },
                    label: 'Finish',
                  )
                : RectangularButton(
                    onPressed:
                        selectedAnswerIndex != null ? goToNextQuestion : null,
                    label: 'Next',
                  ),
          ],
        ),
      ),
    );
  }
}
