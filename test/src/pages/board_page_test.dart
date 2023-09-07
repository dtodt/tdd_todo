import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/src/cubits/board_cubit.dart';
import 'package:todo/src/pages/board_page.dart';
import 'package:todo/src/repositories/board_repository.dart';

class BoardRepositoryMock extends Mock implements BoardRepository {}

void main() {
  final repository = BoardRepositoryMock();
  late BoardCubit cubit;

  setUp(() {
    cubit = BoardCubit(repository);
  });

  tearDown(() {
    reset(repository);
  });

  testWidgets('BoardPage', (tester) async {
    await tester.pumpWidget(BlocProvider.value(
      value: cubit,
      child: const MaterialApp(home: BoardPage()),
    ));
  });
}
