import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inline_calendar/inline_calendar.dart';
import 'package:inline_calendar/src/utilities.dart';
import 'package:intl/intl.dart';

import 'calendar_day_tile.dart';
import 'cubit/calendar_cubit.dart';

class InlineCalendarRows extends StatelessWidget {
  final DateTime middleDate;
  final int pageNumber;
  final Locale locale;
  final void Function(DateTime) onChange;

  InlineCalendarRows({
    Key? key,
    required this.middleDate,
    required this.pageNumber,
    required this.locale,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _buildDayTiles(locale, context),
    );
  }

  List<InlineCalendarTile> _buildDayTiles(
      Locale locale,
      BuildContext context,
      ) {
    List<InlineCalendarTile> tiles = [];
    for (int i = 0; i < 7; i++) {
      final DateTime dateTime = safeAdd(middleDate, Duration(days: i - 3));
      final String monthLabel =
      DateFormat.MMM(locale.toLanguageTag()).format(dateTime);
      final int dayOfMonth = dateTime.day;

      tiles.add(
        InlineCalendarTile(
          onTap: () {
            context.read<CalendarCubit>().selectedDate = dateTime;
            final onChange = this.onChange;
            if (onChange != null) {
              onChange(dateTime);
            }
          },
          monthDay: dayOfMonth,
          isToday: isSameDate(dateTime, DateTime.now()),
          tileDate: removeTimeFrom(dateTime),
          title: monthLabel.toUpperCase(),
        ),
      );
    }

    return tiles;
  }
}
