import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TechniHome',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('TechniHome'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              print('Button Pressed!');
            },
            child: Text('Press Me'),
          ),
        ),
      ),
    );
  }
}
