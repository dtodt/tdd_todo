import 'package:todo/src/models/task.dart';

import '../board_repository.dart';
import 'isar_datasource.dart';

class IsarBoardRepository implements BoardRepository {
  final IsarBoardDatasource datasource;

  IsarBoardRepository(this.datasource);

  @override
  Future<List<Task>> fetch() async {
    final models = await datasource.getTasks();
    return models
        .map((model) => Task(
              id: model.id,
              description: model.description,
              checked: model.checked,
            ))
        .toList();
  }

  @override
  Future<List<Task>> update(List<Task> tasks) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
