import 'package:flutter/material.dart';
import 'package:inline_calendar/src/calendar_caption_tile.dart';
import 'package:inline_calendar/src/utilities.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class InlineCalendarCaptionsRow extends StatelessWidget {
  final double height;
  final int middleWeekday;
  final Locale locale;
  final double horizontalPadding;

  const InlineCalendarCaptionsRow({
    Key? key,
    required this.middleWeekday,
    required this.locale,
    required this.height,
    required this.horizontalPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildCaptionTiles(locale, context),
      ),
      height: this.height,
    );
  }

  List<Widget> _buildCaptionTiles(Locale locale, BuildContext context) {
    List<Widget> tiles = [];
    DateTime middleDate = DateTime.now();
    while (middleDate.weekday != middleWeekday) {
      middleDate = safeAdd(middleDate, const Duration(days: 1));
    }

    for (int i = 0; i < 7; i++) {
      final String abbrWeekName = DateFormat.E(locale.toLanguageTag()).format(
        safeAdd(middleDate, Duration(days: i - 3)),
      );

      tiles.add(InlineDayPickerCaptionTile(
        label: abbrWeekName[0],
        color: Colors.grey,
      ));
    }

    return tiles;
  }
}
