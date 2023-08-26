import 'package:flutter/material.dart';

class Calcululator extends StatefulWidget {
  const Calcululator({Key? key}) : super(key: key);

  @override
  State<Calcululator> createState() => _CalcululatorState();
}

class _CalcululatorState extends State<Calcululator> {
  String disply = "";
  String process = "";
  String first = "";
  String second = "";
  String third = "";
  int cnt = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(children: [
          Expanded(
              flex: 15,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: Text("$process",
                      style:
                          TextStyle(fontSize: 25, fontStyle: FontStyle.italic)),
                ),
              )),
          Expanded(
              flex: 15,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: Text("$disply",
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
                ),
              )),
          Expanded(
            flex: 10,
            child: Row(
              children: [
                FunctionButton("AC"),
                FunctionButton("+/-"),
                FunctionButton("%"),
                FunctionButton("/", 0xffFF9500, 0xffFFFFFF)
              ],
            ),
          ),
          Expanded(
            flex: 10,
            child: Row(
              children: [
                NumaricButton("7"),
                NumaricButton("8"),
                NumaricButton("9"),
                FunctionButton("X", 0xffFF9500, 0xffFFFFFF)
              ],
            ),
          ),
          Expanded(
            flex: 10,
            child: Row(
              children: [
                NumaricButton("4"),
                NumaricButton("5"),
                NumaricButton("6"),
                FunctionButton("-", 0xffFF9500, 0xffFFFFFF)
              ],
            ),
          ),
          Expanded(
            flex: 10,
            child: Row(
              children: [
                NumaricButton("1"),
                NumaricButton("2"),
                NumaricButton("3"),
                FunctionButton("+", 0xffFF9500, 0xffFFFFFF)
              ],
            ),
          ),
          Expanded(
            flex: 10,
            child: Row(
              children: [
                NumaricButton("0"),
                NumaricButton("00"),
                FunctionButton("\.", 0xff505050, 0xffFFFFFF),
                FunctionButton("=", 0xffFF9500, 0xffFFFFFF)
              ],
            ),
          )
        ]),
      ),
    );
  }

  NumaricButton(String buttonname,
      [int backgroundcolor = 0xff505050, int textcolor = 0xffFFFFFF]) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            if (buttonname != "0") {
              if (disply == "0") {
                disply = "";
              }
              disply = disply + "$buttonname";
              process += buttonname;
            } else {
              disply = disply + "$buttonname";
              process += buttonname;
            }
          });
        },
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Color(backgroundcolor)),
          child: Center(
              child: Text(buttonname,
                  style: TextStyle(color: Color(textcolor), fontSize: 30))),
        ),
      ),
    ));
  }

  FunctionButton(String buttoname,
      [int backgroundcolor = 0xffD4D4D2, int textcolor = 0xff000000]) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: InkWell(
          onTap: () {
            setState(() {
              if (buttoname == "+") {
                process += buttoname;

                if (cnt == 0) {
                  first = disply;
                  disply = "";
                } else {
                  Run();
                }
                cnt = 1;
              } else if (buttoname == "-") {
                process += buttoname;
                if (cnt == 0) {
                  first = disply;
                  disply = "";
                } else {
                  Run();
                }
                cnt = 2;
              } else if (buttoname == "X") {
                process += buttoname;
                if (cnt == 0) {
                  first = disply;
                  disply = "";
                } else {
                  Run();
                }
                cnt = 3;
              } else if (buttoname == "/") {
                process += buttoname;
                if (cnt == 0) {
                  first = disply;
                  disply = "";
                } else {
                  Run();
                }
                cnt = 4;
              } else if (buttoname == "AC") {
                process = "";
                cnt = 0;
                disply = "";
              } else if (buttoname == "\.") {
                if (!disply.contains("\.")) {
                  process += buttoname;

                  disply = disply + buttoname;
                }
              } else if (buttoname == "+/-") {
                if (disply[0] != "-") {
                  disply = "-" + disply;
                } else {
                  disply = disply.substring(1);
                }

                if (process[0] != "-") {
                  process = "-" + process;
                }
              } else if (buttoname == "%") {
                process= process + buttoname;

                if (first == "") {
                  first = "1";
                }

                second = disply;

                if (cnt == 1) {
                  disply =
                      "${(double.parse(first)) + (double.parse(first) * double.parse(second) / 100)}";
                }

                if (cnt == 2) {
                  disply =
                      "${(double.parse(first)) - (double.parse(first) * double.parse(second) / 100)}";
                }

                if (cnt == 3) {
                  disply =
                      "${(double.parse(first) * double.parse(second) / 100)}";
                }

                if (cnt == 4) {
                  disply =
                      "${((double.parse(first)) / (double.parse(second) / 100))}";
                }
              } else if (buttoname == "=") {
                second = disply;

                if (cnt == 1) {
                  disply = "${double.parse(first) + double.parse(second)}";
                } else if (cnt == 2) {
                  disply = "${double.parse(first) - double.parse(second)}";
                } else if (cnt == 3) {
                  print("first::::$first");
                  print("second::::$second");
                  disply = "${double.parse(first) * double.parse(second)}";
                } else if (cnt == 4) {
                  disply = "${double.parse(first) / double.parse(second)}";
                }

                cnt = 0;
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Color(backgroundcolor)),
            child: Center(
                child: Text(buttoname,
                    style: TextStyle(color: Color(textcolor), fontSize: 30))),
          ),
        ),
      ),
    );
  }

  void Run() {
    if (cnt == 1) {
      second = disply;

      third = "${double.parse(first) + double.parse(second)}";
      first = third;
      disply = "";
    }

    if (cnt == 2) {
      second = disply;

      third = "${double.parse(first) - double.parse(second)}";
      first = third;
      disply = "";
    }

    if (cnt == 3) {
      print("disply=======$disply");

      second = disply;

      print("++++++first = $first");
      print("++++++second = $second");

      third = "${double.parse(first) * double.parse(second)}";

      first = third;

      disply = "";
    }

    if (cnt == 4) {
      second = disply;

      third = "${double.parse(first) / double.parse(second)}";

      first = third;

      disply = "";
    }
  }
}
