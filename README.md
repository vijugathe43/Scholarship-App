# 🎓 Class 4 Scholarship Exam Preparation App (English Medium)

A dedicated, kid-friendly Flutter mobile app for 4th Standard students preparing for the Scholarship Examination (English Medium).

---

## 🌟 Features Included

1. **Kid-Friendly & Gamified UI**:
   - Bright colors, rounded cards, icons, and star badges designed specifically for 8-10 year olds.
   - Immediate visual feedback on answers (Green for correct, Red for incorrect).
   - "Why is this correct?" step-by-step explanations.
   - Helpful Hint button on tricky questions.

2. **Core 4th Standard Subjects Covered**:
   - 🔢 **Mathematics**:
     - Numbers & Place Value (4-digit, 5-digit, Roman Numerals, Predecessor/Successor)
     - Fractions & Decimals
     - Time, Money & Measurements
   - 📖 **English (First Language)**:
     - Nouns & Pronouns (Collective nouns, pronouns)
     - Vocabulary & Opposites (Synonyms, Antonyms)
     - Prepositions & Tenses
   - 🧠 **Intelligence Test (Mental Ability / Paper 2)**:
     - Odd Man Out (Classification)
     - Number & Letter Series
     - Coding & Decoding

3. **Practice & Exam Modes**:
   - **Daily Challenge**: Quick 10-question mixed practice test.
   - **Chapter-wise Practice**: Select specific topic to master.
   - **Test All / Mock Test**: Full subject test simulation.
   - **Result & Review Screen**: 3-star rating system, score tally, accuracy %, and complete answer review.

---

## 📁 Project Structure

```text
Scolarship Project/
├── lib/
│   ├── data/
│   │   └── scholarship_data.dart   # Question bank for Maths, English & Intelligence
│   ├── models/
│   │   ├── question_model.dart     # Question data model with hints & explanations
│   │   └── subject_model.dart      # Subject and Chapter data models
│   ├── screens/
│   │   ├── home_screen.dart        # Main dashboard with subjects & daily challenge
│   │   ├── chapters_screen.dart    # Chapter list per subject
│   │   ├── quiz_screen.dart        # Interactive MCQ quiz screen with timer & hints
│   │   └── result_screen.dart      # Star celebration and score review
│   ├── theme/
│   │   └── app_theme.dart          # Kid-friendly color palette and theme styling
│   └── main.dart                   # Application entry point
├── pubspec.yaml                    # Flutter configuration & dependencies
└── README.md
```

---

## 🚀 How to Run (Flutter Setup Guide)

### Step 1: Install Git & Flutter SDK
1. **Download Git**: [https://git-scm.com/download/win](https://git-scm.com/download/win) (Run installer and click Next).
2. **Download Flutter SDK**: [https://docs.flutter.dev/get-started/install/windows/mobile](https://docs.flutter.dev/get-started/install/windows/mobile)
   - Extract the zip to `C:\src\flutter`.
   - Add `C:\src\flutter\bin` to your System Environment Variable **Path**.

### Step 2: Open Terminal / Command Prompt and verify:
```bash
flutter doctor
```

### Step 3: Run this Project:
In the project directory `d:\Vijay Gathe\Scolarship Project`:
```bash
flutter pub get
flutter run
```
You can run it on your Android Phone (with USB Debugging turned ON), Android Emulator, or directly in Google Chrome!

---

## ➕ How to Add More Questions

Open [`lib/data/scholarship_data.dart`](file:///d:/Vijay%20Gathe/Scolarship%20Project/lib/data/scholarship_data.dart) and simply add new `Question` objects under any subject and chapter:

```dart
Question(
  id: 'm1_5',
  questionText: 'What is 250 + 750?',
  options: ['900', '1,000', '1,100', '1,200'],
  correctOptionIndex: 1, // 0 is first option, 1 is second, etc.
  explanation: '250 + 750 = 1,000.',
  hint: 'Add 250 and 750 together.',
),
```
