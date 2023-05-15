import 'package:flutter/material.dart';
import 'dart:math';

class OperationPage extends StatefulWidget {
  const OperationPage({
    super.key,
    required this.title,
    required this.operationHeight,
    required this.operation,
  });

  final String title;
  final int operationHeight;
  final String operation;

  @override
  State<OperationPage> createState() => _OperationPageState();
}

class _OperationPageState extends State<OperationPage> {
  var _operator1= 0;
  var _operator2= 0;

  void _constructorOperator({required int operatorPosition}){
    if (operatorPosition==1) {
      for (int i = 0; i < widget.operationHeight; i++) {
        _operator1 = _operator1 + (Random().nextInt(10) * pow(10, i).toInt());
      } // for
    } else { // operatorPosition==2
      if (widget.operation=='+'){
        for (int i = 0; i < widget.operationHeight; i++) {
          _operator2 = _operator2 + (Random().nextInt(10) * pow(10, i).toInt());
        } // for
      }else { // operation=='-', operator2 must be less than operator1
        _operator2 = _operator1 - (Random().nextInt(_operator1));
      }
    } // if
  }

  Widget _rowOperator({required int operatorPosition}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          (operatorPosition==1)
            ? '$_operator1'
            : '$_operator2',
          style: TextStyle(fontSize: 50, color: Colors.white),
        ),
        Text(
            '     ',
          style: TextStyle(fontSize: 50,),
        ),
      ],
    );
  }

  Widget _rowOperation(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(widget.operation,
          style: TextStyle(fontSize: 60, color: Colors.white),
        ),
      ],
    );
  }

  Widget _resultPosition({required int position}){
    return Text('#',
        style: TextStyle(
          fontSize: 50,
          color: Colors.white,
        ),
    );
  }
  Widget _rowResult(){
    return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _resultPosition(position: 1),
          _resultPosition(position: 2),
          _resultPosition(position: 3),
          _resultPosition(position: 4),
          _resultPosition(position: 5),
          Text(
            '    ',
            style: TextStyle(fontSize: 50, color: Colors.white),
          ),
          ],
    );
  }








  @override
  Widget build(BuildContext context) {
    _constructorOperator(operatorPosition: 1);
    _constructorOperator(operatorPosition: 2);

    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('${widget.title} ${widget.operation}')),
        ),
        body: Container(
            color: Colors.black54,
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 300,
                        width: 300,
                        color: Colors.blueGrey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _rowOperator(operatorPosition: 1), // operator1
                            _rowOperation(),                   // operation sign
                            _rowOperator(operatorPosition: 2), // operator2
                            Divider(height: 30.0, color: Colors.white, thickness: 5.0,),
                            _rowResult(),                      // result
                          ],
                        ),
                      ),
                      Container(
                        height: 300,
                        width: 300,
                        color: Colors.blueGrey[700],
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                      onPressed: null,
                                      child: Text('1',
                                        style: TextStyle(fontSize: 30, color: Colors.white),
                                      ),
                                  ),
                                  TextButton(
                                    onPressed: null,
                                    child: Text('2',
                                      style: TextStyle(fontSize: 30, color: Colors.white),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: null,
                                    child: Text('3',
                                      style: TextStyle(fontSize: 30, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: null,
                                    child: Text('4',
                                      style: TextStyle(fontSize: 30, color: Colors.white),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: null,
                                    child: Text('5',
                                      style: TextStyle(fontSize: 30, color: Colors.white),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: null,
                                    child: Text('6',
                                      style: TextStyle(fontSize: 30, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: null,
                                    child: Text('7',
                                      style: TextStyle(fontSize: 30, color: Colors.white),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: null,
                                    child: Text('8',
                                      style: TextStyle(fontSize: 30, color: Colors.white),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: null,
                                    child: Text('9',
                                      style: TextStyle(fontSize: 30, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: null,
                                    child: Text('0',
                                      style: TextStyle(fontSize: 30, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => print('comprobar resultado'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.blue),
                        ),
                        child: Text('comprobar resultado',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ),
                    ],
                ),
            ),
        ),
    );
  } // build
} // _OperationPageState
