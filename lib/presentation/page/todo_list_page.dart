import 'package:flutter/material.dart';
import 'package:todo_app/presentation/utils/colors.dart';
import 'package:todo_app/presentation/utils/text_style.dart';
import 'package:todo_app/presentation/widgets/common/appbar.dart';
import 'package:todo_app/presentation/widgets/todo_card.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.colorBackground[1],
        appBar: CustomAppBar(
          title: Text(
            "Todo List",
            style: AppTextStyle.px22SemiCustom(color: AppColor.colorWhite),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [TodoCard()],
          ),
        ));
  }
}
