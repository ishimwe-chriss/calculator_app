import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'login.dart'; // Import your login screen
import 'sign_up.dart'; // Import your signup screen

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const CalculatorAppHome(),
        '/login': (context) =>  Login(), // Define your Login screen here
        '/signup': (context) =>  Signup(), // Define your Signup screen here
        '/calculator': (context) => const CalculatorAppHome(),
      },
    );
  }
}

class CalculatorAppHome extends StatefulWidget {
  const CalculatorAppHome({super.key});

  @override
  State<CalculatorAppHome> createState() => _CalculatorAppHomeState();
}

class _CalculatorAppHomeState extends State<CalculatorAppHome> {
  String equation = '0';
  String result = '0';
  String expression = '';
  int _selectedIndex = 2; // Set default to Calculator

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Add your navigation logic here
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/login');
        break;
      case 1:
        Navigator.pushNamed(context, '/signup');
        break;
      case 2:
        Navigator.pushNamed(context, '/calculator');
        break;
    }
  }

  void pressButton(String btnText) {
    setState(() {
      if (btnText == 'AC') {
        equation = '0';
        result = '0';
      } else if (btnText == ' ⌫') {
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '0';
        }
      } else if (btnText == '=') {
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = 'Error';
        }
      } else {
        if (equation == '0') {
          equation = btnText;
        } else {
          equation = equation + btnText;
        }
      }
    });
  }

  Widget calButtons(String btnText, Color txtColor, double btnWidth, Color btnColor) {
    return InkWell(
      onTap: () {
        pressButton(btnText);
      },
      child: Container(
        alignment: Alignment.center,
        height: 65,
        width: btnWidth,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          btnText,
          style: TextStyle(
            color: txtColor,
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent[100],
        title: const Text(
          'Calculator',
          style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.normal),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerRight,
            height: 90,
            width: double.infinity,
            color: Colors.black,
            child: Text(
              equation,
              style: TextStyle(color: Colors.deepOrangeAccent[100], fontSize: 38),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerRight,
            height: 90,
            width: double.infinity,
            color: Colors.black,
            child: Text(
              result,
              style: const TextStyle(color: Colors.white, fontSize: 60),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calButtons('AC', Colors.white, 80, Colors.deepOrangeAccent[100]!),
                    calButtons(' ⌫', Colors.white, 80, Colors.white38),
                    calButtons('%', Colors.white, 80, Colors.white38),
                    calButtons('÷', Colors.white, 80, Colors.deepOrangeAccent[100]!),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calButtons('7', Colors.white, 80, Colors.white10),
                    calButtons('8', Colors.white, 80, Colors.white10),
                    calButtons('9', Colors.white, 80, Colors.white10),
                    calButtons('×', Colors.white, 80, Colors.deepOrangeAccent[100]!),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calButtons('4', Colors.white, 80, Colors.white10),
                    calButtons('5', Colors.white, 80, Colors.white10),
                    calButtons('6', Colors.white, 80, Colors.white10),
                    calButtons('-', Colors.white, 80, Colors.deepOrangeAccent[100]!),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calButtons('1', Colors.white, 80, Colors.white10),
                    calButtons('2', Colors.white, 80, Colors.white10),
                    calButtons('3', Colors.white, 80, Colors.white10),
                    calButtons('+', Colors.white, 80, Colors.deepOrangeAccent[100]!),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calButtons('0', Colors.white, 170, Colors.white10),
                    calButtons('.', Colors.white, 80, Colors.white10),
                    calButtons('=', Colors.white, 80, Colors.deepOrangeAccent[100]!),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: 'Sign up',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepOrangeAccent[100],
        onTap: _onItemTapped,
      ),
    );
  }
}
