import 'package:flutter/material.dart';

class OperationPage extends StatefulWidget {
  const OperationPage({super.key, required this.title});

  final String title;

  @override
  State<OperationPage> createState() => _OperationPageState();
}

class _OperationPageState extends State<OperationPage> {
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
                      ),
                      Container(
                        height: 300,
                        width: 300,
                        color: Colors.blueGrey[700],
                      ),
                    ]
                )
            )
        )
    );
  } // build
} // _OperationPageState
