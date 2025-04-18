import 'package:flutter/material.dart';
import 'package:todo_app/screens/todo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: const TodoScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}