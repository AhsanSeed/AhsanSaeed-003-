import 'dart:async';
import 'multiple_choice_quiz_page.dart';
import 'package:flutter/material.dart';

class TrueFalseQuizPage extends StatefulWidget {
  @override
  _TrueFalseQuizPageState createState() => _TrueFalseQuizPageState();
}

class _TrueFalseQuizPageState extends State<TrueFalseQuizPage> {
  static List<String> questions = [
    'Flutter is a mobile app SDK for building high-performance, high-fidelity, apps for iOS and Android, from a single codebase.',
    'Flutter is a programming language.',
    'Flutter was developed by Facebook.',
    'Flutter was released in 2017.',
    'Flutter is an open-source project.'
  ];

  static List<bool> answers = [true, false, false, true, true];

  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  int incorrectAnswers = 0;
  bool answered = false;
  bool timeUp = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer(Duration(seconds: 10), () {
      setState(() {
        timeUp = true;
        checkAnswer(false);
      });
    });
  }

  void checkAnswer(bool userAnswer) {
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
      currentQuestionIndex++;
      answered = false;
      timeUp = false;
      startTimer();
    });
  }

  void previousQuestion() {
    setState(() {
      currentQuestionIndex--;
      answered = false;
      timeUp = false;
      startTimer();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('True/False Questions'),
        backgroundColor: Colors.blueAccent,
      ),
      body:
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img2.jpg'), // Set background image here
            fit: BoxFit.cover,
          ),
        ),// Padding
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              questions[currentQuestionIndex],
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              timeUp ? 'Time is up!' : '',
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  child: Text('True'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black54, // Change "grey" to the color you want
                  ),
                  onPressed: answered ? null : () => checkAnswer(true),
                ),
                ElevatedButton(
                  child: Text('False'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black54, // Change "grey" to the color you want
                  ),
                  onPressed: answered ? null : () => checkAnswer(false),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  child: Text('Back'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Change "grey" to the color you want
                  ),
                  onPressed: currentQuestionIndex == 0
                      ? null
                      : () => previousQuestion(),
                ),
                ElevatedButton(
                  child: Text('Next'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Change "grey" to the color you want
                  ),
                  onPressed: currentQuestionIndex == questions.length - 1
                      ? null
                      : () => nextQuestion(),
                )

              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.check),

        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TrueFalseResultPage(correctAnswers, incorrectAnswers)));
        },
      ),
    );
  }
}

class TrueFalseResultPage extends StatelessWidget {
  final int correctAnswers;
  final int incorrectAnswers;

  TrueFalseResultPage(this.correctAnswers, this.incorrectAnswers);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Results'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You got $correctAnswers out of ${correctAnswers + incorrectAnswers} questions right!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              child: Text('View Answers'),
              style: ElevatedButton.styleFrom(
                primary: Colors.redAccent, // Change "blue" to the color you want
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TrueFalseAnswersPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TrueFalseAnswersPage extends StatelessWidget {
  List<String> questionss = _TrueFalseQuizPageState.questions;
  List<bool> answerss = _TrueFalseQuizPageState.answers;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Answers'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Answers:',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: questionss.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      '${index + 1}. ${questionss[index]}: ${answerss[index] ? "True" : "False"}',
                      style: TextStyle(fontSize: 18.0),
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
