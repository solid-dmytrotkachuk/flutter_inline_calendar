import 'package:flutter/material.dart';

class InlineDayPickerCaptionTile extends StatelessWidget {
  final String label;
  final Color color;

  const InlineDayPickerCaptionTile({
    Key? key,
    required this.label,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
