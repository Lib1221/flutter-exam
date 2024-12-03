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
              onPressed: (){
               Navigator.pushReplacementNamed(context, '/natural');
            }, child: const Text('Natural science')),
            const SizedBox(height: 40,),
            ElevatedButton(onPressed: (){}, child: const Text('Social science')),
          ],
        ),
      );
  }
}