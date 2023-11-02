// Flutter imports:
import 'package:flutter/material.dart';
import 'package:todo_app/presentation/utils/colors.dart';
import 'package:todo_app/presentation/utils/global.dart';

// Project imports:
import 'package:todo_app/presentation/utils/text_style.dart';

class Tag extends StatelessWidget {
  final StatusTag text;
  final Color? color;
  final Color? textColor;

  const Tag({
    Key? key,
    required this.text,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      decoration: BoxDecoration(
        color: color ?? backgroundColor(),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text == StatusTag.IN_PROGRESS ? "IN_PROGRESS" : "COMPLETED",
        style: AppTextStyle.px14MdCustom(color: textColor ?? titleColor()),
      ),
    );
  }

  Color backgroundColor() {
    switch (text) {
      case StatusTag.IN_PROGRESS:
        return AppColor.colorPrimary[3]!.withOpacity(0.2);
      default:
        return AppColor.colorPrimary[2]!.withOpacity(0.2);
    }
  }

  Color titleColor() {
    switch (text) {
      case StatusTag.IN_PROGRESS:
        return AppColor.colorPrimary[3]!;
      default:
        return AppColor.colorPrimary[2]!;
    }
  }
}
