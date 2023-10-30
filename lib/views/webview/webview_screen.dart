import 'package:app/global_resource.dart';

class WebviewScreen extends StatelessWidget {
  const WebviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: colorGrayPrimary,
        appBar: AppBar(
          backgroundColor: colorBluePrimary2,
          title: Container(
            color: colorBluePrimary2,
            child: Text(
              Get.arguments.toString(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          centerTitle: false,
          leading: IconButton(
            style: const ButtonStyle(
                iconColor: MaterialStatePropertyAll(Colors.white),
                textStyle:
                    MaterialStatePropertyAll(TextStyle(color: Colors.white))),
            icon: const Icon(FeatherIcons.x),
            onPressed: () {
              Get.back();
            },
          ),
        ),
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
