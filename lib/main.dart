import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TicTacToeGame(),
    );
  }
}

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});

  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<List<String?>> _board = List.generate(3, (_) => List.filled(3, null));
  String _currentPlayer = 'X';
  bool _gameOver = false;
  String _winner = '';

  void _resetGame() {
    setState(() {
      _board = List.generate(3, (_) => List.filled(3, null));
      _currentPlayer = 'X';
      _gameOver = false;
      _winner = '';
    });
  }

  void _playMove(int row, int col) {
    if (_board[row][col] == null && !_gameOver) {
      setState(() {
        _board[row][col] = _currentPlayer;
        if (_checkWinner(row, col)) {
          _gameOver = true;
          _winner = _currentPlayer;
        } else if (_isBoardFull()) {
          _gameOver = true;
          _winner = 'Draw';
        } else {
          _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  bool _checkWinner(int row, int col) {
    // Check row
    if (_board[row].every((cell) => cell == _currentPlayer)) return true;
    // Check column
    if (_board.every((r) => r[col] == _currentPlayer)) return true;
    // Check diagonals
    if (row == col && _board.every((r) => r[_board.indexOf(r)] == _currentPlayer)) return true;
    if (row + col == 2 && _board.every((r) => r[2 - _board.indexOf(r)] == _currentPlayer)) return true;

    return false;
  }

  bool _isBoardFull() {
    for (var row in _board) {
      if (row.contains(null)) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                int row = index ~/ 3;
                int col = index % 3;
                return GestureDetector(
                  onTap: () => _playMove(row, col),
                  child: Container(
                    margin: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple[100],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        _board[row][col] ?? '',
                        style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_gameOver)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    _winner == 'Draw' ? 'It\'s a Draw!' : 'Player $_winner Wins!',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _resetGame,
                    child: const Text('Play Again'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
