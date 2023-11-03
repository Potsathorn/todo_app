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

  int selectedImg = -1;

  @override
  void initState() {
    _idController.text = uuid.v1();
    super.initState();
  }

  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            color: AppColor.colorWhite,
            padding: const EdgeInsets.all(16),
            child: GridView.count(
              crossAxisCount: 3, // 3 columns
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorBackground[1],
      appBar: CustomAppBar(
        title: Text(
          "Create Task",
          style: AppTextStyle.px22SemiCustom(color: AppColor.colorWhite),
        ),
        actions: [
          InkWell(
            onTap: () async {
              await _taskController
                  .insertTask(TaskEntity(
                      id: _idController.text,
                      title: _titleController.text,
                      description: _descriptionController.text,
                      createdDate:
                          _createDateController.text.toDateTimeFromRfc3339(),
                      image: base64Img[selectedImg],
                      status: _statusController.text))
                  .then((_) {
                Get.offAndToNamed(Routes.todoList);
              });
            },
            child: const Icon(
              Icons.save,
              color: AppColor.colorWhite,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
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
    );
  }

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
              _taskController.tasks.clear();
              _taskController.fetchTask();
              _showCustomDialog(context);
            },
          ),
        ],
      );

  Widget _idField() => CustomTextField(
        controller: _idController,
        label: 'ID',
        isRequired: true,
        maxLength: 40,
        style: TextFieldStyle.normal,
      );

  Widget _titleField() => CustomTextField(
        controller: _titleController,
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
        maxLength: 40,
        style: TextFieldStyle.outline,
      );
  Widget _dateTimeField() => CustomTextField(
        controller: _createDateController,
        label: 'Created At Date Time',
        isRequired: true,
        pickTime: true,
        onConfirmDateTime: (value) {
          log(value.toString());
          if (value != null) {
            _createDateController.text = value.toRfc3339String();
          }
          setState(() {});
        },
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365 * 100)),
        style: TextFieldStyle.calendar,
      );
  Widget _statusField() => CustomTextField(
        controller: _statusController,
        label: 'Status',
        isRequired: true,
        style: TextFieldStyle.dropdown,
        items: [
          DropdownInputItem("IN_PROGRESS", "IN_PROGRESS"),
          DropdownInputItem("COMPLETED", "COMPLETED"),
        ],
        onChangedDropdown: (value) {
          _statusController.text = value;
          setState(() {});
        },
      );
}
