import 'package:app/global_resource.dart';
import 'components/form_gantiemail_otp.dart';

class ProfileGantiemailScreen extends StatelessWidget {
  const ProfileGantiemailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colorGrayPrimary,
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
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            gantiEmailOtp(context, s),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        customTextRich(
                            context, "Pastikan ", "koneksi tidak terputus.",
                            onTextClicked: () {
                          Get.toNamed(RouteName.webview,
                              arguments: "https://simxd.com");
                        }),
                        const Text(
                          "Tekan \u{2192} untuk menyetujui. Terima kasih.",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
