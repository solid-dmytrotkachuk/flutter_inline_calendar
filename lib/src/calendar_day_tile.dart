import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inline_calendar/src/utilities.dart';

import 'cubit/calendar_cubit.dart';

class InlineCalendarTile extends StatelessWidget {
  final void Function() onTap;

  final int monthDay;
  final bool isToday;
  final String title;
  final DateTime tileDate;

  const InlineCalendarTile({
    Key? key,
    required this.onTap,
    required this.monthDay,
    required this.tileDate,
    this.isToday = false,
    this.title = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        bool isSelected = isSameDate(state.selectedDate, tileDate);
        return Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: onTap,
            child: _buildTile(context, isSelected),
          ),
        );
      },
    );
  }

  Text _dayLabel(BuildContext context, bool isSelected) {
    return Text(
      monthDay.toString(),
      style: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
        fontSize: 16,
      ),
    );
  }

  Widget _buildTile(BuildContext context, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 32,
              width: 32,
              alignment: Alignment.center,
              child: _dayLabel(context, isSelected),
              decoration: BoxDecoration(
                color: isSelected ? Theme.of(context).primaryColor : null,
                shape: BoxShape.circle,
                border: isToday ? Border.all(color: Colors.grey) : null,
              ),
            ),
          ),
          Text(
            isSelected ? title : '',
            style: const TextStyle(color: Colors.black, fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}
