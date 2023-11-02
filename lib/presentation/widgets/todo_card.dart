import 'package:flutter/material.dart';
import 'package:todo_app/presentation/utils/colors.dart';
import 'package:todo_app/presentation/utils/global.dart';
import 'package:todo_app/presentation/utils/text_style.dart';
import 'package:todo_app/presentation/widgets/tag.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(8),
      child: Container(
        color: AppColor.colorWhite,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _row2WidgetAlignment(
              child1: Row(
                children: [
                  CircleAvatar(),
                  AppSizedBox.width4(),
                  Expanded(
                    child: Text(
                      "Do oo oo ms, reload:ms2 ms, reass22",
                      style: AppTextStyle.px16Semi,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            AppSizedBox.height2(),
            _row2WidgetAlignment(
                child1: Text(
              "dsdggsdsg sgsdg",
              style: AppTextStyle.px16Md,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            )),
            Divider(
              color: AppColor.colorGrey[2],
            ),
            _row2WidgetAlignment(
                child2: const Tag(text: StatusTag.COMPLETED),
                child1: Row(
                  children: [
                    Icon(
                      Icons.calendar_month_rounded,
                      size: 20,
                      color: AppColor.colorGrey[1],
                    ),
                    AppSizedBox.width4(),
                    Text(
                      "12/14/2023 14:23",
                      style: AppTextStyle.px16Md,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget _row2WidgetAlignment({Widget? child1, Widget? child2}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: child1 ?? AppSizedBox.empty()),
          child2 ?? AppSizedBox.empty()
        ],
      );
}
