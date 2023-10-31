import 'package:app/global_resource.dart';

Widget timerCount(BuildContext context, GetxController s) {
  assert(s is AbsenController || s is HomeController);
  String? timerRecord;
  if (s is AbsenController) {
    timerRecord = s.timerRecor;
  } else if (s is HomeController) {
    timerRecord = s.timerRecor;
  }
  final isEmpty = timerRecord != "00:00:00";
  if (s is HomeController) {
    timerRecord = timerRecord?.replaceAll(':', ' : ');
  }

  return isEmpty
      ? buildDisable(context, timerRecord, s)
      : buildEnable(context, timerRecord, s);
}

Widget buildEnable(BuildContext context, timer, GetxController s) {
  final children = s is HomeController
      ? [
          const Icon(Icons.access_time_filled, size: 24, color: Colors.white),
          Expanded(
            child: Text(
              timer,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Icon(Icons.chevron_right, size: 24, color: Colors.white),
        ]
      : [
          const Icon(FeatherIcons.clock, size: 24, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            timer,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ];
  final padding = s is HomeController
      ? const EdgeInsets.fromLTRB(16, 0, 12, 0)
      : const EdgeInsets.only(top: 20, bottom: 20);

  return Padding(
    padding: padding,
    child: Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    ),
  );
}

Widget buildDisable(BuildContext context, timer, GetxController s) {
  final children = s is HomeController
      ? [
          const Icon(Icons.access_time_filled, size: 24, color: Colors.white),
          Expanded(
            child: Text(
              timer,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Icon(Icons.chevron_right, size: 24, color: Colors.white),
        ]
      : [
          const Icon(FeatherIcons.clock, size: 24, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            timer,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ];
  final padding = s is HomeController
      ? const EdgeInsets.fromLTRB(16, 0, 12, 0)
      : const EdgeInsets.only(top: 20, bottom: 20);

  return Padding(
    padding: padding,
    child: Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    ),
  );
}

// class TimerHelper {
//   const TimerHelper._();

//   static String millisecondsToTimeFormat(int milliseconds) {
//     final dt = DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: true);
//     final format = DateFormat("HH:mm:ss").format(dt);
//     debugPrint("object $format");
//     return "00:00:00";
//   }

//   static String stWatchUp() {
//     Stopwatch stopwatch = Stopwatch();
//     stopwatch.start();
//     debugPrint("object elapsed ${stopwatch.elapsed}");
//     debugPrint("object elapsedMilliseconds ${stopwatch.elapsedMilliseconds}");
//     debugPrint("object elapsedTicks ${stopwatch.elapsedTicks}");
//     debugPrint("object frequency ${stopwatch.frequency}");
//     debugPrint("object isRunning ${stopwatch.isRunning}");
//     return "00";
//   }

//   static int getMilliseconds(DateTime start, DateTime end) {
//     return end.difference(start).inSeconds;
//   }

//   static String dateFormater(String dateTime) {
//     final pas = parsingDate(dateTime);
//     final now = DateTime.now();
//     return "${now.difference(pas).inDays} Day";
//   }

//   static DateTime parsingDate(String stringDate) {
//     return DateTime.parse(stringDate);
//   }

//   static Future<String> stopWatchStreamer(bool isStart) async {
//     debugPrint("object stopWatchStreamer $isStart");
//     StreamController<int>? streamController;
//     Duration timerInterval = const Duration(seconds: 5);
//     int counter = 0;
//     void tick(_) {
//       counter++;
//       streamController?.add(counter);
//     }

//     Timer? timer = Timer.periodic(timerInterval, tick);

//     void stopTimer() {
//       debugPrint("object stopTimer ${(timer != null)}");
//       timer?.cancel();
//       timer = null;
//       counter = 0;
//       streamController?.close();
//     }

//     void startTimer() {
//       if (isStart) {
//         timer = Timer.periodic(timerInterval, tick);
//       } else {
//         debugPrint("object startTimer 2");
//         streamController?.close();
//         timer?.cancel();
//         timer = null;
//       }
//     }

//     streamController = StreamController<int>(
//         onListen: startTimer,
//         onCancel: stopTimer,
//         onResume: startTimer,
//         onPause: stopTimer,
//         sync: true);
//     // streamController.stream.listen((newTick) {
//     //   var h = ((newTick / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
//     //   var m = ((newTick / 60) % 60).floor().toString().padLeft(2, '0');
//     //   var s = (newTick % 60).floor().toString().padLeft(2, '0');
//     //
//     // }, onDone: () {
//     // }, onError: (object, error) {
//     // }, cancelOnError: true);

//     return "00";
//   }

//   static void timerPeriod(bool isStart) {
//     final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       debugPrint("object ${timer.tick}");
//     });
//     debugPrint("object $isStart");
//     timer.cancel();
//   }

//   static bool isCurrentDate(DateTime date) {
//     DateTime now = DateTime.now();
//     return DateTime(date.year, date.month, date.day)
//             .difference(DateTime(now.year, now.month, now.day))
//             .inDays ==
//         0;
//   }

//   static bool isNextDay(DateTime date) {
//     DateTime now = DateTime.now();
//     return DateTime(date.year, date.month, date.day)
//             .difference(DateTime(now.year, now.month, now.day))
//             .inDays >=
//         0;
//   }

//   static int rangeDate(DateTime date) {
//     DateTime now = DateTime.now();
//     return DateTime(date.year, date.month, date.day)
//         .difference(DateTime(now.year, now.month, now.day))
//         .inDays;
//   }
// }
