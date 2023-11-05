// ignore_for_file: prefer_final_fields

import 'dart:developer';

import 'package:get/get.dart';
import 'package:todo_app/domain/entities/local/task_entity.dart';
import 'package:todo_app/domain/usecases/task_usecase.dart';

class TaskController extends GetxController {
  final TaskUsecase _taskUsecase;
  TaskController(this._taskUsecase);
  int _page = 1;
  int _limit = 10;
  String sortBySelected = "";
  String searchQuery = "";
  String selectedID = "";
  var tasks = <TaskEntity>[].obs;
  var filteredTasks = <TaskEntity>[].obs;

  Future<void> init() async {
    sortBySelected = "";
    searchQuery = "";
    selectedID = "";
    await clearTask();
    await fetchTask().then((value) => sortyBy());
  }

  void sortyBy() {
    if (sortBySelected == "title".tr) {
      tasks.sort((a, b) => a.title!.compareTo(b.title!));
    } else if (sortBySelected == "date".tr) {
      tasks.sort((a, b) => a.createdDate!.compareTo(b.createdDate!));
    } else if (sortBySelected == "status".tr) {
      tasks.sort((a, b) => a.status!.compareTo(b.status!));
    } else {
      tasks.sort((a, b) => a.createdDate!.compareTo(b.createdDate!));
    }
  }

  void search() {
    if (searchQuery.isNotEmpty) {
      filteredTasks = tasks
          .where((item) =>
              item.title!.toLowerCase().contains(searchQuery.toLowerCase()) ||
              item.description!
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
          .toList()
          .obs;
    }
  }

  Future<void> fetchTask() async {
    await _taskUsecase.get(page: _page, limit: _limit).then((value) {
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

  Future<void> clearTask() async {
    tasks.clear();
  }

  Future<void> insertTask(TaskEntity task) async {
    log("insert");
    await _taskUsecase.insert(task: task).then((value) async {
      {
        log("insert Success");
      }
    });
  }

  Future<void> updateTask(TaskEntity task) async {
    log("update");
    await _taskUsecase.update(task: task).then((value) async {
      {
        log("update Success");
      }
    });
  }

  Future<void> deleteTask(String key) async {
    log("delete");
    await _taskUsecase.delete(key: key).then((value) async {
      {
        log("delete Success");
      }
    });
  }
}
