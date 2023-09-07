import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'task_model.dart';

class IsarBoardDatasource {
  Isar? _isar;

  Future<Isar> _getInstance() async {
    if (_isar != null) return _isar!;

    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [TaskModelSchema],
      directory: dir.path,
    );

    return _isar!;
  }

  Future<List<TaskModel>> getTasks() async {
    final isar = await _getInstance();
    return isar.taskModels.where().findAll();
  }

  Future<void> deleteAll() async {
    final isar = await _getInstance();
    await isar.writeTxn(() {
      return isar.taskModels.where().deleteAll();
    });
  }

  Future<void> putTasks(List<TaskModel> models) async {
    final isar = await _getInstance();
    await isar.writeTxn(() {
      return isar.taskModels.putAll(models);
    });
  }
}
