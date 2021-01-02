import 'package:flutter/material.dart';

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String result = "0";
  String a = "";
  String b = "";
  void calculate(String symbol) {
    print("a: $a");
    print("b: $b");
    print("result: $result");
    try {
      if (b != "") {
        if (result.contains("+")) {
          a = (double.parse(a) + double.parse(b)).toString();
        } else if (result.contains("*")) {
          a = (double.parse(a) * double.parse(b)).toString();
        } else if (result.contains("/")) {
          a = (double.parse(a) / double.parse(b)).toString();
        } else if (result.contains("-")) {
          a = (double.parse(a) - double.parse(b)).toString();
        }
        result = a.endsWith(".0") ? a.substring(0, a.length - 2) : a;
        b = "";
      }
    } catch (e) {
      result = "error";
      print(e);
    }
  }

  onPress(String symbol) {
    setState(() {
      if (result == "error") {
        result = "0";
        a = "";
        b = "";
      }
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
        // if ((result.contains("+") && !result.endsWith("+")) ||
        //     (result.contains("*") && !result.endsWith("*")) ||
        //     (result.contains("/") && !result.endsWith("/")) ||
        //     (result.contains("-") && !result.endsWith("-"))) {
        //   calculate();
        // }
        if (result.endsWith("+") ||
            result.endsWith("-") ||
            result.endsWith("/") ||
            result.endsWith("*")) {
          result = result.substring(0, result.length - 1);
          a = result;
          result += symbol;
        } else {
          a = result;
          result += symbol;
        }
      } else if (symbol == "=") {
        calculate(symbol);
      } else if (symbol == ".") {
        // TODO
      } else if (symbol == "+/-") {
        // TODO
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
              child: FittedBox(
                alignment: Alignment.centerRight,
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