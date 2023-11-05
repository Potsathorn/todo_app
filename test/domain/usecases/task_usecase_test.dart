import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/domain/entities/local/task_entity.dart';
import 'package:todo_app/domain/repositories/task_repository.dart';
import 'package:todo_app/domain/usecases/task_usecase.dart';

import 'task_usecase_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  group('TaskUsecase', () {
    late MockTaskRepository mockTaskRepository;
    late TaskUsecase taskUsecase;
    setUp(() {
      mockTaskRepository = MockTaskRepository();
      taskUsecase = TaskUsecase(mockTaskRepository);
    });

    test('insert() should call TaskRepository insertTaskEntity', () async {
      final taskToInsert = TaskEntity(title: 'New Task');
      when(mockTaskRepository.insertTaskEntity(task: taskToInsert))
          .thenAnswer((_) => Future.value(1));

      final result = await taskUsecase.insert(task: taskToInsert);

      expect(result, 1);
      verify(mockTaskRepository.insertTaskEntity(task: taskToInsert)).called(1);
    });

    test('get() should call TaskRepository getTaskEntity', () async {
      when(mockTaskRepository.getTaskEntity(page: 1, limit: 10))
          .thenAnswer((_) => Future.value([]));

      final result = await taskUsecase.get(page: 1, limit: 10);

      expect(result, isEmpty);
      verify(mockTaskRepository.getTaskEntity(page: 1, limit: 10)).called(1);
    });

    test('update() should call TaskRepository updateTaskEntity', () async {
      final taskToUpdate = TaskEntity(id: '123', title: 'Updated Task');
      when(mockTaskRepository.updateTaskEntity(task: taskToUpdate))
          .thenAnswer((_) => Future.value(1));

      final result = await taskUsecase.update(task: taskToUpdate);

      expect(result, 1);
      verify(mockTaskRepository.updateTaskEntity(task: taskToUpdate)).called(1);
    });

    test('delete() should call TaskRepository deleteTaskEntity', () async {
      when(mockTaskRepository.deleteTaskEntity(key: '123'))
          .thenAnswer((_) => Future.value(1));

      final result = await taskUsecase.delete(key: '123');

      expect(result, 1);
      verify(mockTaskRepository.deleteTaskEntity(key: '123')).called(1);
    });
  });
}
