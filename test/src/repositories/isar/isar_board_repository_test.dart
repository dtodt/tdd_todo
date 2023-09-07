import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/src/repositories/isar/isar_board_repository.dart';
import 'package:todo/src/repositories/isar/isar_datasource.dart';

class IsarBoardDatasourceMock extends Mock implements IsarBoardDatasource {}

void main() {
  final datasource = IsarBoardDatasourceMock();
  final repository = IsarBoardRepository(datasource);

  tearDown(() => reset(datasource));

  group('fetch |', () {});
  group('update |', () {});
}
