import 'package:todo/src/models/task.dart';

import '../board_repository.dart';
import 'isar_datasource.dart';

class IsarBoardRepository implements BoardRepository {
  final IsarBoardDatasource datasource;

  IsarBoardRepository(this.datasource);

  @override
  Future<List<Task>> fetch() {
    // TODO: implement fetch
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> update(List<Task> tasks) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
