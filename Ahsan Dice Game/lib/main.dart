import 'package:dicegame_Ahsan_003/dice_game.dart';

//import 'package:untitled3/three_dice.dart';
// import 'package:untitled3/custom_dice.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Counter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: DiceGame(),


    );
  }
}
