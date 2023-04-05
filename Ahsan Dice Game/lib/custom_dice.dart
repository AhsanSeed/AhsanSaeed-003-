import 'dart:math';
import 'package:flutter/material.dart';
class CustomDice extends StatefulWidget {
@override
_CustomDiceState createState() => _CustomDiceState();
}

class _CustomDiceState extends State<CustomDice> {
int _numDice = 1;
List<int> _diceNumbers = [1];

void _rollDice() {
List<int> newDiceNumbers = [];
for (int i = 0; i < _numDice; i++) {
newDiceNumbers.add(Random().nextInt(6) + 1);
}
setState(() {
_diceNumbers = newDiceNumbers;
});
}

void _updateNumDice(int value) {
setState(() {
_numDice = value;
_diceNumbers = List.generate(_numDice, (index) => 1);
});
}

@override
Widget build(BuildContext context) {
return Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Wrap(
alignment: WrapAlignment.center,
children: _diceNumbers
    .map(
(number) => Padding(
padding: EdgeInsets.all(10),
child: Image(image: AssetImage('pictures/$_diceNumbers.png')),
),
)
    .toList(),
),
SizedBox(height: 20),
Row(
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
children: [
DropdownButton<int>(
value: _numDice,
items: [1, 2, 3, 4, 5, 6]
    .map(
(value) => DropdownMenuItem<int>(
value: value,
child: Text('$value'),
),
)
    .toList(),
onChanged: (int? value) {
if (value != null) {
_updateNumDice(value);
}
},
),
ElevatedButton(
child: Text('Roll Dice'),
onPressed: _rollDice,
),
],
),
],
),
);
}
}