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
  void changeBoard() {
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
          ElevatedButton(onPressed: changeBoard, child: Text("Go")),
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
          for (var gridRow = 0; gridRow < 3; gridRow++)
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var gridColumn = 0; gridColumn < 3; gridColumn++)
                  Spot(
                    getPiece(board[gridRow][gridColumn]),
                    gridColumn,
                    gridRow,
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

class Spot extends StatelessWidget {
  const Spot(this.piece, this.column, this.row, {super.key});

  final String piece;
  final int row;
  final int column;

  void placePiece(int row, int column) {
    print("Piece placed at $row and $column!");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: ElevatedButton(
        onPressed: () => placePiece(row, column),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
        child: Text(piece),
      ),
    );
  }
}
