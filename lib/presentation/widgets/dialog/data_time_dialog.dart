// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:todo_app/presentation/utils/colors.dart';

pickDateTimeDialog(
  BuildContext context, {
  required Function(DateTime?) onConfirm,
  DateTime? initDate,
  DateTime? firstDate,
  DateTime? lastDate,
  bool? pickTime = true,
}) {
  showDatePicker(
    context: context,
    initialDate: initDate ?? DateTime.now(),
    firstDate: firstDate ?? DateTime.now(),
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    lastDate: lastDate ??
        DateTime.now().add(
          const Duration(days: 360),
        ),
    initialDatePickerMode: DatePickerMode.day,
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColor.colorPrimary,
            onBackground: AppColor.colorWhite,
          ),
          datePickerTheme: const DatePickerThemeData(
            headerBackgroundColor: AppColor.colorPrimary,
            backgroundColor: AppColor.colorWhite,
            headerForegroundColor: AppColor.colorWhite,
          ),
        ),
        child: child!,
      );
    },
  ).then(
    (pickedDate) {
      if (pickedDate != null) {
        onConfirm(pickedDate);
      }
      if (pickedDate == null) {
        return;
      }
      if (pickTime == true) {
        _pickTimeDialog(
          context,
          pickedDate,
          initDate,
          onConfirm: (value) {
            onConfirm(value);
          },
        );
      }
    },
  );
}

void _pickTimeDialog(
  BuildContext context,
  DateTime dateTime,
  DateTime? initDate, {
  required Function(DateTime?) onConfirm,
}) {
  showTimePicker(
          context: context,
          initialTime: initDate != null
              ? TimeOfDay.fromDateTime(initDate)
              : TimeOfDay.now(),
          builder: (context, childWidget) {
            return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                    // Using 24-Hour format
                    alwaysUse24HourFormat: true),
                // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
                child: childWidget!);
          }
          //which date will display when user open the picker
          ) //what will be the up to supported date in picker
      .then(
    (pickedTime) {
      //then usually do the future job
      if (pickedTime == null) {
        //if user tap cancel then this function will stop
        return;
      }
      //for rebuilding the ui
      DateTime result = DateTime(dateTime.year, dateTime.month, dateTime.day,
          pickedTime.hour, pickedTime.minute);
      onConfirm(result);
    },
  );
}
