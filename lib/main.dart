import 'package:flutter/material.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0";

  void _onButtonPressed(String text) {
    setState(() {
      if (text == "C") {
        _output = "0";
      } else if (text == "=") {
        _output = evalExpression(_output);
      } else {
        _output = _output == "0" ? text : _output + text;
      }
    });
  }

  String evalExpression(String expression) {
    try {
      double result = eval(expression);
      return result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 2);
    } catch (e) {
      return "Error";
    }
  }

  double eval(String expression) {
    try {
      return double.parse(expression);
    } catch (e) {
      // Handle any errors that occur while parsing the string
      print("Error parsing string to double: $e");
      return 0.0;
    }
  }

  Widget buildButton(String text) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _onButtonPressed(text),
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Calculator'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                color: Colors.white,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    _output,
                    style: TextStyle(fontSize: 48),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                buildButton("7"),
                buildButton("8"),
                buildButton("9"),
                buildButton("/"),
              ],
            ),
            Row(
              children: [
                buildButton("4"),
                buildButton("5"),
                buildButton("6"),
                buildButton("*"),
              ],
            ),
            Row(
              children: [
                buildButton("1"),
                buildButton("2"),
                buildButton("3"),
                buildButton("-"),
              ],
            ),
            Row(
              children: [
                buildButton("0"),
                buildButton("."),
                buildButton("C"),
                buildButton("+"),
              ],
            ),
            ElevatedButton(
              onPressed: () => _onButtonPressed("="),
              child: Text(
                "=",
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
