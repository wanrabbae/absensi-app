// import 'package:app/data/local/preference.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// import '../counting/timer_notifier.dart';

// final prefProvider = Provider<Preference>((ref) => Preference());

// final timerProvider = StateNotifierProvider<TimerNotifier, TimerModel>(
//   (ref) => TimerNotifier(),
// );

// final _timeLeftProvider = Provider<String>((ref) {
//   return ref.watch(timerProvider).timeLeft;
// });

// final timeLeftProvider = Provider<String>((ref) {
//   return ref.watch(_timeLeftProvider);
// });

// final buttonState = Provider<ButtonState>((ref) {
//   return ref.watch(timerProvider).buttonState;
// });

// final buttonProvider = Provider<ButtonState>((ref) {
//   return ref.watch(buttonState);
// });
