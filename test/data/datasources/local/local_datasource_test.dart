import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/data/datasources/local/local_datasource.dart';
import 'package:todo_app/data/models/local/task_model.dart';

void main() {
  group('LocalDataSourceImpl', () {
    late LocalDataSource localDataSource;
    late Box<TaskModel> taskBox;

    setUp(() {
      Hive.init('test_path');
      if (!Hive.isAdapterRegistered(1)) {
        Hive.registerAdapter(TaskModelAdapter());
      }
      localDataSource = LocalDataSourceImpl();
    });

    test('insertTask should add a task to the Hive box', () async {
      taskBox = await Hive.openBox<TaskModel>(TaskModel.boxKey);
      final task = TaskModel(id: '1', title: 'Test Task');
      final result = await localDataSource.insertTask(task: task);

      expect(result, 1);
      final retrievedTask = taskBox.get(task.id);
      expect(retrievedTask, isNotNull);
      await taskBox.clear();
      await Hive.close();
    });

    test('updateTask should update a task in the Hive box', () async {
      taskBox = await Hive.openBox<TaskModel>(TaskModel.boxKey);
      final task = TaskModel(id: '2', title: 'Original Task');
      await taskBox.put(task.id, task);

      final updatedTask = TaskModel(id: '2', title: 'Updated Task');
      final result = await localDataSource.updateTask(task: updatedTask);

      expect(result, 1);
      final retrievedTask = taskBox.get(updatedTask.id) as TaskModel;
      expect(retrievedTask.title, 'Updated Task');
      await taskBox.clear();
      await Hive.close();
    });

    test('deleteTask should remove a task from the Hive box', () async {
      taskBox = await Hive.openBox<TaskModel>(TaskModel.boxKey);
      final task = TaskModel(id: '3', title: 'Task to Delete');
      await taskBox.put(task.id, task);

      final result = await localDataSource.deleteTask(key: task.id!);

      expect(result, 1);
      final retrievedTask = taskBox.get(task.id);
      expect(retrievedTask, isNull);
      await taskBox.clear();
      await Hive.close();
    });

    test('getTask should retrieve a list of tasks from the Hive box', () async {
      taskBox = await Hive.openBox<TaskModel>(TaskModel.boxKey);
      final task1 = TaskModel(id: '4', title: 'Task 1');
      final task2 = TaskModel(id: '5', title: 'Task 2');
      await taskBox.putAll({task1.id: task1, task2.id: task2});

      final result = await localDataSource.getTask(page: 1, limit: 2);

      expect(result, hasLength(2));
      expect(result[0].title, 'Task 1');
      expect(result[1].title, 'Task 2');
      await taskBox.clear();
      await Hive.close();
    });
  });
}
