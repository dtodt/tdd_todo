import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/src/pages/board_page.dart';

void main() {
  testWidgets('BoardPage', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: BoardPage()));
  });
}
