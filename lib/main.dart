import 'package:flutter/material.dart';
import './stockInput.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(primaryColor: Colors.purple),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Interesting Stocks'),
        ),
        body: StockInput(),
      ),
    );
  }
}
