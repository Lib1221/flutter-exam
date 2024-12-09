import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> saveDailyStrikeData(int streakCount) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    String todayDate = DateTime.now().toIso8601String().split('T')[0];

    DocumentSnapshot docSnapshot = await users.doc(user.uid).get();

    bool alreadyExists = false;
    int existingStreakCount = 0; 

    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;

      if (data != null && data['dailyStrikes'] != null) {
        for (var entry in data['dailyStrikes']) {
          if (entry['date'] == todayDate) {
            alreadyExists = true;
            existingStreakCount =
                entry['streakCount'] as int; 
            break;
          }
        }
      }

      if (!alreadyExists) {
        var entry = {
          'date': todayDate,
          'streakCount': streakCount,
        };

        await users.doc(user.uid).set({
          'dailyStrikes': FieldValue.arrayUnion([entry]),
        }, SetOptions(merge: true));

        print("Today's strike data saved.");
      } else {
        if (streakCount > existingStreakCount) {

          List<dynamic> dailyStrikes = data?['dailyStrikes'];

          int indexToUpdate =
              dailyStrikes.indexWhere((entry) => entry['date'] == todayDate);

          if (indexToUpdate != -1) {
            dailyStrikes[indexToUpdate]['streakCount'] = streakCount;

            await users.doc(user.uid).set({
              'dailyStrikes': dailyStrikes,
            }, SetOptions(merge: true));

            print("Today's strike data updated.");
          }
        } else {
          print(
              "New streak count is not greater than the existing one. No update made.");
        }
      }
    }
  } else {
    print("No user is signed in.");
  }
}

Future<Map<DateTime, int>> getDailyStrikeData() async {
  User? user = FirebaseAuth.instance.currentUser;
  Map<DateTime, int> strikes = {};

  if (user != null) {
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;

      if (data != null && data['dailyStrikes'] != null) {
        for (var entry in data['dailyStrikes']) {
          if (entry['date'] is String) {
            DateTime date = DateTime.parse(entry['date']);
            int streakCount = entry['streakCount'] as int;
            strikes[DateTime(date.year, date.month, date.day)] = streakCount;
          }
        }
      } else {
        print("No daily strikes found.");
      }
    } else {
      print("Document does not exist.");
    }
  } else {
    print("No user is signed in.");
  }

  return strikes;
}
