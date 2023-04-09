import 'package:flutter/material.dart';

//TODO: Step 2 - Import the rFlutter_Alert package here.
import 'package:rflutter_alert/rflutter_alert.dart';

import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

String  ? getQuestion ;

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}
Alert(
context: context,
title: 'Finished!',
desc: 'You\'ve reached the end of the quiz.',
).show();

//TODO Step 4 Part C - reset the questionNumber,
quizBrain.reset();

//TODO Step 4 Part D - empty out the scoreKeeper.
scoreKeeper = [];
}

//TODO: Step 6 - If we've not reached the end, ELSE do the answer checking steps below 👇
else {
if (userPickedAnswer == correctAnswer) {
scoreKeeper.add(Icon(
Icons.check,
color: Colors.green,
));
} else {
scoreKeeper.add(Icon(
Icons.close,
color: Colors.white,
));
}
quizBrain.nextQuestion();
}
});
}
