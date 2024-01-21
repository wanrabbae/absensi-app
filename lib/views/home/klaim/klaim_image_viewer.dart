import 'package:app/components/component_constant.dart';
import 'package:app/global_resource.dart';
import 'package:app/views/home/components/appbar.dart';
import 'package:flutter/services.dart';

class KlaimImageViewer extends StatelessWidget {
  const KlaimImageViewer({super.key, required this.file})
      : assert(file is Uint8List || file is String);

  final dynamic file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: HoraAppBar(
        context,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
        leading: Container(
          margin: const EdgeInsets.only(left: 16),
          decoration: kCircleButtonDecoration,
          child: const HoraBackButton(),
        ),
        backgroundColor: Colors.transparent,
        actions: file is Uint8List
            ? null
            : [
                Container(
                  width: 40,
                  height: 40,
                  decoration: kCircleButtonDecoration,
                  child: IconButton(
                    onPressed: () {
                      saveNetworkImage(file);
                    },
                    icon: Image.asset(
                      'assets/icons/ic_screen_shot.png',
                      color: colorBluePrimary,
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
      ),
      body: SizedBox(
        height: double.infinity,
        child: InteractiveViewer(
          child: Hero(
              tag: 'img',
              child:
                  file is Uint8List ? Image.memory(file) : Image.network(file)),
        ),
      ),
    );
  }
}
