import 'package:flutter/material.dart';
import '../models/question.dart';
import 'quiz_screen.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  final String chapter;
  final List<Question> questions;
  final List<int> selectedAnswers;

  const ResultScreen({
    super.key,
    required this.chapter,
    required this.questions,
    required this.selectedAnswers,
  });

  @override
  Widget build(BuildContext context) {
    int score = 0;
    for (int i = 0; i < questions.length; i++) {
      if (questions[i].correctIndex == selectedAnswers[i]) {
        score++;
      }
    }

    double percentage = (score / questions.length) * 100;

    return Scaffold(
      appBar: AppBar(title: const Text('Result')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Center(
              child: Text(
                'Score: $score / ${questions.length} (${percentage.toStringAsFixed(1)}%)',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            ...List.generate(questions.length, (index) {
              final question = questions[index];
              final selected = selectedAnswers[index];
              final isCorrect = question.correctIndex == selected;

              return Card(
                color: isCorrect ? Colors.green[100] : Colors.red[100],
                child: ListTile(
                  title: Text(question.questionText),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Your answer: ${question.options[selected]}'),
                      Text('Correct answer: ${question.options[question.correctIndex]}'),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.restart_alt),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuizScreen(
                      chapter: chapter,
                      questions: questions,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              icon: const Icon(Icons.home),
              label: const Text('Return to Home Screen'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
