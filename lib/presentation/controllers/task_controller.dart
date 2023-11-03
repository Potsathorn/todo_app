// ignore_for_file: prefer_final_fields

import 'dart:developer';

import 'package:get/state_manager.dart';
import 'package:todo_app/domain/entities/local/task_entity.dart';
import 'package:todo_app/domain/usecases/task_usecase.dart';

class TaskController extends GetxController {
  final TaskUsecase _taskUsecase;
  TaskController(this._taskUsecase);
  int _page = 1;
  int _limit = 2;
  var tasks = <TaskEntity>[].obs;

  Future<void> fetchTask() async {
    await _taskUsecase.get(page: _page, limit: _limit).then((value) {
      print(value);
      if (value.length < _limit) {
        //is last page
        tasks.addAll(value);
      } else {
        tasks.addAll(value);
        _page++;
        fetchTask();
      }
    });
  }

  Future<void> insertTask(TaskEntity task) async {
    log("insert");
    await _taskUsecase.insert(task: task).then((value) async {
      {
        log("insert Success");
      }
    });
  }

  Future<void> updateTaskEntity(TaskEntity task) async {
    log("update");
    await _taskUsecase.update(task: task).then((value) async {
      {
        log("update Success");
      }
    });
  }

  Future<void> deleteTaskEntity(String key) async {
    log("delete");
    await _taskUsecase.delete(key: key).then((value) async {
      {
        tasks.clear();
        log("delete Success");
      }
    });
  }
}
