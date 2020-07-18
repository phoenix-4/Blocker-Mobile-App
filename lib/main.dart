import 'package:blocker_v1/screens/wrapper.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp(

));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blocker QR',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home:Wrapper(),
      // MyHomePage(title: 'Blocker QR scanner'),
      //home: Wrapper(),
    );
  }
}

