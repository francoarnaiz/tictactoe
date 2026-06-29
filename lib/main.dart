import 'package:flutter/material.dart';
import 'package:tictactoe/game_grid.dart';
import 'package:tictactoe/spot.dart'; // TEMP

void main() {
  runApp(TempApp());
}

class TempApp extends StatelessWidget {
  TempApp({super.key});
  final List<SpotView> grid = [];

  void buildGrid() {
    grid.add(SpotView());
  }

  @override
  Widget build(BuildContext context) {
    buildGrid();
    grid[0].vm.setLocation(0, 1);
    return MaterialApp(home: Center(child: grid[0]));
  }
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
