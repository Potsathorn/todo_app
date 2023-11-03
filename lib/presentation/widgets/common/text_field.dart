// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Project imports:
import 'package:todo_app/presentation/utils/colors.dart';
import 'package:todo_app/presentation/utils/global.dart';
import 'package:todo_app/presentation/utils/text_field_formatter/text_field_formatter.dart';
import 'package:todo_app/presentation/utils/text_style.dart';
import 'package:todo_app/presentation/widgets/dialog/data_time_dialog.dart';

// Package imports:

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final String? errorText;
  final String? tooltip;
  final bool readOnly;
  final bool showMark;
  final TextFieldStyle? style;
  final bool isTextBox;
  final bool isRequired;
  final bool obscureText;
  final String? regexPattern;
  final Widget? suffixIcon;
  final Widget? suffixOutlineIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function()? onEditingComplete;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final bool enabled;
  final bool? isEnabled;
  final bool pickTime;
  final Function(DateTime?)? onConfirmDateTime;
  final DateTime? initDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final int minLine;
  final int? maxLine;
  final int? maxLength;
  final double? width;
  final bool isCurrency;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChangedDropdown;
  final List<DropdownInputItem>? items;

  const CustomTextField({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.errorText,
    this.isRequired = false,
    this.obscureText = false,
    this.regexPattern,
    this.keyboardType,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.style = TextFieldStyle.outline,
    this.onChanged,
    this.onEditingComplete,
    this.focusNode,
    this.onFieldSubmitted,
    this.suffixOutlineIcon,
    this.isTextBox = false,
    this.readOnly = false,
    this.showMark = false,
    this.enabled = true,
    this.isCurrency = false,
    this.onConfirmDateTime,
    this.pickTime = true,
    this.initDate,
    this.firstDate,
    this.lastDate,
    this.isEnabled,
    this.minLine = 3,
    this.maxLine,
    this.maxLength,
    this.width,
    this.tooltip,
    this.inputFormatters,
    this.onChangedDropdown,
    this.items,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  void _openBottomSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return DropdownModalPopup(
          title: widget.label,
          items: widget.items!,
          onChanged: widget.onChangedDropdown,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.label != null)
          Row(
            children: [
              Expanded(
                  child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: widget.label,
                      style: widget.style == TextFieldStyle.plain
                          ? AppTextStyle.px16Md
                          : AppTextStyle.px16Semi,
                    ),
                    if (widget.isRequired)
                      TextSpan(
                        text: '*',
                        style: AppTextStyle.px14MdCustom(
                          color: AppColor.colorPrimary,
                        ),
                      ),
                  ],
                ),
              )),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        widget.isTextBox
            ? TextField(
                maxLength: widget.maxLength,
                enabled: widget.enabled,
                controller: widget.controller,
                readOnly: widget.readOnly,
                keyboardType: widget.keyboardType,
                focusNode: widget.focusNode,
                maxLines: widget.minLine,
                onEditingComplete: widget.onEditingComplete,
                style: _textStyle(),
                decoration: InputDecoration(
                  counter: const SizedBox.shrink(),
                  prefixIcon: widget.prefixIcon,
                  hintText: widget.hintText,
                  hintStyle:
                      AppTextStyle.px16MdCustom(color: AppColor.colorGrey[1]!),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  enabledBorder: widget.readOnly ? null : _borderStyle(),
                  disabledBorder: _borderStyleDisable(),
                  filled: true,
                  fillColor:
                      widget.enabled ? _fillColor() : AppColor.colorBackground,
                  focusedBorder: widget.readOnly
                      ? null
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                              const BorderSide(color: AppColor.colorPrimary),
                        ),
                  border: _borderStyle(),
                  suffixIcon: widget.suffixIcon,
                ),
                inputFormatters: [
                  if (widget.regexPattern != null)
                    FilteringTextInputFormatter.allow(
                        RegExp(widget.regexPattern!)),
                  if (widget.maxLength != null)
                    LengthLimitingTextFieldFormatterFixed(
                        maxLength: widget.maxLength!),
                ],
                onChanged: widget.onChanged,
              )
            : widget.enabled
                ? GestureDetector(
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());

                      if (widget.style == TextFieldStyle.dropdown &&
                          widget.items != null) {
                        _openBottomSheet(context);
                      }

                      if (widget.style == TextFieldStyle.calendar &&
                          widget.onConfirmDateTime != null) {
                        pickDateTimeDialog(
                          context,
                          pickTime: widget.pickTime,
                          firstDate: widget.firstDate,
                          lastDate: widget.lastDate,
                          initDate: widget.initDate,
                          onConfirm: widget.onConfirmDateTime!,
                        );
                      }
                    },
                    child: SizedBox(
                      height: 47,
                      width: widget.width,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              enabled: widget.isEnabled ?? _enabled(),
                              readOnly: widget.readOnly,
                              controller: widget.controller,
                              keyboardType: widget.keyboardType,
                              obscureText: widget.obscureText,
                              focusNode: widget.focusNode,
                              onEditingComplete: widget.onEditingComplete,
                              style: _textStyle(),
                              decoration: InputDecoration(
                                  counterText: "",
                                  prefixIcon: widget.prefixIcon,
                                  hintText: widget.hintText,
                                  hintStyle: AppTextStyle.px16MdCustom(
                                      color: AppColor.colorGrey[1]!),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 8),
                                  enabledBorder: _borderStyle(),
                                  disabledBorder: _borderStyle(),
                                  filled: true,
                                  fillColor: _fillColor(),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                        color: AppColor.colorPrimary),
                                  ),
                                  //border: _borderStyle(),
                                  suffixIcon: _suffixIcon()),
                              inputFormatters: [
                                if (widget.maxLength != null)
                                  LengthLimitingTextFieldFormatterFixed(
                                      maxLength: widget.maxLength!),
                                if (widget.inputFormatters != null)
                                  ...widget.inputFormatters!,
                              ],
                              onChanged: widget.onChanged,
                              onFieldSubmitted: widget.onFieldSubmitted,
                              validator: widget.validator,
                            ),
                          ),
                          if (widget.suffixOutlineIcon != null)
                            SizedBox(
                              width: 30,
                              child: widget.suffixOutlineIcon!,
                            ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    alignment: Alignment.centerLeft,
                    height: 44,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColor.colorBackground,
                      border: Border.all(
                        color: AppColor.colorBackground,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        widget.hintText ?? '',
                        style: AppTextStyle.px16MdCustom(
                            color: AppColor.colorGrey[1]!),
                      ),
                    ),
                  ),
        if (widget.errorText != null && widget.errorText != "") ...[
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 4),
                  color: AppColor.colorSecondary[1],
                  child: Text(
                    widget.errorText!,
                    //'กรุณาระบุข้อมูล',
                    style: AppTextStyle.px14MdCustom(
                        color: AppColor.colorPrimary[1]!),
                  ),
                ),
              ),
              if (widget.suffixOutlineIcon != null)
                const SizedBox(
                  width: 30,
                ),
            ],
          ),
        ],
      ],
    );
  }

  Widget? _suffixIcon() {
    switch (widget.style) {
      case TextFieldStyle.dropdownFix:
      case TextFieldStyle.dropdown:
        return Icon(
          Icons.expand_more,
          color: AppColor.colorBlack.withOpacity(0.25),
        );
      case TextFieldStyle.calendar:
      case TextFieldStyle.calendarFix:
        return Icon(
          Icons.calendar_month_rounded,
          color: AppColor.colorBlack.withOpacity(0.25),
        );
      default:
        return widget.suffixIcon;
    }
  }

  TextStyle? _textStyle() {
    switch (widget.style) {
      case TextFieldStyle.normal:
      case TextFieldStyle.dropdownFix:
      case TextFieldStyle.calendarFix:
        return AppTextStyle.px16MdCustom(color: AppColor.colorGrey[1]!);
      case TextFieldStyle.plain:
        return AppTextStyle.px16Semi;
      default:
        return AppTextStyle.px16Md;
    }
  }

  bool? _enabled() {
    switch (widget.style) {
      case TextFieldStyle.dropdownFix:
      case TextFieldStyle.calendarFix:
      case TextFieldStyle.normal:
      case TextFieldStyle.calendar:
      case TextFieldStyle.dropdown:
      case TextFieldStyle.address:
        return false;
      default:
        return true;
    }
  }

  InputBorder? _borderStyleDisable() {
    switch (widget.style) {
      case TextFieldStyle.plain:
      case TextFieldStyle.search:
      case TextFieldStyle.dropdownFix:
      case TextFieldStyle.calendarFix:
        return OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: const BorderSide(color: Colors.transparent));
      case TextFieldStyle.normal:
        return OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: AppColor.colorGrey[8]!));
      case TextFieldStyle.underline:
        return UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.colorGrey[3]!));
      case TextFieldStyle.outline:
      case TextFieldStyle.calendar:
      case TextFieldStyle.address:
      case TextFieldStyle.dropdown:
        return OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: AppColor.colorGrey[3]!));
      default:
        return OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: AppColor.colorGrey[3]!));
    }
  }

  InputBorder? _borderStyle() {
    switch (widget.style) {
      case TextFieldStyle.plain:
      case TextFieldStyle.search:
      case TextFieldStyle.normal:
      case TextFieldStyle.dropdownFix:
      case TextFieldStyle.calendarFix:
        return OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: const BorderSide(color: Colors.transparent));
      case TextFieldStyle.underline:
        return UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.colorGrey[3]!));
      case TextFieldStyle.outline:
      case TextFieldStyle.calendar:
      case TextFieldStyle.address:
      case TextFieldStyle.dropdown:
        return OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: AppColor.colorGrey[2]!));
      default:
        return OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: AppColor.colorGrey[2]!));
    }
  }

  Color? _fillColor() {
    switch (widget.style) {
      case TextFieldStyle.plain:
        return Colors.transparent;
      case TextFieldStyle.normal:
      case TextFieldStyle.dropdownFix:
      case TextFieldStyle.calendarFix:
        return AppColor.colorGrey[4];
      case TextFieldStyle.underline:
        return Colors.transparent;
      case TextFieldStyle.outline:
      case TextFieldStyle.dropdown:
      case TextFieldStyle.address:
      case TextFieldStyle.calendar:
        return AppColor.colorWhite;
      case TextFieldStyle.search:
        return AppColor.colorWhite;
      default:
        return AppColor.colorWhite;
    }
  }
}

class DropdownModalPopup extends StatefulWidget {
  const DropdownModalPopup({
    Key? key,
    this.value,
    required this.items,
    this.onChanged,
    this.title,
  }) : super(key: key);

  final String? value;
  final List<DropdownInputItem> items;
  final void Function(String value)? onChanged;
  final String? title;

  @override
  State<DropdownModalPopup> createState() => _DropdownModalPopupState();
}

class _DropdownModalPopupState extends State<DropdownModalPopup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            color: Colors.transparent,
            child: SizedBox(
              width: double.infinity,
              height: 48.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      widget.title ?? '',
                      style: AppTextStyle.px24Semi,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      iconSize: 48.0,
                      splashRadius: 18.0,
                      splashColor: AppColor.colorBlack.withOpacity(0.1),
                      highlightColor: AppColor.colorBlack.withOpacity(0.1),
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.close,
                        color: AppColor.colorBlack.withOpacity(0.25),
                        size: 24.0,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            thickness: 0.5,
            color: AppColor.colorGrey[3]!,
          ),
          Material(
            color: AppColor.colorWhite,
            surfaceTintColor: AppColor.colorWhite,
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: false,
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        widget.items[index].label,
                        style: AppTextStyle.px16Md,
                      ),
                      onTap: () {
                        widget.onChanged?.call(widget.items[index].value);
                        Navigator.pop(context);
                      },
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}

class DropdownInputItem {
  final String label;
  final String value;

  DropdownInputItem(
    this.label,
    this.value,
  );
}
