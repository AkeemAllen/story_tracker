import 'package:flutter/material.dart';
import './stockInput.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(
          primaryColor: Color(0xff592E83),
          accentColor: Color(0xffcaa8f5),
          scaffoldBackgroundColor: Color(0xfff3f5f7)),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Interesting Stocks'),
        ),
        body: StockInput(),
      ),
    );
  }
}
