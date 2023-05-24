import 'package:app/global_resource.dart';
import 'components/form_gantiemail.dart';

class ProfileGantiemailOtpScreen extends StatelessWidget {
  const ProfileGantiemailOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorGrayPrimary,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: colorGrayPrimary,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ovalCardIcon(context, FeatherIcons.x,
                onTaped: () => Get.back()),
          ),
        ],
      ),
      body: GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (s) => Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            gantiEmail(context, s),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    customTextRich(
                        context, "Pastikan ", "koneksi tidak terputus.",
                        onTextClicked: () {
                      Get.toNamed(RouteName.webview,
                          arguments: "https://simxd.com");
                    }),
                    const Center(
                      child: Text(
                        "Tekan \u{2192} untuk mengubah email. Terima kasih.",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
