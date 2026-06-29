library;

const err = 0;
const success = 1;

enum Piece { X, O, none }

Piece nextPlayer = Piece.O;

String getPiece(Piece piece) {
  return switch (piece) {
    Piece.X => "X",
    Piece.O => "O",
    Piece.none => "",
  };
}

List<List<Piece>> board = [[], [], []];
