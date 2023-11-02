import 'package:flutter/material.dart';
import 'package:todo_app/presentation/utils/colors.dart';

class AppTextStyle {
  static const TextStyle px22Semi = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColor.colorText,
  );

  static const TextStyle px24Semi = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColor.colorText,
  );

  static TextStyle px24SemiCustom({
    Color color = AppColor.colorPrimary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
    TextDecorationStyle? decorationStyle,
  }) {
    return TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: color,
      fontStyle: fontStyle,
      decoration: decoration,
      decorationStyle: decorationStyle,
    );
  }

  static TextStyle px22SemiCustom({
    Color color = AppColor.colorPrimary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
    TextDecorationStyle? decorationStyle,
  }) {
    return TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: color,
      fontStyle: fontStyle,
      decoration: decoration,
      decorationStyle: decorationStyle,
    );
  }

  static const TextStyle px18Md = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColor.colorText,
  );

  static TextStyle px18MdCustom({
    Color color = AppColor.colorPrimary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
    TextDecorationStyle? decorationStyle,
  }) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: color,
      fontStyle: fontStyle,
      decoration: decoration,
      decorationStyle: decorationStyle,
      decorationColor: color,
    );
  }

  static const TextStyle px16Semi = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColor.colorText,
    fontFamily: 'SukhumvitSet',
  );

  static TextStyle px16SemiCustom({
    Color color = AppColor.colorPrimary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
    TextDecorationStyle? decorationStyle,
  }) {
    return TextStyle(
      fontFamily: 'SukhumvitSet',
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: color,
      fontStyle: fontStyle,
      decoration: decoration,
      decorationStyle: decorationStyle,
    );
  }

  static const TextStyle px14w400 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColor.colorText,
  );

  static const TextStyle px16Md = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColor.colorText,
  );

  static TextStyle px16MdCustom({
    Color color = AppColor.colorPrimary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
    TextDecorationStyle? decorationStyle,
  }) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: color,
      fontStyle: fontStyle,
      decoration: decoration,
      decorationColor: color,
      decorationStyle: decorationStyle,
    );
  }

  static const TextStyle px14Md = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColor.colorText,
  );

  static TextStyle px14MdCustom({
    Color color = AppColor.colorPrimary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
    TextDecorationStyle? decorationStyle,
  }) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: color,
      fontStyle: fontStyle,
      decoration: decoration,
      decorationStyle: decorationStyle,
      fontFamily: 'SukhumvitSet',
    );
  }
}
