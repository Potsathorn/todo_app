import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/models/local/task_model.dart';

abstract class LocalDataSource {
  static Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter<TaskModel>(TaskModelAdapter());
    await Hive.openBox<TaskModel>(TaskModel.boxKey);
  }

  Future<List<TaskModel>> getTask({required int page, required int limit});

  Future<int> insertTask({required TaskModel task});

  Future<int> updateTask({required TaskModel task});

  Future<int> deleteTask({required String key});
}

class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<List<TaskModel>> getTask(
      {required int page, required int limit}) async {
    final taskBox = Hive.box<TaskModel>(TaskModel.boxKey);
    final totalTaskCount = taskBox.length;
    final start = (page - 1) * limit;
    final newTaskCount =
        totalTaskCount - start < limit ? totalTaskCount - start : limit;
    final taskList =
        List.generate(newTaskCount, (index) => taskBox.getAt(start + index))
            .whereType<TaskModel>()
            .toList();
    return taskList;
  }

  @override
  Future<int> insertTask({required TaskModel task}) async {
    final taskBox = Hive.box<TaskModel>(TaskModel.boxKey);

    if (taskBox.containsKey(task.id)) {
      return 0;
    } else {
      taskBox.put(task.id, task);
      return 1;
    }
  }

  @override
  Future<int> updateTask({required TaskModel task}) async {
    final serviceBox = Hive.box<TaskModel>(TaskModel.boxKey);
    serviceBox.put(task.id, task);
    return 1;
  }

  @override
  Future<int> deleteTask({required String key}) async {
    final serviceBox = Hive.box<TaskModel>(TaskModel.boxKey);
    serviceBox.delete(key);
    return 1;
  }
}
