import 'package:change/screen3.dart';
import 'package:flutter/material.dart';
import 'package:change/screen3.dart';

class Screen2 extends StatefulWidget {
  const Screen2(
      {super.key, required this.end, required this.start, required this.table});
  final int table, start, end;

  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    int length = widget.end - widget.start;
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(title: Text('Tabel of ${widget.table}')),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 200,
              height: MediaQuery.of(context).size.height * 0.75,
              child: ListView.builder(
                  itemCount: length + 1,
                  itemBuilder: (context, index) {
                    return Text(
                      '${widget.table}   * ${widget.start + index} = ${widget.table * (widget.start + index)} ',
                      style:
                      const TextStyle(color: Colors.black, fontSize: 20),
                    );
                  }),
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Screen3(
                              table: widget.table,
                              start: widget.start,
                              end: widget.end,
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
