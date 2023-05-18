import 'package:flutter/material.dart';
import 'dart:math';

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
  int _positionInResult = 0;
    var listResult = [0,0,0,0,0,0];
    MaterialColor containerOperationColor = Colors.blueGrey;

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
                  color: containerOperationColor,
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
                      _rowNumber(rowNumber: 4), // number    0
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

  Widget _resultPosition({required int position,required int valuePosition}) {
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
    if (widget.operationHeight==2){
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _resultPosition(position: 2, valuePosition: listResult[2]),
          _resultPosition(position: 1, valuePosition: listResult[1]),
          _resultPosition(position: 0, valuePosition: listResult[0]),
          Text(
            '     ',
            style: TextStyle(fontSize: 50, color: Colors.white),
          ),
        ],
      );
    } else if (widget.operationHeight==3){
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _resultPosition(position: 3, valuePosition: listResult[3]),
          _resultPosition(position: 2, valuePosition: listResult[2]),
          _resultPosition(position: 1, valuePosition: listResult[1]),
          _resultPosition(position: 0, valuePosition: listResult[0]),
          Text(
            '     ',
            style: TextStyle(fontSize: 50, color: Colors.white),
          ),
        ],
      );
    } else if (widget.operationHeight==4){
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _resultPosition(position: 4, valuePosition: listResult[4]),
          _resultPosition(position: 3, valuePosition: listResult[3]),
          _resultPosition(position: 2, valuePosition: listResult[2]),
          _resultPosition(position: 1, valuePosition: listResult[1]),
          _resultPosition(position: 0, valuePosition: listResult[0]),
          Text(
            '     ',
            style: TextStyle(fontSize: 50, color: Colors.white),
          ),
        ],
      );
    } else { // operationHeight = 5
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _resultPosition(position: 5, valuePosition: listResult[5]),
          _resultPosition(position: 4, valuePosition: listResult[4]),
          _resultPosition(position: 3, valuePosition: listResult[3]),
          _resultPosition(position: 2, valuePosition: listResult[2]),
          _resultPosition(position: 1, valuePosition: listResult[1]),
          _resultPosition(position: 0, valuePosition: listResult[0]),
          Text(
            '     ',
            style: TextStyle(fontSize: 50, color: Colors.white),
          ),
        ],
      );
    }
  }

  void _buttonNumberPressed({required int number}){
    setState(() {
      listResult[_positionInResult] = number;
    });
  }

  Widget _buttonNumber({required int number}){
    return ElevatedButton(
      onPressed: () => _buttonNumberPressed(number: number),
      child: Text(
        '$number',
        style:
        TextStyle(fontSize: 40, color: Colors.white,),
      ),
    );
  } // buttonNumber

  void _buttonNextPressed({required int next}){
    setState(() {
      if (next==1){
        if (_positionInResult < widget.operationHeight) {
          // not the last position including last result with 2 digits.
          _positionInResult++;
        }
      }
      if (next==-1){
        if (_positionInResult > 0) { // not the first position
          _positionInResult--;
        }
      }
    });
  } // buttonNextPressed

  Widget _buttonNext({required int next}){ // next: +1 next, -1 previous
    return ElevatedButton(
      onPressed: () => _buttonNextPressed(next: next),
      child: Text(
      (next==1) ?'<-' : '->',
        style:
        TextStyle(fontSize: 40, color: Colors.white,),
      ),
    );
  } // buttonNext
  
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
    } else if (rowNumber==4){
      a=10;
      b=0;
      c=11;
    }
    if (rowNumber==4){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buttonNext(next: 1),
          _buttonNumber(number: b),
          _buttonNext(next: -1),
        ],
      );
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

  void _testResult(){
    setState(() {
      int resultUser = 0;
      int resultReal = 0;

      for (int i=0; i<=widget.operationHeight;i++){
        resultUser = resultUser + (listResult[i]*pow(10, i).toInt());
      }
      if (widget.operation=='+') { // sum
        resultReal = widget.operator1 + widget.operator2;
      } else if (widget.operation=='x') { // multiplication
        resultReal = widget.operator1 * widget.operator2;
      } else { // subtract
        resultReal = widget.operator1 - widget.operator2;
      }
      if (resultUser==resultReal){
        containerOperationColor = Colors.green;
      } else {
        containerOperationColor = Colors.red;
      };
    });

  }

  Widget _resultButton(){
    return ElevatedButton(
      onPressed: () => _testResult(),
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.blue),
      ),
      child: Text(
        'comprobar',
        style: TextStyle(fontSize: 50, color: Colors.white),
      ),
    );

  } // resultButton

} // _OperationPageState
