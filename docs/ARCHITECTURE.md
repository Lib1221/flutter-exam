# Architecture

Exam Store is a Flutter study app backed by Firebase. Students choose a stream, work through question lists, track progress, and discuss questions.

## Modules (`lib/`)

| Folder | Role |
| ------ | ---- |
| `splash_Screen/` | Launch screen |
| `backend_auth/` | Firebase Authentication wrappers |
| `stream/` | Social Science / Natural Science selection |
| `list_Question/` | Question lists per subject, loaded from Firestore |
| `progress/` | Completed questions and scores per user |
| `Discussion/` | Threaded discussion per question |
| `main_page/` | Dashboard and navigation |
| `user/` | Profile |

## Data model (Firestore)

- `users/{uid}`: profile, selected stream, progress summary
- `questions/{id}`: stream, subject, text, options, answer
- `discussions/{questionId}/messages/{id}`: author, text, timestamp
