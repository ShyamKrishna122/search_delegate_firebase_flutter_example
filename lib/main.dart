import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:search_delegate_firebase_example/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _init = true;

  @override
  void didChangeDependencies() async {
    if (_init) {
      await Firebase.initializeApp();
    }
    setState(() {
      _init = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        cursorColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
