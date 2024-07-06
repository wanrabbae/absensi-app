import 'package:app/core/themes.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({super.key, this.size = 96});

  final double size;

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.prograssiveDots(
      color: colorBluePrimary2,
      size: size,
    );
  }
}
