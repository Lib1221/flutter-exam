import 'package:flutter/material.dart';

class Selector extends StatelessWidget {
  const Selector({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/natural');
              },
              child: const Text('Natural science')),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/social');
              },
              child: const Text('Social science')),
        ],
      ),
    );
  }
}
