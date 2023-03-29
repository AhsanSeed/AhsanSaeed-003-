import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}


class _MyAppState extends State<MyApp> {
  int _counter = 0;
  int _selectedCounterIndex = 0;
  List<int> _counters = [0, 0, 0];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Counter incremented by 1')));
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Counter decremented by 1')));
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  void _selectCounter(int index) {
    setState(() {
      _selectedCounterIndex = index;
      _counter = _counters[_selectedCounterIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ahsan Counter App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text('Ahsan Developer Counter App'),
        ),
        body: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Counter $_selectedCounterIndex: $_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _decrementCounter,
                    child: Text('decrementCounter'),
                  ),
                  SizedBox(width: 150),
                  ElevatedButton(
                    onPressed: _incrementCounter,
                    child: Text('incrementCounter'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < _counters.length; i++)
                    GestureDetector(
                      onTap: () => _selectCounter(i),
                      child: Container(
                        width: 60,
                        height: 50,
                        margin: EdgeInsets.all(60),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: _selectedCounterIndex == i
                              ? Colors.pink
                              : Colors.yellow,
                        ),
                        child: Center(
                          child: Text(
                            '${i + 1}',
                            style: TextStyle(
                                color: Colors.white, fontSize: 40),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _resetCounter,

                child: Text('Reset'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}