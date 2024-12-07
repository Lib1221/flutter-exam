// ignore_for_file: non_constant_identifier_names

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
  int _heatmapper = 0;
  int c = 0;
  int zero = 1;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start > 0 && c == 0) {
        setState(() {
          _start--;
        });
      } else {
        timer.cancel();
        showCompletionMessage(zero == 1 ? 'Time is up!' : 'Time canceled');
        zero = 1;

        setState(() {
          _start = 3600;
          if (_heatmapper <= 5) {
            _heatmapper += 1;
          }
        });
      }
      c = 0;
    });
  }

  void Stop() {
    _timer = Timer.periodic(const Duration(seconds: 0), (timer) {
      timer.cancel();
      setState(() {
        c = 1;
        zero = 0;
      });
    });
  }

  void showCompletionMessage(String displayed) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(displayed),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60) % 60;
    final hours = seconds ~/ 3600;
    final int second = (seconds % 60);
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
                flexible: false,
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

                  //it takes current date value and then add to or append it
                  // DateTime(year,month,day):_heatmapper
                },
                colorsets: const {
                  1: Color.fromARGB(255, 141, 221, 201),
                  2: Color.fromARGB(255, 59, 162, 100),
                  3: Color.fromARGB(255, 15, 35, 212),
                  4: Color.fromARGB(255, 190, 255, 9),
                  5: Color.fromARGB(255, 206, 22, 22),
                  6: Color.fromARGB(255, 141, 221, 201),
                  7: Color.fromARGB(255, 59, 162, 100),
                  8: Color.fromARGB(255, 15, 35, 212),
                  9: Color.fromARGB(255, 190, 255, 9),
                  10: Color.fromARGB(255, 206, 22, 22)
                },
                onClick: (value) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(value.toString())));
                },
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      formatTime(_start),
                      style: const TextStyle(fontSize: 48),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _start == 3600 ? startTimer : Stop,
                      child: _start == 3600
                          ? const Text("Start Countdown")
                          : const Text("Stop Countdown"),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Top Rated student "),
            const Divider(
              height: 10,
              thickness: 5,
              indent: 10,
              color: Colors.green,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text("Liben Adugna--> ${index + 1} "),
                      ),
                    );
                  }),
            )
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
