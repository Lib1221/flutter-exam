import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_store/main_page/screens/quiz_screen.dart';
import 'package:exam_store/progress/daily.dart';
import 'package:flutter/material.dart';

class ListQuestions extends StatefulWidget {
  final String collectionPath;

  const ListQuestions({required this.collectionPath});

  @override
  State<ListQuestions> createState() => _ListQuestionsState();
}

class _ListQuestionsState extends State<ListQuestions> {
  String year = '2010'; 
  Map<String, Map<String, int>> questionCountByGradeAndUnit = {};
  bool isLoading = true; 
  String message = ''; 

  @override
  void initState() {
    super.initState();
    _fetchUniqueUnitsByGrade(year); 
  }

  Future<void> _fetchUniqueUnitsByGrade(String selectedYear) async {
    setState(() {
      isLoading = true; 
      message = ''; 
    });

    Map<String, Map<String, int>> unitsMap = {};


    List<String> grades = ['9', '10', '11', '12']; 

    for (String grade in grades) {
      QuerySnapshot unitSnapshot = await FirebaseFirestore.instance
          .collection(widget.collectionPath)
          .where('year', isEqualTo: selectedYear)
          .where('grade', isEqualTo: grade)
          .get();

      if (unitSnapshot.docs.isEmpty) {
        message = 'No questions available for $selectedYear in Grade $grade.';
      } else {
        for (var doc in unitSnapshot.docs) {
          String unitValue = doc['unit'] as String;

          if (!unitsMap.containsKey(grade)) {
            unitsMap[grade] = {};
          }

          if (!unitsMap[grade]!.containsKey(unitValue)) {
            unitsMap[grade]![unitValue] = 0;
          }
          unitsMap[grade]![unitValue] = unitsMap[grade]![unitValue]! + 1;
        }
      }
    }

    setState(() {
      questionCountByGradeAndUnit = unitsMap;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.collectionPath),
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
          ,
        ],
      ),
      body: isLoading 
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildYearButton('2010'),
                        _buildYearButton('2011'),
                        _buildYearButton('2012'),
                        _buildYearButton('2013'),
                        _buildYearButton('2014'),
                        _buildYearButton('2015'),
                        _buildYearButton('2016'),
                        _buildYearButton('2017'),
                      ],
                    ),
                  ),
                ),

                if (message.isNotEmpty) 
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(message, style:const TextStyle(color: Colors.red)),
                  ),
                
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: questionCountByGradeAndUnit.keys.map((grade) {
                        return Column(
                          children: questionCountByGradeAndUnit[grade]!.keys.map((unit) {
                            int itemCount = questionCountByGradeAndUnit[grade]![unit]!;
                            return _buildGrade(widget.collectionPath, grade, unit, year, itemCount);
                          }).toList(),
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),
    );
  }

  Widget _buildYearButton(String yearValue) {
    bool isSelected = year == yearValue; 
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: isSelected ? const Color.fromARGB(255, 34, 194, 3) : Colors.grey, 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          setState(() {
            year = yearValue; 
          });
          _fetchUniqueUnitsByGrade(year); 
        },
        child: Text(yearValue),
      ),
    );
  }

  Widget _buildGrade(String collectionPath, String grade, String unit, String year, int itemCount) {
    return Card(
      color: Colors.yellow[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuizScreen(
                  collectionPath: collectionPath,
                  grade: grade,
                  unit: unit,
                  year: year,
                ),
              ),
            );
          },
          child: Row(
            children: [
              Text(
                'Grade $grade - Unit $unit (Questions Count: $itemCount)',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

            ],
          ),
        ),
      ),
    );
  }
}