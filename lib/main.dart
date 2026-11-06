import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ScholarshipApp());
}

class ScholarshipApp extends StatelessWidget {
  const ScholarshipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Class 4 Scholarship Prep',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}
