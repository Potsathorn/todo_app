import 'package:get/instance_manager.dart';
import 'package:todo_app/data/datasources/local/local_datasource.dart';
import 'package:todo_app/data/repositories/task_repository_impl.dart';
import 'package:todo_app/domain/repositories/task_repository.dart';
import 'package:todo_app/domain/usecases/task_usecase.dart';
import 'package:todo_app/presentation/controllers/task_controller.dart';

class Injection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TaskController(Get.find()), fenix: true);

    Get.lazyPut(() => TaskUsecase(Get.find()));

    Get.lazyPut<TaskRepository>(() => TaskRepositoryImpl(Get.find()));

    Get.lazyPut<LocalDataSource>(() => LocalDataSourceImpl());
  }
}
