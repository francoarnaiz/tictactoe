import 'package:flutter/material.dart';
import 'package:tictactoe/spot_widget.dart';
import 'package:tictactoe/game_grid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(testImport()), // TEMP
          backgroundColor: Colors.blue,
        ),
        body: GameGrid(),
        backgroundColor: Colors.deepOrange,
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
