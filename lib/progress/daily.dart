import 'dart:async';
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
  int _heatmapper = 0;
  int c = 0;
  int zero = 1;

  @override
  void initState() {
    super.initState();
    _restoreState();
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
                  
                  DateTime.now(): 2,

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
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 30),
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
