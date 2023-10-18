import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../../router/router.dart';
import '../../utils/palette.dart';
import 'button_orange.dart';
import 'button_orange_bk.dart';

class BaseDatePicker extends StatefulWidget {
  const BaseDatePicker({super.key, this.restorationId});

  final String? restorationId;

  @override
  State<BaseDatePicker> createState() => _BaseDatePickerState();
}

/// RestorationProperty objects can be used because of RestorationMixin.
class _BaseDatePickerState extends State<BaseDatePicker> with RestorationMixin {
  // In this example, the restoration ID for the mixin is passed in through
  // the [StatefulWidget]'s constructor.
  String? _eatDate;

  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2023),
          lastDate: DateTime(2024),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        _eatDate =
            '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        // color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "THỜI GIAN ĂN",
                  style: TextStyle(
                      color: primaryColor, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text('sáng ${_eatDate ?? ''}',
                        style: TextStyle(color: Color(0xFF676767))),
                    Icon(Icons.arrow_drop_down)
                  ],
                )
              ],
            ),
            Container(
              width: 200,
              height: 50,
              child: ButtonOrangeBK(
                  title: "Chọn ngày",
                  icon: Icons.calendar_today_outlined,
                  onPressed: () async {
                    _restorableDatePickerRouteFuture.present();
                    // DateTime? date = await showDatePicker(
                    //   context: context,
                    //   initialEntryMode: DatePickerEntryMode.calendarOnly,
                    //   initialDate: DateTime(2023),
                    //   firstDate: DateTime(2023),
                    //   lastDate: DateTime(2024),
                    //   builder: (context, child) {
                    //     return Theme(
                    //       data: Theme.of(context).copyWith(
                    //         colorScheme: ColorScheme.light(
                    //           primary: Colors.yellow, // header background color
                    //           onPrimary: Colors.black, // header text color
                    //           onSurface: Colors.green, // body text color
                    //         ),
                    //         textButtonTheme: TextButtonThemeData(
                    //           style: TextButton.styleFrom(
                    //             foregroundColor:
                    //                 Colors.red, // button text color
                    //           ),
                    //         ),
                    //       ),
                    //       child: child!,
                    //     );
                    //   },
                    // );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
