import 'package:todo_app/domain/entities/local/task_entity.dart';
import 'package:todo_app/domain/repositories/task_repository.dart';

class TaskUsecase {
  final TaskRepository _taskRepository;
  TaskUsecase(this._taskRepository);

  //create
  Future<int> insert({required TaskEntity task}) =>
      _taskRepository.insertTaskEntity(task: task);

  //read
  Future<List<TaskEntity>> get({required int page, required int limit}) =>
      _taskRepository.getTaskEntity(page: page, limit: limit);

  //update
  Future<int> update({required TaskEntity task}) =>
      _taskRepository.updateTaskEntity(task: task);

  //delete
  Future<int> delete({required String key}) =>
      _taskRepository.deleteTaskEntity(key: key);
}
