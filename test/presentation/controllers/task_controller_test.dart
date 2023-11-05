import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/domain/entities/local/task_entity.dart';
import 'package:todo_app/domain/usecases/task_usecase.dart';
import 'package:todo_app/presentation/controllers/task_controller.dart';

import 'task_controller_test.mocks.dart';

@GenerateMocks([TaskUsecase])
void main() {
  group('TaskController', () {
    late MockTaskUsecase mockTaskUsecase;
    late TaskController taskController;
    setUp(() {
      mockTaskUsecase = MockTaskUsecase();
      taskController = TaskController(mockTaskUsecase);
    });

    test(
      'initial value should be as set',
      () {
        expect(taskController.sortBySelected, "");
        expect(taskController.searchQuery, "");
        expect(taskController.selectedID, "");
        expect(taskController.tasks, []);
        expect(taskController.filteredTasks, []);
      },
    );

    test('clearTask() should clear tasks', () {
      final initialTasks = [
        TaskEntity(title: 'Task 1'),
        TaskEntity(title: 'Task 2'),
      ];
      taskController.tasks.addAll(initialTasks);

      taskController.clearTask();

      expect(taskController.tasks, isEmpty);
    });

    group('CRUD operation tasks', () {
      test('fetchTask() should fetch and add tasks', () async {
        final tasksToFetch = [
          TaskEntity(title: 'Task 1'),
          TaskEntity(title: 'Task 2'),
        ];

        when(mockTaskUsecase.get(
                page: anyNamed('page'), limit: anyNamed('limit')))
            .thenAnswer((_) => Future.value(tasksToFetch));
        await taskController.fetchTask();

        expect(taskController.tasks, tasksToFetch);
      });

      test('insertTask() should call TaskUsecase insert()', () async {
        final taskToInsert = TaskEntity(title: 'New Task');
        when(mockTaskUsecase.insert(task: taskToInsert))
            .thenAnswer((_) => Future.value(1));

        await taskController.insertTask(taskToInsert);

        verify(mockTaskUsecase.insert(task: taskToInsert)).called(1);
      });

      test('updateTask() should call TaskUsecase update()', () async {
        final taskToUpdate = TaskEntity(id: '123', title: 'Updated Task');
        when(mockTaskUsecase.update(task: taskToUpdate))
            .thenAnswer((_) => Future.value(1));

        await taskController.updateTask(taskToUpdate);

        verify(mockTaskUsecase.update(task: taskToUpdate)).called(1);
      });

      test('deleteTask() should call TaskUsecase delete()', () async {
        const taskIdToDelete = '123';
        when(mockTaskUsecase.delete(key: taskIdToDelete))
            .thenAnswer((_) => Future.value(1));

        await taskController.deleteTask(taskIdToDelete);

        verify(mockTaskUsecase.delete(key: taskIdToDelete)).called(1);
      });
    });

    group('sortby()', () {
      test(
          'sortyBy() should sort tasks by title when sortBySelected is "title".tr',
          () {
        final tasksToSort = [
          TaskEntity(title: 'C'),
          TaskEntity(title: 'B'),
          TaskEntity(title: 'A'),
        ];
        taskController.sortBySelected = 'title'.tr;

        taskController.tasks.addAll(tasksToSort);

        taskController.sortyBy();

        final sortedTitles =
            taskController.tasks.map((task) => task.title).toList();
        expect(sortedTitles, ['A', 'B', 'C']);
      });

      test(
          'sortyBy should sort tasks by created date when sortBySelected is "date".tr',
          () {
        final tasksToSort = [
          TaskEntity(createdDate: DateTime(2023, 11, 1)),
          TaskEntity(createdDate: DateTime(2023, 10, 1)),
          TaskEntity(createdDate: DateTime(2023, 12, 1)),
        ];
        taskController.sortBySelected = 'date'.tr;

        taskController.tasks.addAll(tasksToSort);

        taskController.sortyBy();

        final sortedDates =
            taskController.tasks.map((task) => task.createdDate).toList();
        expect(
            sortedDates,
            containsAllInOrder([
              DateTime(2023, 10, 1),
              DateTime(2023, 11, 1),
              DateTime(2023, 12, 1),
            ]));
      });

      test(
          'sortyBy() should sort tasks by status when sortBySelected is "status".tr',
          () {
        final tasksToSort = [
          TaskEntity(status: 'IN_PROGRESS'),
          TaskEntity(status: 'COMPLETED'),
          TaskEntity(status: 'IN_PROGRESS'),
        ];
        taskController.sortBySelected = 'status'.tr;

        taskController.tasks.addAll(tasksToSort);

        taskController.sortyBy();

        final sortedStatuses =
            taskController.tasks.map((task) => task.status).toList();
        expect(sortedStatuses, ['COMPLETED', 'IN_PROGRESS', 'IN_PROGRESS']);
      });

      test(
          'sortyBy() should sort default tasks by date when sortBySelected is not "title".tr and "date".tr ans "status".tr',
          () {
        final tasksToSort = [
          TaskEntity(
              title: 'A',
              createdDate: DateTime(2023, 11, 1),
              status: 'IN_PROGRESS'),
          TaskEntity(
              title: 'B',
              createdDate: DateTime(2023, 10, 1),
              status: 'IN_PROGRESS'),
          TaskEntity(
              title: 'C',
              createdDate: DateTime(2023, 12, 1),
              status: 'COMPLETED'),
        ];
        taskController.sortBySelected = "priority";

        taskController.tasks.addAll(tasksToSort);

        taskController.sortyBy();

        final sortedTasks =
            taskController.tasks.map((task) => task.createdDate).toList();
        expect(
            sortedTasks,
            containsAllInOrder([
              DateTime(2023, 10, 1),
              DateTime(2023, 11, 1),
              DateTime(2023, 12, 1),
            ]));
      });
    });

    group('search()', () {
      test('search() should update filteredTasks based on searchQuery', () {
        final tasksToSearch = [
          TaskEntity(title: 'Task 1', description: 'Description 1'),
          TaskEntity(title: 'Task 2', description: 'Description 2'),
          TaskEntity(title: 'Task 3', description: 'Description 3'),
        ];

        taskController.tasks.addAll(tasksToSearch);
        taskController.searchQuery = '2';

        taskController.search();

        final filteredTasks = taskController.filteredTasks;
        expect(filteredTasks, hasLength(1));
        expect(filteredTasks.first.title, 'Task 2');
        expect(filteredTasks.first.description, 'Description 2');
      });

      test('search should not update filteredTasks when searchQuery is empty',
          () {
        final tasksToSearch = [
          TaskEntity(title: 'Task 1', description: 'Description 1'),
          TaskEntity(title: 'Task 2', description: 'Description 2'),
          TaskEntity(title: 'Task 3', description: 'Description 3'),
        ];

        taskController.tasks.addAll(tasksToSearch);
        taskController.searchQuery = '';

        taskController.search();

        expect(taskController.filteredTasks, isEmpty);
      });
    });

    test(
        'init() should initialize properties and correctly fetch tasks that sorted by date',
        () async {
      final tasksToFetch = [
        TaskEntity(
            title: 'A',
            createdDate: DateTime(2023, 11, 1),
            status: 'IN_PROGRESS'),
        TaskEntity(
            title: 'B',
            createdDate: DateTime(2023, 10, 1),
            status: 'IN_PROGRESS'),
        TaskEntity(
            title: 'C',
            createdDate: DateTime(2023, 12, 1),
            status: 'COMPLETED'),
      ];

      when(mockTaskUsecase.get(
              page: anyNamed('page'), limit: anyNamed('limit')))
          .thenAnswer((_) => Future.value(tasksToFetch));

      await taskController.init();

      final sortedTasks =
          taskController.tasks.map((task) => task.createdDate).toList();

      expect(taskController.sortBySelected, '');
      expect(taskController.searchQuery, '');
      expect(taskController.selectedID, '');
      expect(taskController.tasks, hasLength(3));
      expect(
          sortedTasks,
          containsAllInOrder([
            DateTime(2023, 10, 1),
            DateTime(2023, 11, 1),
            DateTime(2023, 12, 1),
          ]));
    });
  });
}
