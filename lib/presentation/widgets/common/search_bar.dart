// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:todo_app/presentation/utils/colors.dart';
import 'package:todo_app/presentation/utils/global.dart';
import 'package:todo_app/presentation/widgets/common/text_field.dart';

class CustomSearchBar extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final dynamic Function(String)? onChanged;
  final void Function()? onTapClear;

  const CustomSearchBar(
      {super.key,
      this.controller,
      this.onChanged,
      this.onTapClear,
      this.hintText});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64, //64
      width: ScreenSize.width(context),
      color: AppColor.colorText,
      padding: const EdgeInsets.all(8),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: CustomTextField(
            controller: widget.controller,
            style: TextFieldStyle.search,
            hintText: widget.hintText,
            onChanged: widget.onChanged,
            prefixIcon: Icon(
              Icons.search,
              size: 24,
              color: AppColor.colorGrey[1],
            ),
          ),
        ),
        if (widget.controller != null &&
            widget.controller!.text.isNotEmpty) ...[
          const SizedBox(
            width: 4,
          ),
          _buildCloseBtn()
        ]
      ]),
    );
  }

  Widget _buildCloseBtn() {
    return GestureDetector(
      onTap: widget.onTapClear,
      child: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: AppColor.colorPrimary,
            borderRadius: BorderRadius.circular(6),
          ),
          alignment: Alignment.center,
          child: const Icon(
            Icons.close_rounded,
            color: AppColor.colorWhite,
            size: 24,
          )),
    );
  }
}
