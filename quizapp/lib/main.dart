import 'package:flutter/material.dart';
import 'package:quizapp_sec_b/quiz_brain.dart';

void main() {
  runApp(MyApp());
}

QuizBrain obj = QuizBrain();


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: QuizPage(),
        ),
      ),
    ),);
  }
}


class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  List<Icon> scoreKeeper = [];

  void fun() {
    scoreKeeper.add(Icon(Icons.ac_unit, color: Colors.white,),);
  }

  void CheckAnswer(bool userPicker) {
    setState(() {
      bool? correctAnswer = obj.getCorrectAnswer();
      if(obj.isFinished()==true){

        obj.reset();
        scoreKeeper = [];
      }

      if (userPicker == correctAnswer) {
        print("Correct answer");
        scoreKeeper.add(Icon(Icons.check, color: Colors.white,));

      }
      else{
        scoreKeeper.add(Icon(Icons.credit_card_off, color: Colors.white,));
      }

      obj.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                //quizBrain.getQuestionText(),
                //getQuestion!,
                obj.getQuestionText().toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.amber,
              ),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                CheckAnswer(true);

                // getQuestion = quizBrain.getQuestionText();
                // //The user picked true.
                // checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                print("Clcikec False");
                CheckAnswer(false);
              },
            ),
          ),
        ),
        Row(children: scoreKeeper)

      ],);
  }
}
