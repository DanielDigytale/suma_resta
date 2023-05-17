import 'package:flutter/material.dart';
//import 'dart:math';

class OperationPage extends StatefulWidget {
  OperationPage({
    super.key,
    required this.title,
    required this.operationHeight,
    required this.operation,
    required this.operator1,
    required this.operator2,
  });

  final String title;
  final int operationHeight;
  final String operation;
  final int operator1;
  final int operator2;

  @override
  State<OperationPage> createState() => _OperationPageState();
}

class _OperationPageState extends State<OperationPage> {
  int _positionInResult = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('${widget.title} ${widget.operation}')),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/backgroundNumbers.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        //color: Colors.black54,
        child: Center(
          child: Column( // two containers and a button to test the result
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container( // first container - operation
                padding: EdgeInsets.all(10.0),
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _rowOperator(operatorPosition: 1), // operator1
                    _rowOperation(), // operation sign
                    _rowOperator(operatorPosition: 2), // operator2
                    Divider(
                      height: 30.0,
                      color: Colors.white,
                      thickness: 5.0,
                    ),
                    _rowResult(), // result
                  ],
                ),
              ),
              Container( // second container button with numbers.
                decoration: BoxDecoration(
                  color: Colors.blueGrey[700],
                  borderRadius: BorderRadius.circular(32),
                ),
                height: 300,
                width: 300,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _rowNumber(rowNumber: 1), // numbers 1 2 3
                      _rowNumber(rowNumber: 2), // numbers 4 5 6
                      _rowNumber(rowNumber: 3), // numbers 7 8 9
                      Row(                      // number    0
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buttonNumber(number: 0),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              _resultButton(),
            ],
          ),
        ),
      ),
    );
  } // build



  Widget _rowOperator({required int operatorPosition}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          (operatorPosition == 1) ? '${widget.operator1}' : '${widget.operator2}',
          style: TextStyle(fontSize: 50, color: Colors.white),
        ),
        Text(
          '     ',
          style: TextStyle(
            fontSize: 50,
          ),
        ),
      ],
    );
  }

  Widget _rowOperation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          widget.operation,
          style: TextStyle(fontSize: 60, color: Colors.white),
        ),
      ],
    );
  }

  Widget _resultPosition({required int position, int valuePosition=0}) {
    return Text(
      '$valuePosition',
      style: TextStyle(
        fontSize: 50,
        color: Colors.white,
        backgroundColor: (_positionInResult == position)
            ?Colors.orange
            :Colors.blue,
      ),
    );
  }

  Widget _rowResult() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _resultPosition(position: 5),
        _resultPosition(position: 4),
        _resultPosition(position: 3),
        _resultPosition(position: 3),
        _resultPosition(position: 1),
        Text(
          '    ',
          style: TextStyle(fontSize: 50, color: Colors.white),
        ),
      ],
    );
  }

  void _buttonPressed({required int number}){
    setState(() {
      _resultPosition(position: _positionInResult, valuePosition: number);
      _positionInResult = _positionInResult+1;
    });
  }

  Widget _buttonNumber({required int number}){
    return ElevatedButton(
      onPressed: () => _buttonPressed(number: number),
      child: Text(
        '$number',
        style:
        TextStyle(fontSize: 30, color: Colors.white,),
      ),
    );
  }
  
  Widget _rowNumber({required int rowNumber}) {
    var a=0;
    var b=0;
    var c=0;
    if (rowNumber==1){
      a = 1;
      b = 2;
      c = 3;
    } else if (rowNumber==2){
      a = 4;
      b = 5;
      c = 6;
    } else if (rowNumber==3){
      a = 7;
      b = 8;
      c = 9;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buttonNumber(number: a),
        _buttonNumber(number: b),
        _buttonNumber(number: c),
      ],
    );
  }

  /*int _constructorOperator({required int operatorPosition}) {
    if ((operatorPosition==1)&&(_operator1!=0)) return _operator1;
    if ((operatorPosition==2)&&(_operator2!=0)) return _operator2;

    int number = 0;
    if (operatorPosition == 1) {
      for (int i = 0; i < widget.operationHeight; i++) {
        if (i==(widget.operationHeight-1)){ // last digit has to be always [1..9]
          number = number + (Random().nextInt(9) * pow(10, i).toInt()+1);
        } else {
          number = number + (Random().nextInt(9) * pow(10, i).toInt());
        }
      } // for
    } else {
      // operatorPosition==2
      if (widget.operation == '+') {
        for (int i = 0; i < widget.operationHeight; i++) {
          number = number + (Random().nextInt(10) * pow(10, i).toInt());
        } // for
      } else {
        // operation=='-', operator2 must be less than operator1
        number = _operator1 - (Random().nextInt(_operator1));
      }
    } // if
    return number;
  }*/

  Widget _resultButton(){
    return ElevatedButton(
      onPressed: () => null,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.blue),
      ),
      child: Text(
        'comprobar resultado',
        style: TextStyle(fontSize: 30, color: Colors.white),
      ),
    );

  } // resultButton

} // _OperationPageState
