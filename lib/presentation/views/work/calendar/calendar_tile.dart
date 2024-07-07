import 'package:app/core/themes.dart';
import 'package:app/helpers/constant.dart';
import 'package:flutter/material.dart';

class CalendarTileView extends StatelessWidget {
  const CalendarTileView({super.key, required this.date, required this.active});

  final DateTime date;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final day = (100 + date.day).toString().substring(1);
    final month = kMonthShortFormat.format(date);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
              decoration: BoxDecoration(
                color: active ? colorBluePrimary2 : colorBottomSheetDrag,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      month,
                      style: TextStyle(
                        color: active ? Colors.white : null,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      day,
                      style: TextStyle(
                        color: active ? Colors.white : null,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: active ? colorBluePrimary2 : colorBottomSheetDrag,
                    ),
                  ),
                ),
                child: const Text(
                  'Kosong',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
