import 'package:todo_app/domain/entities/local/task_entity.dart';

abstract class TaskRepository {
  //create
  Future<int> insertTaskEntity({required TaskEntity task});

  //read
  Future<List<TaskEntity>> getTaskEntity(
      {required int page, required int limit});

  //update
  Future<int> updateTaskEntity({required TaskEntity task});

  //delete
  Future<int> deleteTaskEntity({required String key});
}
