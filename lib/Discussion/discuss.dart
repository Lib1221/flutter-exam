import 'package:exam_store/main_page/models/question.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DiscussionFormState extends StatefulWidget {
  final String documentId; // Renamed for clarity

  DiscussionFormState({required this.documentId});

  @override
  State<DiscussionFormState> createState() => _DiscussionFormState();
}

class _DiscussionFormState extends State<DiscussionFormState> {
  final _formKey = GlobalKey<FormState>();
  String _discussionText = '';
  String _emailAddress = '';
  int _likeCount = 0; // Initialize like count
  List<Discussions> _discussionsList = []; // To hold the fetched discussions

  @override
  void initState() {
    super.initState();
    _fetchDiscussions(); // Fetch discussions when the widget initializes
  }

  // Function to fetch discussions from Firestore
  Future<void> _fetchDiscussions() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Discussions')
          .where('QuestionId', isEqualTo: widget.documentId)
         
          .get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          _discussionsList = snapshot.docs.map((doc) {
            return Discussions.fromDocument(
                doc); 
          }).toList();
        });
      }
    } catch (e) {
      print("Error fetching discussions: $e");
    }
  }

  Future<void> _submitDiscussion() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        _emailAddress = user.email!;
      }

      Discussions newDiscussion = Discussions(
        emailAddress: _emailAddress,
        questionId: widget.documentId,
        like: _likeCount,
        discussions: [_discussionText],
        timestamp: Timestamp.now(),
        docid: '',
      );

      await FirebaseFirestore.instance.collection('Discussions').add({
        'emailAddress': newDiscussion.emailAddress,
        'QuestionId': newDiscussion.questionId,
        'like': newDiscussion.like,
        'discussions': newDiscussion.discussions,
        'timestamp': newDiscussion.timestamp,
      });

      _formKey.currentState!.reset();
      print('Discussion posted: $_discussionText');

      await _fetchDiscussions();
    }
  }

  Future<void> _incrementLike(int index) async {
    final discussion = _discussionsList[index];

    discussion.like += 1;

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Discussions')
          .where('QuestionId', isEqualTo: widget.documentId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        String docId = snapshot.docs.first.id;
        await FirebaseFirestore.instance
            .collection('Discussions')
            .doc(docId)
            .update({
          'like': discussion.like,
        });

        // Update UI state
        setState(() {});
      } else {
        print('No discussions found for this QuestionId.');
      }
    } catch (e) {
      print('Error updating likes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Discussion'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _discussionsList.length,
                itemBuilder: (context, index) {
                  final discussion = _discussionsList[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 4.0,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            discussion.discussions.join(', '),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Posted by: ${discussion.emailAddress}',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          SizedBox(height: 4.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Likes: ${discussion.like}'),
                              ElevatedButton(
                                onPressed: () => _incrementLike(index),
                                child: Text('Like'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Enter your discussion'),
                    maxLines: 5, // Allow multiple lines for discussion text
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null; // Return null if valid
                    },
                    onSaved: (value) {
                      _discussionText = value!; // Save the input value
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitDiscussion,
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
