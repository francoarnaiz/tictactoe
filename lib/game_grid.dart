library;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/game_constants.dart';
import 'package:tictactoe/spot.dart';
import 'package:tictactoe/buttons.dart';

// Grid View
class GameGrid extends StatefulWidget {
  const GameGrid({super.key});

  @override
  State<GameGrid> createState() => _GameGridState();
}

//Grid View State
class _GameGridState extends State<GameGrid> {
  var nextRow = 0;
  var nextColumn = 0;
  var gameStatus = "";
  var isGameOver = false;

  void newGame() {
    setState(() {
      gameStatus = "Next Player: O";
      isGameOver = false;
      nextPlayer = Piece.O;
      fillBoard(Piece.none);
    });
  }

  void submit() {
    setState(() {
      placePiece(nextColumn, nextRow, nextPlayer);

      var winner = checkWinner();

      gameStatus = switch (winner) {
        "O" => "O wins!",
        "X" => "X wins!",
        "none" => "Next player: ${getPiece(nextPlayer)}",
        "tie" => "Tie!",
        _ => "Error!",
      };

      isGameOver = switch (winner) {
        "X" || "O" || "tie" => true,
        _ => false,
      };
    });
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
    newGame();
  }

  @override
  Widget build(BuildContext context) {
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
                      SpotView(),
                  ],
                ),
            ],
          ),
        ),
        switch (isGameOver) {
          false => PlaceButton(onPress: submit),
          true => RestartButton(onPress: newGame),
        },
      ],
    );
  }
}
