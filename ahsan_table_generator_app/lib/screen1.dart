import 'package:flutter/material.dart';
import 'package:ahsan_table_generator_app/screen2.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  TextEditingController _tableController = TextEditingController();
  TextEditingController _startController = TextEditingController();
  TextEditingController _endController = TextEditingController();

  int _table = 0, start = 0, end = 0;

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
              'Select Table Number:  $_table',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: _table.toDouble(),
              min: 0,
              max: 100,
              onChanged: (double value) {
                setState(() {
                  _table = value.toInt();
                });
              },
            ),
            Text(
              'Select starting point:  $start',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: start.toDouble(),
              min: 0,
              max: 100,
              onChanged: (double value) {
                setState(() {
                  start = value.toInt();
                });
              },
            ),
            Text(
              'Select ending point:  $end',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: end.toDouble(),
              min: 0,
              max: 100,
              onChanged: (double value) {
                setState(() {
                  end = value.toInt();
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
                            )));
                  },
                  child: const Text(
                    'Generate Table',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
