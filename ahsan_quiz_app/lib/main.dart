import 'package:flutter/material.dart';
import 'multiple_choice_quiz_page.dart';
import 'true_false_quiz_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ahsan Quiz App',
      debugShowCheckedModeBanner: false,
      home: QuizHomePage(),
    );
  }
}

class QuizHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ahsan Quiz App'),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('True/False Questions'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => TrueFalseQuizPage()));
              },
            ),
            ListTile(
              title: Text('Multiple Choice Questions'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => MultipleChoiceQuizPage()));
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img1.jpg'), // Set background image here
            fit: BoxFit.cover,
          ),
        ),// Set background color here

      ), // Set background color here
    );
  }
}
