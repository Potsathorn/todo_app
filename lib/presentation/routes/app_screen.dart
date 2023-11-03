import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:todo_app/presentation/pages/task_page.dart';
import 'package:todo_app/presentation/pages/todo_list_page.dart';
import 'package:todo_app/presentation/routes/app_routes.dart';

class AppScreen {
  static const initial = Routes.initial;

  static final routes = [
    GetPage(
        name: Routes.todoList,
        page: () => const TodoListPage(),
        transition: Transition.circularReveal,
        children: [
          GetPage(
            name: '/task',
            page: () => const TaskPage(),
          ),
        ]),
  ];
}
