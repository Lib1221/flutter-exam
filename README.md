# Exam Store

A Flutter app for Ethiopian students to practice exams by stream. Users pick between the Social Science and Natural Science streams, work through question lists, follow their progress, and discuss questions with other students. Firebase handles authentication and data.

## Features

- Stream selection: Social Science or Natural Science.
- Question lists per subject with progress tracking.
- Discussion section for each question.
- User accounts with Firebase Authentication and Cloud Firestore.
- Splash screen and a main dashboard.

## Project structure

```
lib/
├── main.dart            # App entry, Firebase init
├── firebase_options.dart
├── splash_Screen/       # Launch screen
├── backend_auth/        # Auth logic
├── stream/              # Stream selection
├── list_Question/       # Question lists
├── progress/            # Progress tracking
├── Discussion/          # Per-question discussion
├── main_page/           # Home dashboard
└── user/                # Profile
```

## Getting started

```bash
git clone https://github.com/Lib1221/flutter-exam.git
cd flutter-exam
flutter pub get
```

Create a Firebase project, enable Authentication and Firestore, and run `flutterfire configure` to regenerate `lib/firebase_options.dart` for your project. Then:

```bash
flutter run
```

## Tech stack

Flutter, Dart, Firebase Auth, Cloud Firestore.

## License

MIT. See [LICENSE](LICENSE).
