library;

import 'package:flutter/material.dart';
import 'package:tictactoe/game_constants.dart';

class SpotModel {
  var column = 0;
  var row = 0;
  Piece get piece => board[row][column];
  var selected = false;
  void _onClick() {
    print("Col $column, Row $row)");
  }
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

  void _select() {
    model.selected = true;
    notifyListeners();
  }

  void _deselect() {
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
  void clicked() {
    widget.vm._select();
    widget.vm.model._onClick();
  }

  @override
  Widget build(BuildContext context) {
    var c = widget.vm.model.column;
    var r = widget.vm.model.row;
    var p = getPiece(widget.vm.model.piece);
    return ListenableBuilder(
      listenable: widget.vm,
      builder: (context, _) {
        return Center(
          child: Column(
            children: [
              Text("C$c, R$r, $p", style: TextStyle(fontSize: 40)),
              ElevatedButton(
                onPressed: clicked,
                child: Text("Go", style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        );
      },
    );
  }
}
