import 'package:app/global_resource.dart';

const String kHoraImageUrl =
    'https://firebasestorage.googleapis.com/v0/b/horagps.appspot.com/o/public%2Fhora.png?alt=media';
const String kImagePlaceholderUrl =
    'https://placehold.co/320x320/E8F0FC/E8F0FC.png';
const String kLocalPlaceholderUrl =
    'assets/icons/logo/hora.png';
const ImageProvider kImagePlaceholder = NetworkImage(kImagePlaceholderUrl);
final Widget kImagePlaceholderWidget = Container(
  decoration: const BoxDecoration(
    color: colorBlueOpacity,
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
);
