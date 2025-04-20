# Todo & Notes App

A Flutter application for managing tasks and notes with offline-first functionality.

## Features
- Create/edit/delete/search tasks and notes
- Mark tasks as complete
- Offline persistence with Hive
- Clean Riverpod state management
- Responsive design

## Architecture
- **Models**: Task, Note
- **Repositories**: Handle data operations
- **Providers**: StateNotifiers for business logic
- **Widgets**: Reusable UI components

## How to Run
1. Install Flutter 3.0+
2. Clone repository
3. Install dependencies:flutter pub get
4. Generate adapters:flutter pub run build_runner build
5. Run the app:flutter run

## Folder Structure
lib/
├── core/
│ ├── models/
│ ├── providers/
│ └── repositories/
├── views/
│ ├── screens/
│ └── widgets/
└── main.dart




