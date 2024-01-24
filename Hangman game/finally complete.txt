import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hm/result.dart';
import 'package:hm/game.dart';

class Play extends StatefulWidget {
  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> {
  late Game game;
  late AssetsAudioPlayer player;
  bool isLowerCase = false; // Added boolean variable to track letter case
  int selectedWordLength = 0; // Added variable to store the selected word length

  @override
  void initState() {
    super.initState();
    game = Game();
    player = AssetsAudioPlayer();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Play"),
        actions: [
          if (game.wrongLettersGuessed.length >= 3)
            _buildGuessWordWidget(context),
          IconButton(
            // Added IconButton for small letter button
            icon: Icon(Icons.text_format),
            onPressed: () {
              setState(() {
                isLowerCase = !isLowerCase;
              });
            },
          ),
          IconButton(
            // Added IconButton for word length selection
            icon: Icon(Icons.format_size),
            onPressed: () {
              _showWordLengthDialog(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView( // Added SingleChildScrollView to enable scrolling
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/dd.png'),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'images/hangman' +
                        game.wrongLettersGuessed.length.toString() +
                        '.png',
                    height: 120,
                  ),
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                isLowerCase ? game.displayWord.toLowerCase() : game.displayWord.toUpperCase(),
                style: TextStyle(fontSize: 48),
              ),
              SizedBox(
                height: 64.0,
              ),
              _getKeyPad(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getKeyPad() {
    List<List<String>> letters = [
      ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
      ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
      ['Z', 'X', 'C', 'V', 'B', 'N', 'M']
    ];
    if (isLowerCase) {
      // Convert letters to lowercase if isLowerCase is true
      letters = letters.map((row) => row.map((letter) => letter.toLowerCase()).toList()).toList();
    }
    return Column(
      children: <Widget>[
        _getRow(0, letters),
        SizedBox(
          height: 16.0,
        ),
        _getRow(1, letters),
        SizedBox(
          height: 16.0,
        ),
        _getRow(2, letters),
      ],
    );
  }

  Row _getRow(int rowIndex, List<List<String>> letters) {
    List<Widget> row = [];
    for (int i = 0; i < letters[rowIndex].length; i++) {
      row.add(_getLetterButton(letters[rowIndex][i]));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: row,
    );
  }

  Widget _getLetterButton(String letter) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Builder(
        builder: (BuildContext context) {
          return GestureDetector(
            child: Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              child: Text(
                letter,
                style: TextStyle(
                  color: _getLetterColor(letter),
                  fontSize: 24,
                ),
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.brown,
              ),
            ),
            onTap: () {
              if (game.displayWordList.contains(letter) ||
                  game.wrongLettersGuessed.contains(letter)) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Already Guessed",
                    textAlign: TextAlign.center,
                  ),
                  duration: Duration(seconds: 1),
                ));
              } else {
                _playSound(); // Play the sound
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    letter,
                    textAlign: TextAlign.center,
                  ),
                  duration: Duration(seconds: 1),
                ));
                setState(() {
                  game.guessLetter(letter);
                });
                if (game.isWordGuessed() || game.hasLost()) {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return Result.fromData(game);
                  }));
                }
              }
            },
          );
        },
      ),
    );
  }

  Color _getLetterColor(String letter) {
    if (game.displayWordList.contains(letter)) {
      return Colors.green;
    } else if (game.wrongLettersGuessed.contains(letter)) {
      return Colors.red;
    } else {
      return Colors.white;
    }
  }

  Widget _buildGuessWordWidget(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.lightbulb_outline, color: Colors.yellow),
      onPressed: () {
        _showGuessWordDialog(context);
      },
    );
  }

  void _showGuessWordDialog(BuildContext context) {
    // Show the dialog to allow the user to guess the word
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Guess Word"),
          content: Text(game.secretWord ?? ""),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Perform actions on submitting the guess
                Navigator.of(context).pop();
              },
              child: Text("Done"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _playSound() async {
    try {
      await player.open(Audio('images/Drop.mp3'));
    } catch (e) {
      print('images/Drop.mp3: $e');
    }
  }

  void _showWordLengthDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Word Length"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLengthButton(1),
              _buildLengthButton(2),
              _buildLengthButton(3),
              _buildLengthButton(4),
              _buildLengthButton(5),
              _buildLengthButton(6),
              _buildLengthButton(7),
              _buildLengthButton(8),
              _buildLengthButton(9),
              _buildLengthButton(10),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLengthButton(int length) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedWordLength = length;
        });
        Navigator.of(context).pop();
        _showWordWithLength(length);
      },
      child: Text(length.toString()),
      style: ElevatedButton.styleFrom(
        primary: selectedWordLength == length ? Colors.blue : null,
      ),
    );
  }

  void _showWordWithLength(int length) {
    List<String> wordsWithLength = game.displayWordWordsWithLength(length);
    String wordList = wordsWithLength.join(", ");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Words with Length $length"),
          content: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                wordList,
                textAlign: TextAlign.left,
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
