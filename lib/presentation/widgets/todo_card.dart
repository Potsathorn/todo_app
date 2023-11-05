import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/domain/entities/local/task_entity.dart';
import 'package:todo_app/presentation/utils/colors.dart';
import 'package:todo_app/presentation/utils/extension/datetime_extendsion.dart';
import 'package:todo_app/presentation/utils/global.dart';
import 'package:todo_app/presentation/utils/text_style.dart';
import 'package:todo_app/presentation/widgets/tag.dart';

class TodoCard extends StatelessWidget {
  final TaskEntity task;
  const TodoCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            color: AppColor.colorWhite,
            border: Border(
                left: BorderSide(color: AppColor.colorPrimary, width: 10))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildImgAndTitle(),
            _buildDescription(),
            _buildTimeAndStatus()
          ],
        ),
      ),
    );
  }

  Widget _buildImgAndTitle() => _row2WidgetAlignment(
        child1: Row(
          children: [
            if (task.image!.isNotEmpty) ...[
              CircleAvatar(
                backgroundColor: AppColor.colorPrimary[4],
                child: Image.memory(
                  base64.decode(task.image!),
                  width: 30,
                  height: 30,
                ),
              ),
              AppSizedBox.width4(),
            ],
            Expanded(
              child: Text(
                task.title!,
                style: AppTextStyle.px16Semi,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );

  Widget _buildDescription() => task.description!.isNotEmpty
      ? Padding(
          padding: const EdgeInsets.only(top: 2),
          child: _row2WidgetAlignment(
              child1: Text(
            task.description!,
            style: AppTextStyle.px16Md,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          )),
        )
      : AppSizedBox.empty();

  Widget _buildTimeAndStatus() => Column(
        children: [
          Divider(
            color: AppColor.colorGrey[2],
          ),
          _row2WidgetAlignment(
              child2: Tag(
                  text: task.status == "COMPLETED"
                      ? StatusTag.COMPLETED
                      : StatusTag.IN_PROGRESS),
              child1: Row(
                children: [
                  Icon(
                    Icons.calendar_month_rounded,
                    size: 20,
                    color: AppColor.colorGrey[1],
                  ),
                  AppSizedBox.width4(),
                  Expanded(
                    child: Text(
                      task.createdDate!.toRfc3339String(),
                      style: AppTextStyle.px16Md,
                    ),
                  )
                ],
              )),
        ],
      );

  Widget _row2WidgetAlignment({Widget? child1, Widget? child2}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: child1 ?? AppSizedBox.empty()),
          child2 ?? AppSizedBox.empty()
        ],
      );
}
