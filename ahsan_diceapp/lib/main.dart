import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(DiceApp());

class DiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dice App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: DiceAppHomePage(),
    );
  }
}

class DiceAppHomePage extends StatefulWidget {
  @override
  _DiceAppHomePageState createState() => _DiceAppHomePageState();
}

class _DiceAppHomePageState extends State<DiceAppHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dice App'),
        backgroundColor: Colors.purple,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              text: '1 Dice',
            ),
            Tab(
              text: 'Custom Dices',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SingleDice(),
          CustomDice(),
        ],
      ),
    );
  }
}

class SingleDice extends StatefulWidget {
  @override
  _SingleDiceState createState() => _SingleDiceState();
}

class _SingleDiceState extends State<SingleDice>
    with SingleTickerProviderStateMixin {
  int _diceNumber = 1;
  late AnimationController _controller;
  late Animation<double> _animation;
  double _height = 200;
  double _width = 200;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  void _rollDice() {
    setState(() {
      _diceNumber = Random().nextInt(6) + 1;
    });
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: _height,
            width: _width,
            child: RotationTransition(
              turns: _animation,
              child: Image.asset(
                'assets/dice$_diceNumber.png',
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text('Roll Dice'),
            onPressed: _rollDice,
          ),
        ],
      ),
    );
  }
}



class CustomDice extends StatefulWidget {
  @override
  _CustomDiceState createState() => _CustomDiceState();
}

class _CustomDiceState extends State<CustomDice>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _numDice = 1;
  List<int> _diceNumbers = [1];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _rollDice() {
    List<int> newDiceNumbers = [];
    for (int i = 0; i < _numDice; i++) {
      newDiceNumbers.add(Random().nextInt(6) + 1);
    }
    setState(() {
      _diceNumbers = newDiceNumbers;
    });
    _controller.reset();
    _controller.forward();
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
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (BuildContext context, Widget? child) {
                    return Transform.rotate(
                      angle: _animation.value * pi,
                      child: child,
                    );
                  },
                  child: Image.asset(
                    'assets/dice$number.png',
                    height: 200,
                    width: 200,
                  ),
                ),
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
