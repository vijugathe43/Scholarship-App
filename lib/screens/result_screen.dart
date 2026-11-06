import 'package:flutter/material.dart';
import '../models/question_model.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  final String title;
  final int totalQuestions;
  final int score;
  final List<Question> questions;

  const ResultScreen({
    super.key,
    required this.title,
    required this.totalQuestions,
    required this.score,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = totalQuestions > 0 ? (score / totalQuestions) * 100 : 0.0;

    int stars = 1;
    String greeting = 'Keep Practicing!';
    String message = 'You can do even better next time!';
    Color badgeColor = Colors.orange;

    if (percentage >= 80) {
      stars = 3;
      greeting = 'Outstanding! 🌟';
      message = 'You are a Scholarship Superstar!';
      badgeColor = const Color(0xFF06D6A0);
    } else if (percentage >= 60) {
      stars = 2;
      greeting = 'Great Job! 👏';
      message = 'You have a good grasp of the concepts!';
      badgeColor = const Color(0xFF4361EE);
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // Animated Star Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(
                      Icons.star_rounded,
                      size: index == 1 ? 64 : 48,
                      color: index < stars ? const Color(0xFFFFB703) : const Color(0xFFE0E0E0),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 16),

              Text(
                greeting,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2B2D42),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),

              const SizedBox(height: 24),

              // Score Card
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem('Score', '$score / $totalQuestions', const Color(0xFF4361EE)),
                    Container(height: 40, width: 1, color: Colors.grey[200]),
                    _buildStatItem('Accuracy', '${percentage.toInt()}%', badgeColor),
                    Container(height: 40, width: 1, color: Colors.grey[200]),
                    _buildStatItem('Stars Earned', '+$stars ⭐', const Color(0xFFFFB703)),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                          (route) => false,
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        side: const BorderSide(color: Color(0xFF4361EE), width: 1.5),
                      ),
                      child: const Text('Back to Home', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4361EE),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 2,
                      ),
                      child: const Text('Review Answers', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 36),

              // Quick Question Review Section
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Questions Summary',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2B2D42),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: questions.length,
                itemBuilder: (context, i) {
                  final q = questions[i];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey.withOpacity(0.12)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${i + 1}. ${q.questionText}',
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Text('Correct Answer: ', style: TextStyle(fontSize: 12, color: Colors.grey)),
                            Expanded(
                              child: Text(
                                q.options[q.correctOptionIndex],
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF06D6A0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
