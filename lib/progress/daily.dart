import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';


class HeatmapCalendarPage extends StatefulWidget {
  @override
  _HeatmapCalendarPageState createState() => _HeatmapCalendarPageState();
}

class _HeatmapCalendarPageState extends State<HeatmapCalendarPage> {
  Timer? _timer;
  int _start = 3600;
  
  void startTimer() {
    // Start the timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start > 0) {
        setState(() {
          _start--;
        });
      } else {
        timer.cancel();
        showCompletionMessage();
      }
    });
  }

  void showCompletionMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Time is up!'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60) % 60;
    final hours = seconds ~/ 3600;
    final int second = (seconds%60);
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}';
  }


@override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Daily progress'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SingleChildScrollView(
                child: HeatMapCalendar(
                                defaultColor: Colors.white,
                                colorMode: ColorMode.color,
                                flexible: true,
                                datasets: {

                                  DateTime(2024, 12, 1): 1,
                                  DateTime(2024, 12, 2): 2,
                                  DateTime(2024, 12, 3): 3,
                                  DateTime(2024, 12, 4): 4,
                                  DateTime(2024, 12, 5): 5,
                                  DateTime(2024, 12, 6): 1,
                                  DateTime(2024, 12, 7): 2,
                                  DateTime(2024, 12, 8): 3,
                                  DateTime(2024, 12, 9): 4,
                                  DateTime(2024, 12, 10): 5,
                                  DateTime(2024, 12, 11): 3,
                                  DateTime(2024, 12, 12): 5,
                                  DateTime(2024, 12, 13): 1,
                                  DateTime(2024, 12, 14): 1,
                                  DateTime(2024, 12, 15): 3,
                                  DateTime(2024, 12, 5): 5,
                                },
                                colorsets: const {
                                  1: Color.fromARGB(255, 141, 221, 201),
                                  2:Color.fromARGB(255, 59, 162, 100),
                                  3: Color.fromARGB(255, 15, 35, 212),
                                  4: Color.fromARGB(255, 190, 255, 9),
                                  5:Color.fromARGB(255, 206, 22, 22)
                                
                                },
                                onClick: (value) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.toString())));
                                },
                              )
                ,
              ),

            Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
            Text(
              formatTime(_start),
              style: const TextStyle(fontSize: 48),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              
              onPressed:_start == 3600 ? startTimer:null,
              child: const Text("Start Countdown"),
            ),
                      ],
                    ),
                  ),

            
          ],
        ),
      ),
    );
}
@override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
















