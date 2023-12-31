import 'package:credit_score/credit_score.dart';
import 'package:flutter/material.dart';

import 'main_screen.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text('Credit Score Demo',style: TextStyle(color: Colors.black),),
        ),
        body: const MainScreen()
      ),
    );
  }
}
