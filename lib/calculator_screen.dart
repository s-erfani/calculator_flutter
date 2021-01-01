import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String result = "0";
  String a = "";
  String b = "";

  onPress(String symbol) {
    setState(() {
      if (symbol == "CE" || symbol == "C") {
        result = "0";
        a = "";
        b = "";
      } else if (symbol == "del") {
        result = result.substring(0, result.length - 1);
        if (result == "") {
          result = "0";
        }
      } else if (symbol == "+" ||
          symbol == "-" ||
          symbol == "*" ||
          symbol == "/") {
        a = result;
        result += symbol;
      } else if (symbol == "=") {
        try {
          print(a);
          print(b);
          if (result.contains("+")) {
            result = (double.parse(a) + double.parse(b)).toString();
            a = result;
            b = "";
          } else if (result.contains("-")) {
            result = (double.parse(a) - double.parse(b)).toString();
            a = result;
            b = "";
          } else if (result.contains("*")) {
            result = (double.parse(a) * double.parse(b)).toString();
            a = result;
            b = "";
          } else if (result.contains("/")) {
            result = (double.parse(a) / double.parse(b)).toString();
            a = result;
            b = "";
          }
        } catch (e) {
          print(e);
        }
      } else if (symbol == ".") {
        b = b + symbol;
        result += symbol;
      } else if (symbol == "+/-") {
      } else {
        if (result.contains("+") ||
            result.contains("/") ||
            result.contains("-") ||
            result.contains("*")) {
          b = b + symbol;
          result += symbol;
        } else {
          if (result == "0") {
            result = symbol;
          } else {
            result = result + symbol;
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 64),
            Container(
              height: 64,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      result,
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                children: [
                  calculatorButton("CE"),
                  calculatorButton("C"),
                  calculatorButton("del"),
                  calculatorButton("/"),
                  calculatorButton("7"),
                  calculatorButton("8"),
                  calculatorButton("9"),
                  calculatorButton("*"),
                  calculatorButton("4"),
                  calculatorButton("5"),
                  calculatorButton("6"),
                  calculatorButton("-"),
                  calculatorButton("1"),
                  calculatorButton("2"),
                  calculatorButton("3"),
                  calculatorButton("+"),
                  calculatorButton("+/-"),
                  calculatorButton("0"),
                  calculatorButton("."),
                  calculatorButton("="),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget calculatorButton(String symbol) {
    return FlatButton(
        onPressed: () => onPress(symbol),
        child: Text(
          symbol,
          style: TextStyle(fontSize: 24),
        ));
  }
}
