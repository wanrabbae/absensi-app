import 'package:app/global_resource.dart';

class WebviewScreen extends StatelessWidget {
  const WebviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: colorGrayPrimary,
        body: SafeArea(
          bottom: false,
          child: Scaffold(
            body: WebView(
              initialUrl: Get.arguments.toString(),
            ),
          ),
        ));
  }
}
