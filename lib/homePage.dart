import 'dart:math';

import 'package:flutter/material.dart';
import 'package:suma_resta/operationPage.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
} // Homepage

class _HomePageState extends State<HomePage> {
  String _operation = ''; // to store the type of the operation
  int _operationHeight = 0; // to store the lenght of the operators
  int _operator1 = 0; // to store the value of the operator1
  int _operator2 = 0; // to store the value of the operator2
  Color buttonColor = Colors.white;
  Color buttonColorSelected = Colors.orangeAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/backgroundNumbers.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              containerOperation(),
              containerLenghtOperation(),
              _continueButton(),
            ],
          ),
        ),
      ),
    );
  } // build

  // to generate an operator depending on the position and the operation
  void generateOperator({required int operatorPosition}) {
    int number = 0;

    for (int i = 0; i < _operationHeight; i++) {
      if (i == (_operationHeight - 1)) {
        // last digit has to be always [1..9]
        number = number + ((Random().nextInt(8) + 1) * pow(10, i).toInt());
      } else {
        number = number + (Random().nextInt(9) * pow(10, i).toInt());
      }
    }
    if (operatorPosition == 1) {
      // always ok
      _operator1 = number;
    } else {
      // operatorPosition==2
      if (_operation == '+') {
        // with sum, operator2 can be anything
        _operator2 = number;
      } else if (_operation == 'x') {
        // with multiplication operator2 has only 1 digit
        _operator2 = Random().nextInt(8) + 1;
      } else {
        // operator2 & subtract, second must be less than first
        if (_operator1 < number) {
          // never subtract to a smaller number
          _operator2 = _operator1;
          _operator1 = number;
        } else {
          // operator2 & subtract but number <= operator1 = correct
          _operator2 = number;
        }
      }
    }
  }

  // the button to continue to the next page (operationPage) only if all is ok.
  Widget _continueButton() {
    return ElevatedButton(
      onPressed: () {
        if ((_operationHeight != 0) &&
            ((_operation == '+') ||
                (_operation == '-') ||
                (_operation == 'x'))) {
          generateOperator(operatorPosition: 1);
          generateOperator(operatorPosition: 2);
          // go to operationPage sending all the information settled
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OperationPage(
                        title: 'Operación',
                        operationHeight: _operationHeight,
                        operation: _operation,
                        operator1: _operator1,
                        operator2: _operator2,
                      ))); // push
        }
      }, // onPressed
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.blue),
      ),
      child: Text(
        'continuar',
        style: TextStyle(
          fontSize: 60.0,
          color: buttonColor,
        ),
      ),
    );
  } // continueButton

  // the button to select the corresponding operation set in the parameter
  Widget _operationButton({required String operation}) {
    return TextButton(
      onPressed: () => _setOperation(operation: operation),
      child: Text(
        operation,
        style: TextStyle(
          fontSize: 100.0,
          color: (_operation == operation) ? buttonColorSelected : buttonColor,
        ),
      ),
    );
  } // _operationButton

  // to store the operation in _operation depending on the parameter
  void _setOperation({required String operation}) {
    setState(() {
      if (operation == _operation) {
        // deselect operation.
        _operation = ' ';
      } else {
        // select an operation
        if (operation == '+') {
          _operation = '+';
        } else if (operation == '-') {
          _operation = '-';
        } else {
          _operation = 'x';
        }
      }
    });
  } // _setOperation

  // to store the lenght of the operatos acording to the parameter
  void _setOperationHeight({required int number}) {
    setState(() {
      if (_operationHeight == number) {
        // deselect lenght
        _operationHeight = 0;
      } else {
        // select lenght
        _operationHeight = number;
      }
    });
  } // _setOperationHeight

  // the button to select the corresponding lenght set in the parameter
  Widget _widthOperatorButton({required int number}) {
    return TextButton(
      onPressed: () => _setOperationHeight(number: number),
      child: Text(
        '$number',
        style: TextStyle(
          fontSize: 100.0,
          color:
              (_operationHeight == number) ? buttonColorSelected : buttonColor,
        ),
      ),
    );
  } // widhOperatorButton

  Widget containerOperation(){
  return (Container(
    decoration: BoxDecoration(
      color: Colors.blueGrey,
      borderRadius: BorderRadius.circular(32),
    ),
    height: 300,
    width: 300,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Elige la operación:',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _operationButton(operation: '+'),
            _operationButton(operation: '-'),
            _operationButton(operation: 'x'),
          ],
        ),
      ],
    ),
  )
  );
}

  Widget containerLenghtOperation(){
    return(Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey[700],
        borderRadius: BorderRadius.circular(32),
      ),
      height: 300,
      width: 300,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Elige el tamaño de los números:',
              style: TextStyle(fontSize: 30, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _widthOperatorButton(number: 2),
                _widthOperatorButton(number: 3),
                _widthOperatorButton(number: 4),
                _widthOperatorButton(number: 5),
              ],
            ),
          ],
        ),
      ),
    )

    );
  }

} // HomePageState
