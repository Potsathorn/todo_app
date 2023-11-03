import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/presentation/controllers/task_controller.dart';
import 'package:todo_app/presentation/routes/app_routes.dart';
import 'package:todo_app/presentation/utils/colors.dart';
import 'package:todo_app/presentation/utils/global.dart';

import 'package:todo_app/presentation/utils/text_style.dart';
import 'package:todo_app/presentation/widgets/common/appbar.dart';
import 'package:todo_app/presentation/widgets/common/button.dart';
import 'package:todo_app/presentation/widgets/common/search_bar.dart';

import 'package:todo_app/presentation/widgets/todo_card.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TaskController _taskController = Get.find();
  final _searchController = TextEditingController();

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    await _taskController.fetchTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorBackground,
      appBar: CustomAppBar(
        title: Text(
          "Todo List",
          style: AppTextStyle.px22SemiCustom(color: AppColor.colorWhite),
        ),
      ),
      body: Column(
        children: [_buildSearchBar(), _buildTodoCardList(), _buildBtn()],
      ),
    );
  }

  Widget _buildSearchBar() {
    return CustomSearchBar(
      controller: _searchController,
      hintText: 'Title, Description',
      onChanged: (query) {
        setState(() {});
      },
      onTapClear: () {
        _searchController.clear();
        setState(() {});
      },
    );
  }

  Widget _buildTodoCardList() => Expanded(
          child: Obx(
        () => ListView.builder(
            itemCount: _taskController.tasks.length,
            itemBuilder: (BuildContext ctx, int index) {
              return TodoCard(task: _taskController.tasks[index]);
            }),
      ));

  Widget _buildBtn() => Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: AppColor.colorWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: CustomButton(
          text: "CREATE",
          width: ScreenSize.width(context),
          isOutlined: true,
          borderColor: AppColor.colorPrimary,
          color: AppColor.colorPrimary,
          textColor: AppColor.colorWhite,
          onPressed: () {
            Get.toNamed(Routes.task);
          },
        ),
      );
}
