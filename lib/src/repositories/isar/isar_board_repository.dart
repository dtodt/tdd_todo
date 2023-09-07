import 'package:todo/src/models/task.dart';

import '../board_repository.dart';
import 'isar_datasource.dart';
import 'task_model.dart';

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
  Future<List<Task>> update(List<Task> tasks) async {
    final models = tasks.map((task) {
      var model = TaskModel()
        ..checked = task.checked
        ..description = task.description;
      if (task.id != -1) {
        model.id = task.id;
      }
      return model;
    }).toList();

    await datasource.deleteAll();
    await datasource.putTasks(models);
    return tasks;
  }
}
