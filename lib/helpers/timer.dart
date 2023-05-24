import 'package:app/global_resource.dart';
// import 'package:stop_watch_timer/stop_watch_timer.dart';

Widget timerCount(BuildContext context, s) {
  return Container(
    child: s.timerRecor != "00:00:00"
        ? buildDisable(context, s.timerRecor)
        : buildEnable(context, s.timerRecor, s),
  );
}

Widget buildEnable(BuildContext context, timer, s) {
  return Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 20),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          FeatherIcons.clock,
          size: 18,
          color: colorBluePrimary,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          timer,
          style: const TextStyle(
              color: colorBluePrimary,
              fontWeight: FontWeight.w600,
              fontSize: 16),
        ),
      ],
    ),
  );
}

Widget buildDisable(BuildContext context, timer) {
  return Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 20),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          FeatherIcons.clock,
          size: 18,
          color: colorBluePrimary,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          timer,
          style: const TextStyle(
              color: colorBluePrimary,
              fontWeight: FontWeight.w600,
              fontSize: 16),
        ),
      ],
    ),
  );
}

// class TimerHelper {
//   const TimerHelper._();

//   static String millisecondsToTimeFormat(int milliseconds) {
//     final dt = DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: true);
//     final format = DateFormat("HH:mm:ss").format(dt);
//     print("object $format");
//     return "00:00:00";
//   }

//   static String stWatchUp() {
//     Stopwatch stopwatch = Stopwatch();
//     stopwatch.start();
//     print("object elapsed ${stopwatch.elapsed}");
//     print("object elapsedMilliseconds ${stopwatch.elapsedMilliseconds}");
//     print("object elapsedTicks ${stopwatch.elapsedTicks}");
//     print("object frequency ${stopwatch.frequency}");
//     print("object isRunning ${stopwatch.isRunning}");
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
//     print("object stopWatchStreamer $isStart");
//     StreamController<int>? streamController;
//     Duration timerInterval = const Duration(seconds: 5);
//     int counter = 0;
//     void tick(_) {
//       counter++;
//       streamController?.add(counter);
//     }

//     Timer? timer = Timer.periodic(timerInterval, tick);

//     void stopTimer() {
//       print("object stopTimer ${(timer != null)}");
//       timer?.cancel();
//       timer = null;
//       counter = 0;
//       streamController?.close();
//     }

//     void startTimer() {
//       if (isStart) {
//         timer = Timer.periodic(timerInterval, tick);
//       } else {
//         print("object startTimer 2");
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
//       print("object ${timer.tick}");
//     });
//     print("object $isStart");
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
