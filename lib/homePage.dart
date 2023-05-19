import 'package:flutter/material.dart';
import 'package:suma_resta/operationPage.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
} // Homepage

class _HomePageState extends State<HomePage> {
  String _operation = '';
  int _operationHeight = 0;
  int _operator1 = 0;
  int _operator2 = 0;
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
              Container(
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
              ),
              Container(
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
              ),
              _continueButton(),
            ],
          ),
        ),
      ),
    );
  } // build

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

  void _setOperationHeight({required int number}) {
    setState(() {
      if (_operationHeight==number){ // deselect height
        _operationHeight = 0;
      } else { // select height
        _operationHeight = number;
      }
    });
  } // _setOperationHeight

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

  Widget _continueButton(){
    return ElevatedButton(
      onPressed: () {
        if ((_operationHeight != 0) &&
            ((_operation == '+') || (_operation == '-') || (_operation=='x'))) {
          generateOperator(operatorPosition: 1);
          generateOperator(operatorPosition: 2);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OperationPage(
                    title: 'Operación',
                    operationHeight: _operationHeight,
                    operation: _operation,
                    operator1: _operator1,
                    operator2: _operator2,
                  )
              )
          ); // push
        }
      }, // onPressed
      style: ButtonStyle(
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

  generateOperator({required int operatorPosition}){
    int number = 0;

    for (int i = 0; i < _operationHeight; i++) {
      if (i==(_operationHeight-1)){ // last digit has to be always [1..9]
        number = number + ((Random().nextInt(8)+1) * pow(10, i).toInt());
      } else {
        number = number + (Random().nextInt(9) * pow(10, i).toInt());
      }
    }
    if (operatorPosition==1) { // always ok
      _operator1 = number;
    } else { // operatorPosition==2
      if (_operation=='+'){ // with sum, operator2 can be anything
        _operator2 = number;
      } else if (_operation=='x'){ // with multiplication operator2 has only 1 digit
        _operator2 = Random().nextInt(8) + 1 ;
      } else { // operator2 & subtract, second must be less than first
        if (_operator1 < number) { // never subtract to a smaller number
          _operator2 = _operator1;
          _operator1 = number;
        } else { // operator2 & subtract but number <= operator1 = correct
          _operator2 = number;
        }
      }
    }

}

} // HomePageState
