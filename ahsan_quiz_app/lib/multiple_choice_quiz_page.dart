import 'dart:async';

import 'package:flutter/material.dart';
import 'true_false_quiz_page.dart';

class MultipleChoiceQuizPage extends StatefulWidget {
  @override
  _MultipleChoiceQuizPageState createState() => _MultipleChoiceQuizPageState();
}

class _MultipleChoiceQuizPageState extends State<MultipleChoiceQuizPage> {
  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  int incorrectAnswers = 0;
  bool answered = false;

  List<String> questions = [
    'What is Flutter?',
    'What language is Flutter written in?',
    'What is a widget in Flutter?',
    'What is a stateful widget in Flutter?',
    'What is a stateless widget in Flutter?',
    'What is hot reload in Flutter?',
    'What is a MaterialApp widget in Flutter?',
    'What is a Scaffold widget in Flutter?',
    'What is an AppBar widget in Flutter?',
    'What is a FloatingActionButton widget in Flutter?',
  ];

  List<List<String>> choices = [
    [
      'A mobile app SDK for building high-performance, high-fidelity, apps for iOS and Android, from a single codebase.',
      'A web development framework.',
      'A programming language.'
    ],
    ['Java', 'Dart', 'Swift'],
    [
      'A graphical element on the screen that can contain other widgets.',
      'A class that can have mutable state.',
      'A button.'
    ],
    [
      'A widget that has mutable state.',
      'A widget that has immutable state.',
      'A button.'
    ],
    [
      'A widget that has immutable state.',
      'A widget that has mutable state.',
      'A button.'
    ],
    [
      'The ability to make changes to your apps code and see them immediately reflected in the running app.',
      'A feature that lets you load assets on the fly.',
      'A way to generate code automatically.'
    ],
    [
      'A widget that sets up the main theme and routing for an app.',
      'A widget that provides a visual structure for an app.',
      'A widget that contains a single child widget.'
    ],
    [
      'A widget that provides a visual structure for an app.',
      'A widget that contains a single child widget.',
      'A widget that sets up the main theme and routing for an app.'
    ],
    [
      'A widget that sets up the main theme and routing for an app.',
      'A widget that provides a visual structure for an app.',
      'A widget that contains a single child widget.'
    ],
    [
      'A widget that provides a floating action button.',
      'A widget that provides a visual structure for an app.',
      'A widget that sets up the main theme and routing for an app.'
    ],
  ];

  List<int> answers = [0, 1, 0, 0, 1, 0, 0, 1, 2, 0];
  bool timeUp = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() => Timer(Duration(seconds: 10), () {
      setState(() {
        timeUp = true;
        checkAnswer(false as int);
      });
    });

  void checkAnswer(int userAnswer) {
    setState(() {
      answered = true;
      if (userAnswer == answers[currentQuestionIndex]) {
        correctAnswers++;
      } else {
        incorrectAnswers++;
      }
    });
  }

  void nextQuestion() {
    setState(() {
      answered = false;
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MultipleChoiceQuizResultsPage(
              correctAnswers: correctAnswers,
              incorrectAnswers: incorrectAnswers,
              questions: questions,
              choices: choices,
              answers: answers,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multiple Choice Quiz'),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: DrawerWidget(),
      body:
      Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[


            Text(
              'Question ${currentQuestionIndex + 1} of ${questions.length}',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            Text(
              questions[currentQuestionIndex],
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: choices[currentQuestionIndex].length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent, // Change "grey" to the color you want
                      ),
                      onPressed: answered ? null : () => checkAnswer(index),
                      child: Text(
                        choices[currentQuestionIndex][index],
                        style: TextStyle(fontSize: 18.0),

                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Change "grey" to the color you want
                  ),
                  onPressed: currentQuestionIndex == 0
                      ? null
                      : () => setState(() => currentQuestionIndex--),
                  child: Text('Back'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Change "grey" to the color you want
                  ),
                  onPressed: answered ? nextQuestion : null,
                  child: Text(
                    currentQuestionIndex == questions.length - 1
                        ? 'Finish'
                        : 'Next',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MultipleChoiceQuizResultsPage extends StatelessWidget {
  final int? correctAnswers;
  final int? incorrectAnswers;
  final List<String> questions;
  final List<List<String>> choices;
  final List<int> answers;

  MultipleChoiceQuizResultsPage({
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.questions,
    required this.choices,
    required this.answers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Results'),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: DrawerWidget(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Quiz Results:',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Correct Answers: $correctAnswers',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Incorrect Answer $incorrectAnswers',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text('Back to Home'),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          questions[index],
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Correct Answer: ${choices[index][answers[index]]}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Your Answer: ',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Quiz App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
          ),
          ListTile(
            title: Text('True/False Questions'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TrueFalseQuizPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Multiple Choice Questions'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MultipleChoiceQuizPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
