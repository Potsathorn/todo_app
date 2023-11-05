import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/data/datasources/local/local_datasource.dart';
import 'package:todo_app/data/repositories/task_repository_impl.dart';
import 'package:todo_app/domain/entities/local/task_entity.dart';
import 'package:todo_app/domain/repositories/task_repository.dart';

import 'task_repository_impl_test.mocks.dart';

@GenerateMocks([LocalDataSource])
void main() {
  group('TaskRepositoryImpl', () {
    late MockLocalDataSource mockLocalDataSource;
    late TaskRepository taskRepository;

    setUp(() {
      mockLocalDataSource = MockLocalDataSource();
      taskRepository = TaskRepositoryImpl(mockLocalDataSource);
    });

    test(
        'insertTaskEntity() should call LocalDataSource insertTask and return a result code',
        () async {
      final taskToInsert = TaskEntity(title: 'New Task');
      when(mockLocalDataSource.insertTask(task: anyNamed('task')))
          .thenAnswer((_) => Future.value(1));

      final result = await taskRepository.insertTaskEntity(task: taskToInsert);

      expect(result, 1);
      verify(mockLocalDataSource.insertTask(task: anyNamed('task'))).called(1);
    });

    test(
        'getTaskEntity() should call LocalDataSource getTask and return a list of TaskEntity',
        () async {
      when(mockLocalDataSource.getTask(
              page: anyNamed('page'), limit: anyNamed('limit')))
          .thenAnswer(
              (_) => Future.value([TaskEntity(title: 'Task 1').toModel()]));

      final result = await taskRepository.getTaskEntity(page: 1, limit: 10);

      expect(result, hasLength(1));
      expect(result[0].title, 'Task 1');
      verify(mockLocalDataSource.getTask(page: 1, limit: 10)).called(1);
    });

    test(
        'updateTaskEntity() should call LocalDataSource updateTask and return a result code',
        () async {
      final taskToUpdate = TaskEntity(id: '123', title: 'Updated Task');
      when(mockLocalDataSource.updateTask(task: anyNamed('task')))
          .thenAnswer((_) => Future.value(1));

      final result = await taskRepository.updateTaskEntity(task: taskToUpdate);

      expect(result, 1);
      verify(mockLocalDataSource.updateTask(task: anyNamed('task'))).called(1);
    });

    test(
        'deleteTaskEntity() should call LocalDataSource deleteTask and return a result code',
        () async {
      when(mockLocalDataSource.deleteTask(key: anyNamed('key')))
          .thenAnswer((_) => Future.value(1));

      final result = await taskRepository.deleteTaskEntity(key: '123');

      expect(result, 1);
      verify(mockLocalDataSource.deleteTask(key: '123')).called(1);
    });
  });
}
