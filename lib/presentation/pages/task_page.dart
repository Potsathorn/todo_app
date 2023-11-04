import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:todo_app/data/datasources/local/base64_mock.dart';
import 'package:todo_app/domain/entities/local/task_entity.dart';
import 'package:todo_app/presentation/controllers/task_controller.dart';
import 'package:todo_app/presentation/routes/app_routes.dart';
import 'package:todo_app/presentation/utils/colors.dart';
import 'package:todo_app/presentation/utils/extension/datetime_extendsion.dart';
import 'package:todo_app/presentation/utils/extension/string_extension.dart';
import 'package:todo_app/presentation/utils/global.dart';
import 'package:todo_app/presentation/utils/text_style.dart';

import 'package:todo_app/presentation/widgets/common/appbar.dart';
import 'package:todo_app/presentation/widgets/common/button.dart';
import 'package:todo_app/presentation/widgets/common/text_field.dart';
import 'package:uuid/uuid.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  var uuid = const Uuid();
  final _idController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _createDateController = TextEditingController();
  final _statusController = TextEditingController();
  final TaskController _taskController = Get.find();
  late List<TextEditingController> requiredField;
  final Map<String, String?> _errorMsg = {};

  int selectedImg = -1;

  @override
  void initState() {
    _isCreate() ? _idController.text = uuid.v1() : _initData();
    requiredField = [
      _idController,
      _titleController,
      _createDateController,
      _statusController
    ];
    super.initState();
  }

  bool _isCreate() => _taskController.selectedID.isEmpty;

  void _initData() {
    var selectedTask = _taskController.tasks
        .firstWhere((element) => element.id == _taskController.selectedID);
    _idController.text = selectedTask.id!;
    _titleController.text = selectedTask.title!;
    _descriptionController.text = selectedTask.description!;
    _createDateController.text = selectedTask.createdDate!.toRfc3339String();
    _statusController.text = selectedTask.status!;
    selectedImg = base64Img.indexOf(selectedTask.image!);
  }

  void _showSelectImgDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            color: AppColor.colorWhite,
            padding: const EdgeInsets.all(16),
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              children: List.generate(base64Img.length, (index) {
                return InkWell(
                  onTap: () {
                    selectedImg = index;
                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 100,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColor.colorWhite,
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          image: MemoryImage(base64.decode(base64Img[index]))),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          strokeAlign: BorderSide.strokeAlignOutside,
                          width: selectedImg == index ? 5 : 2,
                          color: selectedImg == index
                              ? AppColor.colorPrimary[2]!
                              : AppColor.colorGrey[8]!),
                    ),
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Task'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: <Widget>[
            CustomButton(
              text: "Back",
              onPressed: () => Get.back(),
              color: AppColor.colorGrey[4]!,
              textColor: AppColor.colorText,
            ),
            CustomButton(
              text: "OK",
              onPressed: () async {
                await _taskController.deleteTaskEntity(_idController.text);
                Get.offAndToNamed(Routes.todoList);
              },
            ),
          ],
        );
      },
    );
  }

  bool _validator() {
    _errorMsg.clear();
    for (var element in requiredField) {
      if (element.text.isEmpty) {
        _errorMsg[element.hashCode.toString()] = "Please input data";
      } else {
        _errorMsg[element.hashCode.toString()] = null;
      }
    }
    return requiredField.every((element) => element.text.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: AppColor.colorBackground[1],
        appBar: CustomAppBar(
          title: Text(
            _isCreate() ? "Create Task" : "Update Task",
            style: AppTextStyle.px22SemiCustom(color: AppColor.colorWhite),
          ),
          actions: [if (!_isCreate()) _buildDelete()],
        ),
        body: InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildImage(),
                  _idField(),
                  AppSizedBox.height16(),
                  _titleField(),
                  AppSizedBox.height16(),
                  _descriptionField(),
                  AppSizedBox.height16(),
                  _dateTimeField(),
                  AppSizedBox.height16(),
                  _statusField()
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomSheet(),
      ),
    );
  }

  Widget _buildDelete() => IconButton(
      onPressed: () async {
        _showDeleteConfirmationDialog(context);
      },
      icon: const Icon(
        Icons.delete_forever_outlined,
        color: AppColor.colorWhite,
      ));

  Widget _buildImage() => Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: ScreenSize.width(context) / 2.5,
            height: ScreenSize.width(context) / 2.5,
            decoration: BoxDecoration(
              image: selectedImg == -1
                  ? null
                  : DecorationImage(
                      fit: BoxFit.contain,
                      image:
                          MemoryImage(base64.decode(base64Img[selectedImg]))),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  strokeAlign: BorderSide.strokeAlignOutside,
                  width: 5,
                  color: selectedImg == -1
                      ? AppColor.colorGrey[8]!
                      : AppColor.colorPrimary[2]!),
            ),
            child: selectedImg != -1
                ? null
                : Icon(
                    Icons.image,
                    size: ScreenSize.width(context) / 3,
                    color: AppColor.colorGrey[8],
                  ),
          ),
          CustomButton(
            text: "Select Image",
            width: ScreenSize.width(context) / 2.5,
            isOutlined: true,
            borderColor: AppColor.colorPrimary,
            color: AppColor.colorPrimary,
            textColor: AppColor.colorWhite,
            onPressed: () {
              _showSelectImgDialog(context);
            },
          ),
        ],
      );

  Widget _idField() => CustomTextField(
        controller: _idController,
        errorText: _errorMsg[_idController.hashCode.toString()],
        onChanged: (_) {
          _errorMsg[_idController.hashCode.toString()] = null;
          setState(() {});
        },
        label: 'ID',
        isRequired: true,
        maxLength: 40,
        style: TextFieldStyle.normal,
      );

  Widget _titleField() => CustomTextField(
        controller: _titleController,
        errorText: _errorMsg[_titleController.hashCode.toString()],
        onChanged: (_) {
          _errorMsg[_titleController.hashCode.toString()] = null;
          setState(() {});
        },
        label: 'Title',
        isRequired: true,
        maxLength: 100,
        style: TextFieldStyle.outline,
      );

  Widget _descriptionField() => CustomTextField(
        controller: _descriptionController,
        label: 'Description',
        maxLine: 3,
        isTextBox: true,
        style: TextFieldStyle.outline,
      );
  Widget _dateTimeField() => CustomTextField(
        controller: _createDateController,
        errorText: _errorMsg[_createDateController.hashCode.toString()],
        label: 'Date',
        isRequired: true,
        pickTime: true,
        onConfirmDateTime: (value) {
          log(value.toString());
          if (value != null) {
            _createDateController.text = value.toRfc3339String();
            _errorMsg[_createDateController.hashCode.toString()] = null;
          }
          setState(() {});
        },
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365 * 100)),
        style: TextFieldStyle.calendar,
      );
  Widget _statusField() => CustomTextField(
        controller: _statusController,
        errorText: _errorMsg[_statusController.hashCode.toString()],
        label: 'Status',
        isRequired: true,
        style: TextFieldStyle.dropdown,
        items: [
          DropdownInputItem("IN_PROGRESS", "IN_PROGRESS"),
          DropdownInputItem("COMPLETED", "COMPLETED"),
        ],
        onChangedDropdown: (value) {
          _statusController.text = value;
          _errorMsg[_statusController.hashCode.toString()] = null;
          setState(() {});
        },
      );

  Widget _buildBottomSheet() => Container(
        padding: const EdgeInsets.all(15),
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
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                text: "Back",
                onPressed: () => Get.back(),
                color: AppColor.colorGrey[4]!,
                textColor: AppColor.colorText,
              ),
            ),
            AppSizedBox.width10(),
            Expanded(
                child: CustomButton(
              text: _isCreate() ? "Create" : "Update",
              onPressed: () {
                if (_validator()) {
                  final task = TaskEntity(
                      id: _idController.text,
                      title: _titleController.text,
                      description: _descriptionController.text,
                      createdDate:
                          _createDateController.text.toDateTimeFromRfc3339(),
                      image: selectedImg == -1 ? "" : base64Img[selectedImg],
                      status: _statusController.text);
                  _isCreate()
                      ? _taskController.insertTask(task)
                      : _taskController.updateTaskEntity(task);
                  Get.offAndToNamed(Routes.todoList);
                }

                setState(() {});
              },
            ))
          ],
        ),
      );
}
