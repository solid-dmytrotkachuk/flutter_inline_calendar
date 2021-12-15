import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inline_calendar/src/cubit/calendar_cubit.dart';
import 'package:inline_calendar/src/inline_calendar_page_view.dart';

class InlineCalendar extends StatelessWidget {
  final int maxWeeks = 12;
  final void Function(DateTime)? onChange;
  final DateTime? selectedDate;
  final CalendarCubit? controller;

  InlineCalendar({
    Key? key,
    this.onChange,
    this.controller,
    this.selectedDate
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = this.controller;
    if (controller == null) {
      return BlocProvider(
        create: (_) => CalendarCubit(),
        child: _buildInlineCalendar(),
      );
    }

    return BlocProvider.value(
      value: controller,
      child: _buildInlineCalendar(),
    );
  }

  Widget _buildInlineCalendar(){
    return InlineCalendarPageView(
      key: key,
      onChange: this.onChange,
      maxWeeks: this.maxWeeks,
      selectedDate: selectedDate,
      height: 80,
      middleWeekday: 4,
    );
  }
}
