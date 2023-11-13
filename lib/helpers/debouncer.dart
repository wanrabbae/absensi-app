import 'dart:async';

/// This "function" class is the implementation of `DeBouncer()` Worker.
/// It calls the function passed after specified [delay] parameter.
/// Example:
/// ```
/// final delayed = DeBouncer( delay: Duration( seconds: 1 )) ;
/// print( 'the next function will be called after 1 sec' );
/// delayed( () => print( 'called after 1 sec' ));
/// ```
class DeBouncer {
  final Duration delay;
  Timer? _timer;

  DeBouncer({required this.delay});

  void call(void Function() action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  /// Notifies if the delayed call is active.
  bool get isRunning => _timer?.isActive ?? false;

  /// Cancel the current delayed call.
  void cancel() => _timer?.cancel();
}
