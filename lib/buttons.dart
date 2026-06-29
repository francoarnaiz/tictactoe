library;

import 'package:flutter/material.dart';

class PlaceButton extends StatelessWidget {
  const PlaceButton({required this._onPress, super.key});

  final void Function() _onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _onPress(),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.blue),
        fixedSize: WidgetStateProperty.all(Size(150, 150)),
      ),
      child: Text("Place", style: TextStyle(color: Colors.white, fontSize: 40)),
    );
  }
}

class RestartButton extends StatelessWidget {
  const RestartButton({required this._onPress, super.key});

  final void Function() _onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _onPress(),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          const Color.fromARGB(255, 8, 63, 109),
        ),
        fixedSize: WidgetStateProperty.all(Size(150, 150)),
      ),
      child: Text(
        "Restart",
        style: TextStyle(color: Colors.white, fontSize: 30),
      ),
    );
  }
}
