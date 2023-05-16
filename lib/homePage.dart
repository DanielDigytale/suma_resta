import 'package:flutter/material.dart';
import 'package:suma_resta/operationPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _operation = '';
  int _operationHeight = 0;
  MaterialColor buttonColor = Colors.yellow;
  MaterialColor buttonColorSelected = Colors.deepOrange;

    void _setOperation({required String operation}){
    setState(() {
      if (operation==_operation) { // deselect operation.
        _operation = ' ';
      } else { // select an operation
        if (operation == '+') {
          _operation = '+';
        } else if (operation == '-') {
          _operation = '-';
        } else {
          _operation = '+';
        }
      }
    });
  }

  void _setOperationHeight({required int number}){
    setState(() {
      _operationHeight = number;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
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
                child:Center(
                  child: Column(
                    children: [
                      Text(
                          'Elige la operación:',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                              onPressed: () => _setOperation(operation: '+'),
                              child: Text(
                                  '+',
                                style: TextStyle(
                                  fontSize: 100.0,
                                  color: (_operation=='+')
                                      ? buttonColorSelected
                                      : buttonColor,
                                ),
                              ),
                          ),
                          TextButton(
                            onPressed: () => _setOperation(operation: '-'),
                            child: Text(
                              '-',
                              style: TextStyle(
                                fontSize: 100.0,
                                color: (_operation=='-')
                                    ? buttonColorSelected
                                    : buttonColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 300,
                width: 300,
                color: Colors.blueGrey[700],
                child:Center(
                  child: Column(
                    children: [
                      Text(
                          'Elige el tamaño de los números:',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () => _setOperationHeight(number: 2),
                            child: Text(
                              '2',
                              style: TextStyle(
                                fontSize: 100.0,
                                color: (_operationHeight==2)
                                  ? buttonColorSelected
                                  : buttonColor
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => _setOperationHeight(number: 3),
                            child: Text(
                              '3',
                              style: TextStyle(
                                fontSize: 100.0,
                                color: (_operationHeight==3)
                                    ? buttonColorSelected
                                    : buttonColor,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => _setOperationHeight(number: 4),
                            child: Text(
                              '4',
                              style: TextStyle(
                                fontSize: 100.0,
                                color: (_operationHeight==4)
                                    ? buttonColorSelected
                                    : buttonColor,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => _setOperationHeight(number: 5),
                            child: Text(
                              '5',
                              style: TextStyle(
                                fontSize: 100.0,
                                color: (_operationHeight==5)
                                    ? buttonColorSelected
                                    : buttonColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  if ((_operationHeight!=0)&&((_operation=='+')||(_operation=='-'))) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                OperationPage(
                                  title: 'Operación',
                                  operationHeight: _operationHeight,
                                  operation: _operation,
                                )
                        )
                    );
                  }
                },
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
              ),
            ],
          ),
        ),
      ),

    );
  }
}


