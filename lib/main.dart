import 'package:flutter/material.dart';
import 'package:tictactoe/game_grid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Tic-Tac-Toe!"),
          backgroundColor: Colors.blue,
        ),
        body: GameGrid(), // TEMP, should be GameGrid
        backgroundColor: Colors.deepOrange,
      ),
    );
  }
}
