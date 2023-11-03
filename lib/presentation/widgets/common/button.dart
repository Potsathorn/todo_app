// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:todo_app/presentation/utils/colors.dart';
import 'package:todo_app/presentation/utils/text_style.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final bool isOutlined;
  final double? width;
  final double? height;
  final double? radius;
  final Widget? prefixIcon;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.color = AppColor.colorPrimary,
    this.textColor = AppColor.colorWhite,
    this.isOutlined = false,
    this.borderColor = AppColor.colorGrey,
    this.width,
    this.height,
    this.radius,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? 120,
        height: height ?? 40,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          border: isOutlined ? Border.all(color: borderColor, width: 1) : null,
          borderRadius: BorderRadius.circular(radius ?? 6),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefixIcon != null) prefixIcon ?? const SizedBox.shrink(),
            FittedBox(
              child: Text(
                text,
                style: AppTextStyle.px14MdCustom(color: textColor),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
