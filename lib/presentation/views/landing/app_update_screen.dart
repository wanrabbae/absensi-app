import 'package:app/global_resource.dart';
import 'package:app/presentation/widgets/buttons.dart';
import 'package:app_version_update/data/models/app_version_result.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUpdateScreen extends StatelessWidget {
  const AppUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark
          .copyWith(statusBarColor: Colors.transparent),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: colorBluePrimary2,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('assets/icons/logo/hora.png', height: 48, width: 48),
            AspectRatio(
              aspectRatio: 1,
              child: Image.asset('images/app-update.gif'),
            ),
            const SizedBox(height: 24),
            Text(
              tr('app_update'),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: HoraButton.white(
                onPressed: () {
                  final arg = Get.arguments;
                  if (arg is AppVersionResult && arg.storeUrl != null) {
                    launchUrl(
                      Uri.parse(arg.storeUrl!),
                      mode: LaunchMode.externalApplication,
                    );
                  }
                },
                child: Text(tr('app_update_button_update')),
              ),
            ),
            SafeArea(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: kGlobalFontFamily,
                    decoration: TextDecoration.underline,
                  ),
                ),
                child: Text(
                  tr('app_update_button_skip'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
