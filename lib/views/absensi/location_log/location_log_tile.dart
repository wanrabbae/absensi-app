import 'package:app/data/models/livetracking/log/live_location_log.dart';
import 'package:app/global_resource.dart';
import 'package:timeline_tile/timeline_tile.dart';

class LocationLogTile extends StatelessWidget {
  const LocationLogTile(
    this.log, {
    super.key,
    this.first = false,
    this.second = false,
    this.last = false,
  });

  final LiveLocationLog log;
  final bool first;
  final bool second;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
      child: TimelineTile(
        isFirst: first,
        isLast: last,
        indicatorStyle: IndicatorStyle(
          width: 20,
          height: 20,
          indicatorXY: 0.4,
          color: first ? colorBluePrimary : Colors.black,
        ),
        afterLineStyle: LineStyle(
          color: first ? colorBluePrimary : Colors.black,
        ),
        beforeLineStyle: LineStyle(
          color: second ? colorBluePrimary : Colors.black,
        ),
        endChild: Container(
          constraints: const BoxConstraints(minHeight: 72),
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                kTimeFormat.format(log.timestamp.toLocal()),
                style: TextStyle(
                  fontWeight: first ? FontWeight.bold : FontWeight.w500,
                  color: first ? colorBluePrimary : Colors.black,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                  decoration: BoxDecoration(
                    color: first ? colorBluePrimary : null,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: first
                        ? null
                        : Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                  ),
                  child: Text(
                    log.address,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: first ? FontWeight.bold : FontWeight.w500,
                      color: first ? Colors.white : Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
