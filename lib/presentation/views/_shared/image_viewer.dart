import 'dart:typed_data';

import 'package:app/global_resource.dart';
import 'package:app/presentation/widgets/appbar.dart';
import 'package:app/presentation/widgets/bottomsheet.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'package:saver_gallery/saver_gallery.dart';

class ImageViewer extends StatefulWidget {
  const ImageViewer({super.key, required this.image});

  static Future show(BuildContext context, String image) {
    return Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return ImageViewer(image: image);
      },
    ));
  }

  final String image;

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  bool _showLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      extendBodyBehindAppBar: true,
      appBar: HoraAppBar.transparent(
        context,
        actions: [
          IconButton(
            onPressed: () => _handleDownload(context),
            icon: Image.asset(
              'assets/icons/ic_screen_shot.png',
              height: 28,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: InteractiveViewer(
        child: Center(child: Image.network(widget.image)),
      ),
    );
  }

  Future<bool> _checkPermission() async {
    bool isGranted;
    if (Platform.isAndroid) {
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.androidInfo;
      final sdkInt = deviceInfo.version.sdkInt;
      isGranted =
          sdkInt < 29 ? await Permission.storage.request().isGranted : true;
    } else {
      isGranted = await Permission.photosAddOnly.request().isGranted;
    }
    return isGranted;
  }

  Future<SaveResult> _downloadImage(CancelToken cancelToken) async {
    final response = await kDio.get(
      widget.image,
      options: Options(responseType: ResponseType.bytes),
      cancelToken: cancelToken,
    );
    final name = path.basename(widget.image);

    return SaverGallery.saveImage(
      Uint8List.fromList(response.data),
      quality: 60,
      name: name,
      androidRelativePath: "Pictures/Hora",
      androidExistNotSave: false,
    );
  }

  _handleDownload(BuildContext context) {
    _checkPermission().then((isGranted) {
      if (!isGranted) return Future.value(null);
      final cancelToken = CancelToken();
      _showLoading = true;
      showHoraLoadingBottomSheet(
        context,
        onCancel: () => cancelToken.cancel(),
      ).then((_) => _showLoading = false);
      return _downloadImage(cancelToken);
    }).then((SaveResult? result) {
      if (_showLoading == true && context.mounted) Navigator.pop(context);
      if (result == null) return;
      if (context.mounted) {
        showHoraInfoBottomSheet(
          context,
          title: tr('screenshot_title'),
          message: tr('screenshot_saved'),
        );
      }
    }, onError: (e, s) {
      if (_showLoading == true && context.mounted) Navigator.pop(context);
      if (context.mounted) {
        showHoraInfoBottomSheet(
          context,
          title: tr('screenshot_title'),
          message: tr('screenshot_saved_failed'),
        );
      }
    });
  }
}
