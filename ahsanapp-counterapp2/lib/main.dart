import 'package:flutter/material.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ahsan Counter',
      theme: ThemeData(primarySwatch: Colors.red),
      home: CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;
  int _currentCounterIndex = 0;
  List<int> _counters = [0, 0, 0];

  void _incrementCounter() {
    setState(() {
      _counter++;
      _counters[_currentCounterIndex]++;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Counter incremented'),
    ));
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
      _counters[_currentCounterIndex]--;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Counter decremented'),
    ));
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      _counters[_currentCounterIndex] = 0;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Counter reset'),
    ));
  }

  void _selectCounter(int index) {
    setState(() {
      _currentCounterIndex = index;
      _counter = _counters[_currentCounterIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ahsan developer Counter app'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Counter Value:',
                style: TextStyle(fontSize: 30),
              ),
              Text(
                '$_counter',
                style: TextStyle(fontSize: 40),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _decrementCounter,
                    child: Text('<--'),
                  ),
                  SizedBox(width: 30),
                  ElevatedButton(
                    onPressed: _incrementCounter,
                    child: Text('++>'),
                  ),
                ],
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: _resetCounter,
                child: const Icon(Icons.refresh_sharp),
                // child: Text('Reset'),
              ),
              SizedBox(height: 50),
              Text(
                'Select Counter:',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: 18),
              ToggleButtons(
                children: [
                  Text(' 1'),
                  Text('    2   '),
                  Text(' 3'),
                ],
                isSelected: [
                  _currentCounterIndex == 0,
                  _currentCounterIndex == 1,
                  _currentCounterIndex == 2,
                ],
                onPressed: _selectCounter,

              ),
            ],
          ),
        ),
      ),
    );
  }
}