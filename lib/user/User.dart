import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> saveDailyStrikeData(int streakCount) async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    String todayDate = DateTime.now().toIso8601String().split('T')[0];

    DocumentSnapshot docSnapshot = await users.doc(user.uid).get();

    bool alreadyExists = false;

    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;

      if (data != null && data['dailyStrikes'] != null) {
        for (var entry in data['dailyStrikes']) {
          if (entry['date'].split('T')[0] == todayDate) {
            alreadyExists = true;
            break;
          }
        }
      }
    }

    if (!alreadyExists) {
      var entry = {
        'date': DateTime.now().toIso8601String(),
        'streakCount': streakCount,
      };

      await users.doc(user.uid).set({
        'dailyStrikes': FieldValue.arrayUnion([entry]),
      }, SetOptions(merge: true));

      print("Today's strike data saved.");
    } else {
      print("An entry for today already exists. No new data saved.");
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
            strikes[date] = streakCount;
          } else if (entry['date'] is Timestamp) {
            Timestamp timestamp = entry['date'];
            DateTime date = timestamp.toDate();
            int streakCount = entry['streakCount'] as int;
            strikes[date] = streakCount;
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
