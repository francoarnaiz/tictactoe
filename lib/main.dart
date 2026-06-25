import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

List<List<Piece>> board = [[], [], []];

enum Piece { X, O, none }

Piece nextPlayer = Piece.O;

void togglePlayer() {
  nextPlayer = switch (nextPlayer) {
    Piece.X => Piece.O,
    Piece.O => Piece.X,
    _ => Piece.none,
  };

  if (nextPlayer == Piece.none) {
    throw "Error: no nextPlayer!";
  }
}

void fillBoard(Piece piece) {
  board = [
    for (var x = 0; x < 3; x++) [for (var x = 0; x < 3; x++) piece],
  ];
}

void addPiece(int column, int row, Piece piece) {
  if (piece == Piece.none) {
    throw "Error: Tried adding nothing to a spot!";
  }
  board[row][column] = piece;
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
  var nextRow = 0;
  var nextColumn = 0;
  var nextPiece = Piece.none;

  void placePiece(int column, int row, Piece piece) {
    setState(() {
      addPiece(column, row, piece);
    });

    togglePlayer();
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
          GameGrid((int column, int row, Piece piece) {
            nextRow = row;
            nextColumn = column;
            nextPiece = piece;
          }),
          ElevatedButton(
            onPressed: () => placePiece(nextColumn, nextRow, nextPiece),
            child: Text("Go"),
          ),
        ],
      ),
    );
  }
}

class GameGrid extends StatelessWidget {
  const GameGrid(this._onPlace, {super.key});

  final void Function(int column, int row, Piece piece) _onPlace;

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
                    (int column, int row, Piece piecePlaced) {
                      _onPlace(column, row, piecePlaced);
                    },
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

class Spot extends StatelessWidget {
  const Spot(this.piece, this.column, this.row, this._onPlace, {super.key});

  final String piece;
  final int row;
  final int column;
  final void Function(int column, int row, Piece piecePlaced) _onPlace;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: ElevatedButton(
        onPressed: () => _onPlace(column, row, nextPlayer),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
        child: Text(piece),
      ),
    );
  }
}
