import 'package:app/global_resource.dart';

const ImageProvider kImagePlaceholder =
    NetworkImage('https://placehold.co/320x320/E8F0FC/E8F0FC.png');
final Widget kImagePlaceholderWidget = Container(
  decoration: const BoxDecoration(
    color: colorBlueOpacity,
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
);
