import 'package:change/screen2.dart';
import 'package:flutter/material.dart';
import 'package:change/screen2.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  TextEditingController _tableController = TextEditingController();
  TextEditingController _startController = TextEditingController();
  TextEditingController _endController = TextEditingController();

  int _table = 10, start = 4, end = 14;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
          title: const Text(
            'Table Generator App',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Table Number:',
              style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _tableController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _table = int.tryParse(value) ?? _table;
                });
              },
            ),
            Text(
              'Select starting point:',
              style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _startController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  start = int.tryParse(value) ?? start;
                });
              },
            ),
            Text(
              'Select ending point:',
              style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _endController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  end = int.tryParse(value) ?? end;
                });
              },
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Screen2(
                            table: _table,
                            start: start,
                            end: end,
                          )));// Generate Table logic goes here
                },
                child: const Text(
                  'Generate Table',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
