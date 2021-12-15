import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inline_calendar/src/calendar_captions_row.dart';
import 'package:inline_calendar/src/calendar_days_row.dart';
import 'package:inline_calendar/src/cubit/calendar_cubit.dart';
import 'package:inline_calendar/src/utilities.dart';

class InlineCalendarPageView extends StatelessWidget {
  final double height;
  final int maxWeeks;
  final int middleWeekday;
  final void Function(DateTime)? onChange;

  const InlineCalendarPageView({
    Key? key,
    required this.height,
    required this.maxWeeks,
    required this.middleWeekday,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedDateFromState =
        context.watch<CalendarCubit>().state.selectedDate;
    print(selectedDateFromState);
    final firstWeekMiddleDate = _firstWeekMiddleDate(selectedDateFromState);
    final controller = context.read<CalendarCubit>().pageController;
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: InlineCalendarCaptionsRow(
                key: key,
                middleWeekday: 4,
                height: 24.0,
                locale: Localizations.localeOf(context),
              ),
            ),
          ),
          Container(
            height: height - 24,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                IconButton(
                  iconSize: 15.0,
                  padding: EdgeInsets.zero,
                  onPressed: () => controller.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn),
                  icon: const Icon(Icons.arrow_back_ios),
                  hoverColor: Colors.transparent,
                ),
                Flexible(
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    controller: controller,
                    itemBuilder: (context, index) {
                      return InlineCalendarRows(
                        middleDate: safeAdd(
                            firstWeekMiddleDate, Duration(days: (index * 7))),
                        onChange: onChange!,
                        pageNumber: index,
                        locale: Localizations.localeOf(context),
                      );
                    },
                    itemCount: maxWeeks + 1,
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 15.0,
                  onPressed: () => controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn),
                  icon: const Icon(Icons.arrow_forward_ios),
                  hoverColor: Colors.transparent,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  DateTime _firstWeekMiddleDate(DateTime baseDate) {
    final DateTime middleDate = safeAdd(
      baseDate,
      Duration(days: middleWeekday - baseDate.weekday),
    );

    return safeSubtract(middleDate, Duration(days: (7 * maxWeeks ~/ 2)));
  }
}
