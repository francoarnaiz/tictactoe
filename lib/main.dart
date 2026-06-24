import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

List<List<Piece>> board = [[], [], []];

enum Piece { X, O, none }

void fillBoard(Piece piece) {
  board = [
    for (var x = 0; x < 3; x++) [for (var x = 0; x < 3; x++) piece],
  ];
}

String getPiece(Piece piece) {
  return switch (piece) {
    Piece.X => "X",
    Piece.O => "O",
    Piece.none => "",
  };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepOrange)),
      home: Scaffold(
        appBar: AppBar(title: Text("Tic-Tac-Toe!")),
        body: Screen(),
      ),
    );
  }
}

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  void _changeBoard() {
    setState(() {
      fillBoard(Piece.O);
    });
  }

  @override
  void initState() {
    super.initState();
    fillBoard(Piece.none);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GameGrid(),
          ElevatedButton(onPressed: _changeBoard, child: Text("Go")),
        ],
      ),
    );
  }
}

class GameGrid extends StatelessWidget {
  const GameGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: 500,
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var gridRow in board)
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var gridPiece in gridRow) Spot(getPiece(gridPiece)),
              ],
            ),
        ],
      ),
    );
  }
}

class Spot extends StatelessWidget {
  const Spot(this.piece, {super.key});

  final String piece;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Center(child: Text(piece)),
    );
  }
}
