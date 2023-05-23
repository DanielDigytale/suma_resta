import 'package:flutter/material.dart';
import 'dart:math';
import 'soundsPlayer.dart';

class OperationPage extends StatefulWidget {
  // constructor with parameters sent by the homePage
  OperationPage({
    super.key,
    required this.title,
    required this.operationHeight,
    required this.operation,
    required this.operator1,
    required this.operator2,
  });

  final String title;         // title of the layout
  final int operationHeight;  // length of the operators
  final String operation;     // type of operations.
  final int operator1;        // operator1
  final int operator2;        // operator2

  @override
  State<OperationPage> createState() => _OperationPageState();
}

class _OperationPageState extends State<OperationPage> {
  int _positionInResult = 0;        // the marked position in the result number
    var listResult = [0,0,0,0,0,0]; // the result number divided into positions
    MaterialColor containerOperationColor = Colors.blueGrey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('${widget.title}: ${widget.operation}')),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/backgroundNumbers.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column( // two containers and a button to test the result
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              operationContainer(),
              numbersContainer(),
              _resultButton(),
            ],
          ),
        ),
      ),
    );
  } // build

  // it returns a row with the operator set in the parameter
  Widget _rowOperator({required int operatorPosition}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          (operatorPosition == 1) ? '${widget.operator1}' : '${widget.operator2}',
          style: const TextStyle(fontSize: 50, color: Colors.white),
        ),
        const Text('     ', // to set a padding on the right
          style: TextStyle(fontSize: 50,),
        ),
      ],
    );
  } // _rowOperator

  // it returns the row with the operation selected
  Widget _rowOperation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(widget.operation,
          style: const TextStyle(fontSize: 60, color: Colors.white),
        ),
      ],
    );
  } // _rowOperation

  // it returns the number in the selected position set in the parameter
  Widget _resultPosition({required int position}) {
    return Text('${listResult[position]}',
      style: TextStyle(
        fontSize: 50,
        color: Colors.white,
        backgroundColor: (_positionInResult == position)
            ?Colors.orange
            :Colors.blue,
      ),
    );
  }

  // it returns the row with the result depending on the length of the operators
  Widget _rowResult() {
    const Text paddingTextRight = Text('     ',
      style: TextStyle(fontSize: 50, color: Colors.white),);

    if (widget.operationHeight==2){
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _resultPosition(position: 2,),
          _resultPosition(position: 1,),
          _resultPosition(position: 0,),
          paddingTextRight,
        ],
      );
    } else if (widget.operationHeight==3){
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _resultPosition(position: 3,),
          _resultPosition(position: 2,),
          _resultPosition(position: 1,),
          _resultPosition(position: 0,),
          paddingTextRight,
        ],
      );
    } else if (widget.operationHeight==4){
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _resultPosition(position: 4,),
          _resultPosition(position: 3,),
          _resultPosition(position: 2,),
          _resultPosition(position: 1,),
          _resultPosition(position: 0,),
          paddingTextRight,
        ],
      );
    } else { // operationHeight = 5
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _resultPosition(position: 5,),
          _resultPosition(position: 4,),
          _resultPosition(position: 3,),
          _resultPosition(position: 2,),
          _resultPosition(position: 1,),
          _resultPosition(position: 0,),
          paddingTextRight,
        ],
      );
    }
  }

  // the action when a button number is pressed set by the number of the button
  void _buttonNumberPressed({required int number}){
    setState(() {
      listResult[_positionInResult] = number; // it changes the value of this position
    });
  }

  // it returns a button made with the numbers to be pressed
  Widget _buttonNumber({required int number}){
    return ElevatedButton(
      onPressed: () => _buttonNumberPressed(number: number),
      child: Text('$number',
        style: TextStyle(fontSize: 40, color: Colors.white,),
      ),
    );
  } // buttonNumber

  // the action when a button direction is pressed set by the direction +1 or -1
  void _buttonNextPressed({required int next}){
    setState(() {
      if (next==1){ // next position
        // not the last position including last result with 2 digits.
        // if it´s the last position it will do nothing
        if (_positionInResult < widget.operationHeight) _positionInResult++;
      }
      if (next==-1){ // previous position
        // not the first position, if it´s first position it will do nothing
        if (_positionInResult > 0) _positionInResult--;
      }
    });
  } // buttonNextPressed

  // it returns the next and previous buttons depends on the parameter
  Widget _buttonNext({required int next}){ // next: +1 next, -1 previous
    return ElevatedButton(
      onPressed: () => _buttonNextPressed(next: next),
      child: Text((next==1) ?'<-' : '->',
        style: TextStyle(fontSize: 40, color: Colors.white,),
      ),
    );
  } // buttonNext

  // it returns the row of numbers selected in the parameter
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

  // to check the result set by the user and show if it´s correct.
  void _testResult(){
    setState(() {
      int resultUser = 0;
      int resultReal = 0;

      // to obtain the result made by the user
      for (int i=0; i<=widget.operationHeight;i++){
        resultUser = resultUser + (listResult[i]*pow(10, i).toInt());
      }

      // to obtain the real result depending on the operation
      if (widget.operation=='+') { // sum
        resultReal = widget.operator1 + widget.operator2;
      } else if (widget.operation=='x') { // multiplication
        resultReal = widget.operator1 * widget.operator2;
      } else { // subtract
        resultReal = widget.operator1 - widget.operator2;
      }

      // to show the user if his result is correct with sound effect
      if (resultUser==resultReal){
        Player.play('sounds/correctSound.wav');
        containerOperationColor = Colors.green;
      } else {
        containerOperationColor = Colors.red;
        Player.play('sounds/incorrectSound.wav');
      };
    });

  }

  // it returns the button to check the correction of the result
  Widget _resultButton(){
    return ElevatedButton(
      onPressed: () => _testResult(),
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.blue),
      ),
      child: const Text('comprobar',
        style: TextStyle(fontSize: 50, color: Colors.white),
      ),
    );
  } // resultButton

  Widget operationContainer(){
    return( Container( // first container - operation
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
    )
    );
  } // operationContainer

  Widget numbersContainer(){
    return( Container( // second container button with numbers.
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
    )
    );
  }
} // _OperationPageState
