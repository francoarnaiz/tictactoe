library;

import 'package:flutter/material.dart';
import 'package:tictactoe/game_constants.dart';

class SpotModel {
  var column = 0;
  var row = 0;
  Piece get piece => board[row][column];
  var selected = false;
}

// View Model
class SpotVM extends ChangeNotifier {
  SpotVM(this.model);
  final SpotModel model;

  void setLocation(int column, int row) {
    model.column = column;
    model.row = row;
    notifyListeners();
  }

  void _onClick() {
    model.selected = true;
    print("Clicked!");
  }

  void deselect() {
    model.selected = false;
    notifyListeners();
  }
}

class SpotView extends StatefulWidget {
  SpotView({super.key});

  final SpotVM vm = SpotVM(SpotModel());

  @override
  State<StatefulWidget> createState() => _SpotState();
}

class _SpotState extends State<SpotView> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.vm,
      builder: (context, _) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.black),
          ),
          child: ElevatedButton(
            onPressed: widget.vm._onClick,
            style: ElevatedButton.styleFrom(
              elevation: 5,
              fixedSize: Size(150, 150),
              backgroundColor: switch (widget.vm.model.piece) {
                Piece.none => Colors.grey,
                Piece.X => Colors.green,
                Piece.O => Colors.red,
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
            child: Text(
              getPiece(widget.vm.model.piece),
              style: TextStyle(
                color: Colors.black,
                fontSize: 75,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
