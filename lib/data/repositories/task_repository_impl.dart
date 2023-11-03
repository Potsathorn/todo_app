import 'package:todo_app/data/datasources/local/local_datasource.dart';
import 'package:todo_app/domain/entities/local/task_entity.dart';
import 'package:todo_app/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final LocalDataSource _localDataSource;

  TaskRepositoryImpl(this._localDataSource);

  @override
  Future<int> deleteTaskEntity({required String key}) async {
    try {
      int result = await _localDataSource.deleteTask(key: key);
      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<TaskEntity>> getTaskEntity(
      {required int page, required int limit}) async {
    try {
      final taskList = await _localDataSource.getTask(page: page, limit: limit);

      return taskList.map((task) => task.toEntity()).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<int> insertTaskEntity({required TaskEntity task}) async {
    try {
      int result = await _localDataSource.insertTask(task: task.toModel());
      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<int> updateTaskEntity({required TaskEntity task}) async {
    try {
      int result = await _localDataSource.updateTask(task: task.toModel());
      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
