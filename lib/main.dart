import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.white,
                  Colors.lightBlue.shade50,
                ]
              )
            ),
          ),
        ),
        body: const CalculatorPage(),
      ),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _input = '0';
  String _calculation = '';

  void _onButtonPressed(String buttonText) {
    setState(() {
      // Your calculator logic here
      if (buttonText == "C") {
        _input = '0';
        _calculation ='';
        debugPrint(buttonText); // Added semicolon here
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.lightBlue.shade50,
                Colors.lightBlueAccent.shade100,
                Colors.blueAccent.shade100,
              ]
            )
          ),
        ),

        // Background with custom painter
        Positioned.fill(
          child: CustomPaint(
            painter: RoundPainter(Colors.blue),
          ),
        ),

        // Calculator interface
        Column(
          children: [
            // Display area
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _calculation,
                    style: TextStyle(fontSize: 24, color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      _input,
                      style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.right,
                    ),
                  )
                ],
              ),
            ),
            Spacer(),

            // Calculator buttons
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: GridView.count(
                padding: const EdgeInsets.all(10),
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: 4,
                children: [
                  // Add your button widgets here
                  _buildButton('7'),
                  _buildButton('8'),
                  _buildButton('9'),
                  _buildButton('÷'),
                  _buildButton('4'),
                  _buildButton('5'),
                  _buildButton('6'),
                  _buildButton('×'),
                  _buildButton('1'),
                  _buildButton('2'),
                  _buildButton('3'),
                  _buildButton('-'),
                  _buildButton('C'),
                  _buildButton('0'),
                  _buildButton('='),
                  _buildButton('+'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildButton(String text) {
    return TextButton(
      onPressed: () => _onButtonPressed(text),
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),// Add a background color
      ),
      child: Text(text,
        style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w500,
            color: Colors.white,
        ),
      ),
    );
  }
}

class RoundPainter extends CustomPainter {
  final Color color;

  RoundPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    // Create a gradient paint
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.lightBlueAccent.shade100,
          Colors.cyan.shade100,  // Light blue at the top
          Colors.cyan.shade100,  // Light blue at the top
          Colors.indigoAccent.shade100,  // Dark blue at the bottom
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    // Define the rectangle area
    final double topPadding = 300.0;
    final rect = RRect.fromLTRBR(
        0,
        topPadding,
        size.width,
        size.height,
        Radius.circular(20)
    );

    // Draw the rounded rectangle
    canvas.drawRRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}