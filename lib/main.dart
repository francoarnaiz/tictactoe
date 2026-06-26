import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const err = 0;
const success = 1;

void main() {
  runApp(const MyApp());
}

List<List<Piece>> board = [[], [], []];

enum Piece { X, O, none }

Piece nextPlayer = Piece.O;

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
        body: GameGrid(),
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
  var gameStatus = "";

  void submit() {
    placePiece(nextColumn, nextRow, nextPlayer);

    var winner = checkWinner();
    gameStatus = switch (winner) {
      "O" => "O wins!",
      "X" => "X wins!",
      "none" => "Next player: ${getPiece(nextPlayer)}",
      "tie" => "Tie!",
      _ => "Error!",
    };

    updater.update();
  }

  void fillBoard(Piece piece) {
    board = [
      for (var x = 0; x < 3; x++) [for (var x = 0; x < 3; x++) piece],
    ];
  }

  String checkWinner() {
    var xWin = [Piece.X, Piece.X, Piece.X];
    var oWin = [Piece.O, Piece.O, Piece.O];

    for (var row in board) {
      if (listEquals(row, xWin)) {
        return "X";
      } else if (listEquals(row, oWin)) {
        return "O";
      }
    }

    var boardColumns = [
      for (var col in [0, 1, 2])
        [
          for (var row in [0, 1, 2]) board[row][col],
        ],
    ];

    for (var column in boardColumns) {
      if (listEquals(column, xWin)) {
        return "X";
      } else if (listEquals(column, oWin)) {
        return "O";
      }
    }

    for (var diagonal in [
      [board[0][0], board[1][1], board[2][2]],
      [board[0][2], board[1][1], board[2][0]],
    ]) {
      if (listEquals(diagonal, xWin)) {
        return "X";
      } else if (listEquals(diagonal, oWin)) {
        return "O";
      }
    }

    if (listEquals(
      [for (var row in board) row.indexOf(Piece.none)],
      [-1, -1, -1],
    )) {
      return "tie";
    }

    return "none";
  }

  int addPiece(int column, int row, Piece piece) {
    if (piece == Piece.none) {
      return err;
    } else if (board[row][column] != Piece.none) {
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
    gameStatus = "Next Player: O";
    fillBoard(Piece.none);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: updater,
      builder: (context, _) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Center(
              child: Text(
                gameStatus,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30),
              ),
            ),
            Center(
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
                            },
                          ),
                      ],
                    ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => submit(),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.blue),
                fixedSize: WidgetStateProperty.all(Size(150, 150)),
              ),
              child: Text(
                "Go",
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
            ),
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
      height: 150,
      width: 150,
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
