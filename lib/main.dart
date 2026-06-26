import 'package:flutter/material.dart';

const err = 0;
const success = 1;

void main() {
  runApp(const MyApp());
}

List<List<Piece>> board = [[], [], []];

enum Piece { X, O, none }

Piece nextPlayer = Piece.O;

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

class Screen extends StatelessWidget {
  Screen({super.key});

  final grid = GameGrid();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [grid],
      ),
    );
  }
}

//View-Model Connection
class Updater extends ChangeNotifier {
  void update() {
    notifyListeners();
  }
}

// Grid View
class GameGrid extends StatefulWidget {
  const GameGrid({super.key});

  @override
  State<GameGrid> createState() => _GameGridState();
}

//Grid View State
class _GameGridState extends State<GameGrid> {
  var updater = Updater();

  var nextRow = 0;
  var nextColumn = 0;
  Piece nextPlayer = Piece.O;

  void submit() {
    placePiece(nextColumn, nextRow, nextPlayer);
    updater.update();
  }

  int addPiece(int column, int row, Piece piece) {
    if (piece == Piece.none) {
      print("Error: Tried adding nothing to a spot!");
      return err;
    } else if (board[row][column] != Piece.none) {
      print("That spot is filled!");
      return err;
    } else {
      board[row][column] = piece;
      return success;
    }
  }

  void placePiece(int column, int row, Piece piece) {
    setState(() {
      if (addPiece(column, row, piece) == success) {
        togglePlayer();
      }
    });
  }

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

  @override
  void initState() {
    super.initState();
    fillBoard(Piece.none);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: updater,
      builder: (context, _) {
        return Column(
          children: [
            Text("Next Player: ${getPiece(nextPlayer)}"),
            SizedBox(
              height: 600,
              width: 600,
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
                            (int column, int row) {
                              nextColumn = column;
                              nextRow = row;
                              print("Selected row $nextRow, col $nextColumn");
                            },
                          ),
                      ],
                    ),
                ],
              ),
            ),
            ElevatedButton(onPressed: () => submit(), child: Text("Go")),
          ],
        );
      },
    );
  }
}

class Spot extends StatelessWidget {
  const Spot(this.piece, this.column, this.row, this._onClick, {super.key});

  final String piece;
  final int column;
  final int row;
  final void Function(int column, int row) _onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: ElevatedButton(
        onPressed: () => _onClick(column, row),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
        child: Text(piece),
      ),
    );
  }
}
