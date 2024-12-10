// ignore_for_file: avoid_types_as_parameter_names

import 'dart:async';
import 'package:exam_store/user/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeatmapCalendarPage extends StatefulWidget {
  @override
  _HeatmapCalendarPageState createState() => _HeatmapCalendarPageState();
}

class _HeatmapCalendarPageState extends State<HeatmapCalendarPage> {
  Timer? _timer;
  int _start = 3600;
  int c = 0;
  int zero = 1;
  int _heatmapper = 0;
  String? _lastUpdatedDate;

  Map<DateTime, int> dailyStrikes = {};
  @override
  void initState() {
    super.initState();
    _restoreState();
    saveDailyStrikeData(_heatmapper);
    _loadDailyStrikes();
    _loadCounter();
  }

  Future<void> _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _heatmapper = prefs.getInt('counter') ?? 0;
      _lastUpdatedDate = prefs.getString('lastUpdatedDate');

      String todayDate = DateTime.now().toIso8601String().split('T')[0];

      if (_lastUpdatedDate != todayDate) {
        _heatmapper = 0;
      }
      prefs.setString('lastUpdatedDate', todayDate);
    });
  }

  Future<void> _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _heatmapper++;
      prefs.setInt('counter', _heatmapper);
    });
  }

  Future<void> _loadDailyStrikes() async {
    dailyStrikes = await getDailyStrikeData();
    setState(() {});
  }

  void startTimer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final now = DateTime.now().millisecondsSinceEpoch;
    prefs.setBool('is_Canceled', false);
    prefs.setInt('remainingTime', _start);
    prefs.setInt('startTime', now);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start > 0 && c == 0) {
        setState(() {
          _start--;
        });
        prefs.setInt('remainingTime', _start);
      } else {
        timer.cancel();
        showCompletionMessage(zero == 1 ? 'Time is up!' : 'Time canceled');
        zero = 1;
        _incrementCounter();
        saveDailyStrikeData(_heatmapper);
      }
      c = 0;
    });
  }

  void Stop() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('is_Canceled', true);
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

  Future<void> _restoreState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final is_Canceled = prefs.getBool('is_Canceled') ?? true;
    final savedTime = prefs.getInt('remainingTime') ?? 3600;
    final startTime =
        prefs.getInt('startTime') ?? DateTime.now().millisecondsSinceEpoch;

    final elapsed = DateTime.now().millisecondsSinceEpoch - startTime;
    final remainingTime = savedTime - (elapsed ~/ 1000);

    if (!is_Canceled && remainingTime > 0) {
      setState(() {
        _start = remainingTime;
      });

      startTimer();
    }
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
        title: const Text('Your Daily Progress'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context)
              .copyWith(scrollbars: false), // Disable scrollbars,
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeatMapCalendar(
                  defaultColor: Colors.white,
                  colorMode: ColorMode.color,
                  datasets: dailyStrikes.isNotEmpty ? dailyStrikes : {},
                  colorsets: const {
                    1: Color.fromARGB(255, 141, 221, 201), // Light Green
                    2: Color.fromARGB(255, 59, 162, 100), // Medium Light Green
                    3: Color.fromARGB(255, 30, 120, 50), // Medium Green
                    4: Color.fromARGB(255, 15, 80, 30), // Darker Green
                    5: Color.fromARGB(255, 0, 50, 20), // Dark Green

                    6: Color.fromARGB(255, 255, 200, 200), // Light Red
                    7: Color.fromARGB(255, 255, 150, 150), // Medium Light Red
                    8: Color.fromARGB(255, 255, 100, 100), // Medium Red
                    9: Color.fromARGB(255, 220, 50, 50), // Strong Red
                    10: Color.fromARGB(255, 180, 20, 20), // Darker Red
                  },
                  onClick: (value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(value.toString())));
                  },
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
                        onPressed: _start == 3600 ? startTimer : Stop,
                        child: _start == 3600
                            ? const Text("Start Countdown")
                            : const Text("Stop Countdown"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Top Rated Student"),
                const Divider(
                  height: 10,
                  thickness: 5,
                  indent: 10,
                  color: Colors.green,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 30),
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text("Liben Adugna --> ${index + 1} "),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
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
