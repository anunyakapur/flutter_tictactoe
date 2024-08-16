import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/main.dart';

void main() {
  testWidgets('Initial UI elements are displayed', (WidgetTester tester) async {
    // Build the Tic Tac Toe app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the title is displayed.
    expect(find.text('Tic Tac Toe'), findsOneWidget);

    // Verify that the 3x3 grid is displayed with all empty cells.
    for (int i = 0; i < 9; i++) {
      expect(find.text(''), findsNWidgets(9));
    }

    // Verify that there is no winner text at the beginning.
    expect(find.text('Player X Wins!'), findsNothing);
    expect(find.text('Player O Wins!'), findsNothing);
  });

  testWidgets('Player X can make a move', (WidgetTester tester) async {
    // Build the Tic Tac Toe app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Tap the first cell (top-left corner).
    await tester.tap(find.byType(GestureDetector).at(0));
    await tester.pump();

    // Verify that the cell now contains 'X'.
    expect(find.text('X'), findsOneWidget);
  });

  testWidgets('Player O can make a move after X', (WidgetTester tester) async {
    // Build the Tic Tac Toe app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Player X taps the first cell (top-left corner).
    await tester.tap(find.byType(GestureDetector).at(0));
    await tester.pump();

    // Player O taps the second cell (top-center).
    await tester.tap(find.byType(GestureDetector).at(1));
    await tester.pump();

    // Verify that the first cell contains 'X' and the second contains 'O'.
    expect(find.text('X'), findsOneWidget);
    expect(find.text('O'), findsOneWidget);
  });

  testWidgets('Player X wins the game', (WidgetTester tester) async {
    // Build the Tic Tac Toe app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Simulate a sequence of moves that would lead to Player X winning.
    await tester.tap(find.byType(GestureDetector).at(0)); // X
    await tester.pump();
    await tester.tap(find.byType(GestureDetector).at(3)); // O
    await tester.pump();
    await tester.tap(find.byType(GestureDetector).at(1)); // X
    await tester.pump();
    await tester.tap(find.byType(GestureDetector).at(4)); // O
    await tester.pump();
    await tester.tap(find.byType(GestureDetector).at(2)); // X
    await tester.pump();

    // Verify that the winning message for Player X is displayed.
    expect(find.text('Player X Wins!'), findsOneWidget);
  });
}
