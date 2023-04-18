import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Ahsan Xylophone'),
        ),
        body: Xylo(),
      ),
    );
  }
}

class Xylo extends StatefulWidget {
  const Xylo({Key? key}) : super(key: key);

  @override
  State<Xylo> createState() => _XyloState();
}

class _XyloState extends State<Xylo> {
  int _numBars = 7;
  List<Color> _barColors = List.filled(7, Colors.purple);

  void playSound(int num) {
    AssetsAudioPlayer.newPlayer()
        .open(Audio('assets/audio/assets_note$num.wav'));
  }

  Expanded createNewButton(int sound, Color color) {
    return Expanded(
      child: Container(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                playSound(sound);
              },
              child: Text(
                'Button',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                _showAudioPickerDialog(sound);
              },
              child: Text(
                'Choose Audio',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAudioPickerDialog(int sound) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick an audio file!'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton(
                  onPressed: () {
                    _pickAudioFile(sound, 'assets/audio/assets_note1.wav');
                  },
                  child: Text('Note 1'),
                ),
                TextButton(
                  onPressed: () {
                    _pickAudioFile(sound, 'assets/audio/assets_note2.wav');
                  },
                  child: Text('Note 2'),
                ),
                // Add more audio options as needed
              ],
            ),
          ),
        );
      },
    );
  }

  void _pickAudioFile(int sound, String path) {
    AssetsAudioPlayer.newPlayer().open(Audio(path));
  }

  List<Expanded> createBarButtons() {
    List<Expanded> buttons = [];
    for (int i = 1; i <= _numBars; i++) {
      buttons.add(createNewButton(i, _barColors[i - 1]));
    }
    return buttons;
  }

  void changeBarColor(int index, Color color) {
    setState(() {
      _barColors[index] = color;
    });
  }

  void _showColorPickerDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _barColors[index],
              onColorChanged: (Color color) {
                changeBarColor(index, color);
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
        );
      },
    );
  }

  Widget buildNumBarsSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('Number of Bars: '),
        DropdownButton<int>(
          value: _numBars,
          onChanged: (int? value) {
            setState(() {
              _numBars = value!;
            });
          },
          items: [
            DropdownMenuItem<int>(
              value: 1,
              child: Text('1'),
            ),
            DropdownMenuItem<int>(
              value: 2,
              child: Text('2'),
            ),
            DropdownMenuItem<int>(
              value: 3,
              child: Text('3'),
            ),
            DropdownMenuItem<int>(
              value: 4,
              child: Text('4'),
            ),
            DropdownMenuItem<int>(
              value: 5,
              child: Text('5'),
            ),
            DropdownMenuItem<int>(
              value: 6,
              child: Text('6'),
            ),
            DropdownMenuItem<int>(
              value: 7,
              child: Text('7'),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildNumBarsSelector(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Bar Colors: '),
            ...List.generate(
              _numBars,
                  (index) => GestureDetector(
                onTap: () {
                  _showColorPickerDialog(index);
                },
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  margin: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: _barColors[index],
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        ...createBarButtons(),
      ],
    );
  }
}
