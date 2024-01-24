import 'package:flutter/material.dart';


import 'dart:math';
import 'package:flutter_icons/flutter_icons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: SplashScreen(),

    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a delay before navigating to the next screen

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(
          'Spin Bottle game',
          style: TextStyle(fontSize: 25, color: Colors.red, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.greenAccent,
        leading: Container(), // Remove the back button
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Spin Bottle Game',
              style: TextStyle(fontSize: 24,color: Colors.teal,fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.teal, // Set the desired button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0), // Adjust the value as needed
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FirstPage()),
                );
              },
              child: Text(
                'Lets Start',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }
}










class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  double _sliderValue = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spin Bottle Game'),
        backgroundColor: Colors.greenAccent, // Set app bar color to purple
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Number of Players',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.greenAccent, // Set text color to purple
              ),
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.greenAccent, // Set active track color to teal
                inactiveTrackColor: Colors.greenAccent, // Set inactive track color to greenAccent
                thumbColor: Colors.white, // Set thumb color to white
              ),
              child: Column(
                children: [
                  Text(
                    'Players: ${_sliderValue.toInt()}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Slider(
                    value: _sliderValue,
                    min: 2,
                    max: 10,
                    divisions: 9,
                    onChanged: (newValue) {
                      setState(() {
                        _sliderValue = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.greenAccent, // Set button background color to purple
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0), // Adjust the value as needed
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottleGamePage(_sliderValue),
                  ),
                );
              },
              child: Text(
                'Next',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottleGamePage extends StatefulWidget {
  final double sliderValue;

  BottleGamePage(this.sliderValue);

  @override
  _BottleGamePageState createState() => _BottleGamePageState();
}

class _BottleGamePageState extends State<BottleGamePage> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  bool _isRotating = false;
  int _winnerNumber = 1;
  double _arrowRotation = 0.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 5), // Increase the duration for smoother animation
      vsync: this,
    )..addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startGame() {
    if (_isRotating) return;

    final random = Random();
    final randomWinner = random.nextInt(widget.sliderValue.toInt()) + 1;

    _animationController.reset();
    _animationController.forward(from: 0.0);
    _isRotating = true;

    Future.delayed(_animationController.duration, () { // Wait for the animation to complete
      setState(() {
        _isRotating = false;
        _winnerNumber = randomWinner;

        // Calculate rotation angle for the arrow to point to the winner
        final angleIncrement = 2 * pi / widget.sliderValue;
        _arrowRotation = -pi / 2 + angleIncrement * (_winnerNumber - 1);
      });
    });
  }

  void _rotateForward() {
    if (_isRotating) return;
    setState(() {
      _arrowRotation -= 2 * pi / widget.sliderValue;
    });
  }

  void _rotateBackward() {
    if (_isRotating) return;
    setState(() {
      _arrowRotation += 2 * pi / widget.sliderValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text('Spin Bottle Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(height: 20),
            AnimatedBuilder(
              animation: _animationController,
              builder: (BuildContext context, Widget child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      painter: ClockPainter(
                        playerCount: widget.sliderValue.toInt(),
                        winnerNumber: _winnerNumber,
                      ),
                      child: Container(
                        width: 200,
                        height: 200,
                      ),
                    ),
                    Transform.rotate(
                      angle: _arrowRotation + _animationController.value * 2.0 * pi,
                      child: Icon(
                        Icons.arrow_forward,
                        size: 60,
                        color: Colors.greenAccent,
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startGame,
              style: ElevatedButton.styleFrom(
                  primary: Colors.greenAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  )
              ),
              child: Text('Lets Start Game'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _rotateBackward,
                  icon: Icon(Icons.rotate_left),
                ),
                IconButton(
                  onPressed: _rotateForward,
                  icon: Icon(Icons.rotate_right),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Winner: Player $_winnerNumber',
              style: TextStyle(
                color: Colors.red,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  final int playerCount;
  final int winnerNumber;

  ClockPainter({this.playerCount, this.winnerNumber});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final textStyle = TextStyle(fontSize: 16, color: Colors.black);

    final double angle = 2 * pi / playerCount;
    double startAngle = -pi / 2;

    for (int i = 1; i <= playerCount; i++) {
      final double x = center.dx + radius * cos(startAngle);
      final double y = center.dy + radius * sin(startAngle);

      final playerNumber = 'Player $i';

      final textSpan = TextSpan(
        text: playerNumber,
        style: TextStyle(
          color: i == winnerNumber ? Colors.red : Colors.green,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      );

      final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();
      textPainter.paint(canvas, Offset(x - textPainter.width / 2, y - textPainter.height / 2));

      startAngle += angle;
    }
  }

  @override
  bool shouldRepaint(ClockPainter oldDelegate) {
    return oldDelegate.playerCount != playerCount || oldDelegate.winnerNumber != winnerNumber;
  }
}


