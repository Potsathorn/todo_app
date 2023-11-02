import 'package:flutter/material.dart';
import 'package:todo_app/presentation/utils/colors.dart';
import 'package:todo_app/presentation/utils/text_style.dart';
import 'package:todo_app/presentation/widgets/common/appbar.dart';
import 'package:todo_app/presentation/widgets/common/search_bar.dart';
import 'package:todo_app/presentation/widgets/todo_card.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final _searchController = TextEditingController();

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
            children: [_buildSearchBar(), TodoCard()],
          ),
        ));
  }

  Widget _buildSearchBar() {
    return CustomSearchBar(
      controller: _searchController,
      hintText: 'Title, Description',
      onChanged: (query) {
        setState(() {});
      },
      onTapClear: () {
        _searchController.clear();
        setState(() {});
      },
    );
  }
}
