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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _taskController.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: AppColor.colorBackground,
        appBar: CustomAppBar(
          title: Text(
            "appTitle".tr,
            style: AppTextStyle.px22SemiCustom(color: AppColor.colorWhite),
          ),
          actions: [_buildChangeLanguage()],
        ),
        body: InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [_buildSearchBar(), _buildHeader(), _buildTodoCardList()],
          ),
        ),
        bottomNavigationBar: _buildBtn(),
      ),
    );
  }

  Widget _buildSearchBar() {
    return CustomSearchBar(
      controller: _searchController,
      hintText: 'searchHint'.tr,
      onChanged: (query) {
        _taskController.searchQuery = query;
        _taskController.search();
        setState(() {});
      },
      onTapClear: () {
        _searchController.clear();
        _taskController.searchQuery = _searchController.text;
        setState(() {});
      },
    );
  }

  Widget _buildHeader() {
    return Obx(() {
      final tasksList = _taskController.searchQuery.isEmpty
          ? _taskController.tasks
          : _taskController.filteredTasks;
      final allCount = tasksList.length;
      final inProgressCount =
          tasksList.where((e) => e.status == "IN_PROGRESS").toList().length;
      final completedCount =
          tasksList.where((e) => e.status == "COMPLETED").toList().length;
      return Container(
        height: 30,
        width: ScreenSize.width(context),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            //color: AppColor.colorText,
            border: Border(top: BorderSide(color: AppColor.colorGrey[1]!))),
        child: Row(
          children: [
            Expanded(
                child: Text(
              "All ($allCount) | IN_PROGRESS ($inProgressCount) | COMPLETED ($completedCount)",
              style: AppTextStyle.px14MdCustom(color: AppColor.colorText),
            )),
            _buildSort()
          ],
        ),
      );
    });
  }

  Widget _buildTodoCardList() => Expanded(child: Obx(
        () {
          final tasksList = _taskController.searchQuery.isEmpty
              ? _taskController.tasks
              : _taskController.filteredTasks;
          return ListView.builder(
              itemCount: tasksList.length,
              itemBuilder: (BuildContext ctx, int index) {
                return InkWell(
                  onTap: () {
                    _taskController.selectedID = tasksList[index].id ?? "";
                    Get.toNamed(Routes.task);
                  },
                  child: TodoCard(task: tasksList[index]),
                );
              });
        },
      ));

  Widget _buildSort() => Row(
        children: [
          Text(
            "sortBy".tr,
            style: AppTextStyle.px14MdCustom(
              color: AppColor.colorText,
            ),
          ),
          SizedBox(
            width: 15,
            height: 15,
            child: PopupMenuButton<String>(
                icon: const Icon(
                  Icons.arrow_downward_outlined,
                  color: AppColor.colorText,
                  size: 15,
                ),
                color: AppColor.colorWhite,
                padding: EdgeInsets.zero,
                onSelected: (value) {
                  var locale = const Locale('th', 'TH');
                  Get.updateLocale(locale);
                  _taskController.sortBySelected = value;
                  _taskController.sortyBy();
                },
                position: PopupMenuPosition.under,
                itemBuilder: (BuildContext context) {
                  final sortOptions = ['title'.tr, 'date'.tr, 'status'.tr];
                  final List<PopupMenuItem<String>> popupMenuItems =
                      sortOptions.map((String element) {
                    return PopupMenuItem<String>(
                      value: element,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            element,
                            style: AppTextStyle.px16Md,
                          ),
                          if (_taskController.sortBySelected == element)
                            Icon(
                              Icons.check,
                              color: AppColor.colorPrimary[2],
                            )
                        ],
                      ),
                    );
                  }).toList();

                  return popupMenuItems;
                }),
          ),
        ],
      );
  Widget _buildChangeLanguage() => Row(
        children: [
          Text(
            "language".tr,
            style: AppTextStyle.px18MdCustom(
              color: AppColor.colorWhite,
            ),
          ),
          AppSizedBox.width4(),
          SizedBox(
            width: 20,
            height: 20,
            child: PopupMenuButton<String>(
                icon: const Icon(
                  Icons.language_outlined,
                  color: AppColor.colorWhite,
                  size: 20,
                ),
                padding: EdgeInsets.zero,
                color: AppColor.colorWhite,
                onSelected: (value) {
                  if (value == '🇹🇭 ภาษาไทย') {
                    Get.updateLocale(const Locale('th', 'TH'));
                  } else {
                    Get.updateLocale(const Locale('en', 'US'));
                  }
                },
                position: PopupMenuPosition.under,
                itemBuilder: (BuildContext context) {
                  final langOptions = ['🇬🇧 English', '🇹🇭 ภาษาไทย'];
                  final List<PopupMenuItem<String>> popupMenuItems =
                      langOptions.map((String element) {
                    return PopupMenuItem<String>(
                      value: element,
                      child: Text(
                        element,
                        style: AppTextStyle.px16Md,
                      ),
                    );
                  }).toList();

                  return popupMenuItems;
                }),
          ),
          AppSizedBox.width10(),
        ],
      );

  Widget _buildBtn() => Container(
        padding: const EdgeInsets.all(15.0),
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
          text: "create".tr,
          width: ScreenSize.width(context),
          isOutlined: true,
          borderColor: AppColor.colorPrimary,
          color: AppColor.colorPrimary,
          textColor: AppColor.colorWhite,
          onPressed: () {
            _taskController.selectedID = "";
            Get.toNamed(Routes.task);
          },
        ),
      );
}
