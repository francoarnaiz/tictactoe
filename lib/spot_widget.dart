library;

import 'package:flutter/material.dart';
import 'package:tictactoe/game_constants.dart';

class SpotLogic {
  final Piece piece = Piece.none;
  final int column = 0;
  final int row = 0;
  void _onClick {}
  final bool selected = false;
}
//TODO: remove constructors and add a "build spot" method!
class SpotUpdater extends ChangeNotifier {
  SpotUpdater(this.piece, this.column, this.row, this._onClick);

  final Piece piece;
  final int column;
  final int row;
  final void Function(int column, int row) _onClick;

  final SpotLogic logic = SpotLogic(piece, column, row, _onClick);
}

class SpotView extends StatelessWidget {
  const SpotView(this.piece, this.column, this.row, this._onClick, {super.key});

  final Piece piece;
  final int column;
  final int row;
  final void Function(int column, int row) _onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.black),
      ),
      child: ElevatedButton(
        onPressed: () => _onClick(column, row),
        style: ElevatedButton.styleFrom(
          elevation: 5,
          fixedSize: Size(150, 150),
          backgroundColor: switch (piece) {
            Piece.none => Colors.grey,
            Piece.X => Colors.green,
            Piece.O => Colors.red,
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
        child: Text(
          getPiece(piece),
          style: TextStyle(
            color: Colors.black,
            fontSize: 75,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// View
