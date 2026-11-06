import 'package:flutter/material.dart';
import '../models/question_model.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final String title;
  final List<Question> questions;

  const QuizScreen({
    super.key,
    required this.title,
    required this.questions,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int? _selectedOptionIndex;
  bool _hasAnswered = false;
  int _score = 0;
  final List<bool?> _answersHistory = [];

  void _onSelectOption(int index) {
    if (_hasAnswered) return;

    setState(() {
      _selectedOptionIndex = index;
      _hasAnswered = true;
      final isCorrect = index == widget.questions[_currentIndex].correctOptionIndex;
      if (isCorrect) {
        _score++;
      }
      _answersHistory.add(isCorrect);
    });
  }

  void _nextQuestion() {
    if (_currentIndex < widget.questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedOptionIndex = null;
        _hasAnswered = false;
      });
    } else {
      // Completed quiz, go to results
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            title: widget.title,
            totalQuestions: widget.questions.length,
            score: _score,
            questions: widget.questions,
          ),
        ),
      );
    }
  }

  void _showHint(String hint) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.lightbulb_rounded, color: Colors.amber, size: 28),
            SizedBox(width: 8),
            Text('Helpful Hint', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: Text(
          hint,
          style: const TextStyle(fontSize: 15, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Got it!'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: const Center(child: Text('No questions available in this section.')),
      );
    }

    final currentQuestion = widget.questions[_currentIndex];
    final progress = (_currentIndex + 1) / widget.questions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          tooltip: 'Exit Quiz',
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                title: const Text('Leave Quiz?'),
                content: const Text('Do you want to exit? Your current test progress will be lost.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Stay'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF5964), foregroundColor: Colors.white),
                    child: const Text('Leave'),
                  ),
                ],
              ),
            );
          },
        ),
        actions: [
          if (currentQuestion.hint != null)
            IconButton(
              icon: const Icon(Icons.lightbulb_outline_rounded, color: Colors.amber),
              tooltip: 'Hint',
              onPressed: () => _showHint(currentQuestion.hint!),
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Linear Progress Bar & Question Counter
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Question ${_currentIndex + 1} of ${widget.questions.length}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4361EE),
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Score: $_score',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF06D6A0),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      backgroundColor: Colors.grey[200],
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4361EE)),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Question & Options in scrollable area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Question Box
                    Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        currentQuestion.questionText,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E293B),
                          height: 1.4,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 4 Option Buttons
                    ...List.generate(currentQuestion.options.length, (index) {
                      return _buildOptionButton(index, currentQuestion);
                    }),

                    const SizedBox(height: 16),

                    // Explanation Box if Answered
                    if (_hasAnswered) ...[
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F4FF),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFD0E1FD)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.info_outline_rounded, color: Color(0xFF4361EE), size: 20),
                                SizedBox(width: 8),
                                Text(
                                  'Explanation:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4361EE),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              currentQuestion.explanation,
                              style: const TextStyle(
                                fontSize: 13.5,
                                color: Color(0xFF334155),
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ],
                ),
              ),
            ),

            // Bottom Action Button
            if (_hasAnswered)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _nextQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4361EE),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      _currentIndex < widget.questions.length - 1 ? 'Next Question ➔' : 'Finish & View Score 🏆',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(int index, Question question) {
    const letters = ['A', 'B', 'C', 'D'];
    Color borderColor = Colors.grey.withOpacity(0.2);
    Color bgColor = Colors.white;
    Color textColor = const Color(0xFF334155);
    Widget? trailingIcon;

    if (_hasAnswered) {
      if (index == question.correctOptionIndex) {
        // Correct answer always green
        borderColor = const Color(0xFF06D6A0);
        bgColor = const Color(0xFFE8FDF5);
        textColor = const Color(0xFF0F5132);
        trailingIcon = const Icon(Icons.check_circle_rounded, color: Color(0xFF06D6A0));
      } else if (index == _selectedOptionIndex) {
        // User chose wrong answer
        borderColor = const Color(0xFFFF5964);
        bgColor = const Color(0xFFFDE8E9);
        textColor = const Color(0xFF842029);
        trailingIcon = const Icon(Icons.cancel_rounded, color: Color(0xFFFF5964));
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 2),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _onSelectOption(index),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                // Option Letter badge (A, B, C, D)
                Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    letters[index],
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    question.options[index],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                ),
                if (trailingIcon != null) trailingIcon,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
