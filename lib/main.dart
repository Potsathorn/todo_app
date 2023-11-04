import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:todo_app/data/datasources/local/local_datasource.dart';
import 'package:todo_app/dependency_injection.dart';

import 'package:todo_app/presentation/pages/todo_list_page.dart';
import 'package:todo_app/presentation/routes/app_screen.dart';
import 'package:todo_app/presentation/utils/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Injection injection = Injection();
  injection.dependencies();
  await LocalDataSource.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todo List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SukhumvitSet',
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return AppColor.colorPrimary[2]!; // Active (selected) color
              }
              return AppColor.colorGrey[3]!; // Inactive color
            },
          ),
        ),
        checkboxTheme: CheckboxThemeData(shape: RoundedRectangleBorder(
            side: MaterialStateBorderSide.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return BorderSide(color: AppColor.colorPrimary[2]!); // Active color
          } else {
            return BorderSide(color: AppColor.colorGrey[3]!); // Inactive color
          }
        }))),
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.colorPrimary),
        useMaterial3: false,
      ),
      home: const TodoListPage(),
      getPages: AppScreen.routes,
    );
  }
}
