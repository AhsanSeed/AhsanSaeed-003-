import 'package:flutter/material.dart';
import 'play.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hangman',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        hintColor: Colors.red,
        fontFamily: 'Pangolin',
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.white10,
          behavior: SnackBarBehavior.floating,
          contentTextStyle: TextStyle(
            fontFamily: 'Pangolin',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  int _hangmanImageIndex = 0;
  final List<String> _hangmanImagePaths = [
    'images/hangman0.png',
    'images/hangman1.png',
    'images/hangman2.png',
    'images/hangman3.png',
    'images/hangman4.png',
    'images/hangman5.png',
    'images/hangman6.png',
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );
    _startAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _animationController.forward().then((value) {
      setState(() {
        if (_hangmanImageIndex < _hangmanImagePaths.length - 1) {
          _hangmanImageIndex++;
          _animationController.reset();
          _startAnimation();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hangman"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Image.asset(
                      _hangmanImagePaths[_hangmanImageIndex],
                      height: 120,
                    );
                  },
                ),
              ),
              Text(
                'H_NG__N',
                style: TextStyle(fontSize: 48),
              ),
              Padding(
                padding: const EdgeInsets.all(48.0),
                child: GestureDetector(
                  child: Image.asset(
                    'images/play.png',
                    width: 80,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return Play();
                    }));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
