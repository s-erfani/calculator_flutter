import 'package:flutter/material.dart';

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String result = "0";
  String a = "";
  String b = "";
  int opCounter = 0;

  void calculate() {
    print("a: $a");
    print("b: $b");
    print("result: $result");
    try {
      opCounter = 0;
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
        opCounter = 0;
      }
      if (symbol == "CE" || symbol == "C") {
        result = "0";
        a = "";
        b = "";
        opCounter = 0;
      } else if (symbol == "del") {
        if (result == "") {
          result = "0";
        }
      } else if (symbol == "+" ||
          symbol == "-" ||
          symbol == "*" ||
          symbol == "/") {
        if (result.endsWith("+") ||
            result.endsWith("-") ||
            result.endsWith("/") ||
            result.endsWith("*")) {
          result = result.substring(0, result.length - 1);
          a = result;
          result += symbol;
        } else {
          if (opCounter == 0) {
            opCounter++;
            a = result;
            result += symbol;
          } else {
            calculate();
            opCounter++;
            result += symbol;
          }
        }
      } else if (symbol == "=") {
        calculate();
      } else if (symbol == ".") {
        if (!a.contains(".") && opCounter == 0) {
          result += symbol;
          a += symbol;
        }
        if (!b.contains(".") && opCounter == 1 && b != "") {
          result += symbol;
          b += symbol;
        }
      } else if (symbol == "+/-") {
        // TODO
      } else if (symbol == "0" ||
          symbol == "1" ||
          symbol == "2" ||
          symbol == "3" ||
          symbol == "4" ||
          symbol == "5" ||
          symbol == "6" ||
          symbol == "7" ||
          symbol == "8" ||
          symbol == "9") {
        if (result.contains("+") ||
            result.contains("/") ||
            result.contains("-") ||
            result.contains("*")) {
          b = b + symbol;
          result += symbol;
        } else {
          if (result == "0") {
            result = symbol;
            a = result;
          } else {
            result = result + symbol;
            a = result;
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
