import 'package:app/global_resource.dart';
import 'package:app/presentation/widgets/buttons.dart';
import 'package:flutter/services.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark
          .copyWith(statusBarColor: Colors.transparent),
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 60,
              child: customHeaderAuth(context, "HORA", tr('greeting_welcome')),
            ),
            Center(
              child: Image.asset(
                "assets/icons/logo/main_logo.png",
                width: 100,
                height: 100,
              ),
            ),
            Positioned(
              bottom: 20,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: customTextRichWithLink(context, tr('greeting_approval')),
                      ),
                      const SizedBox(height: 12),
                      HoraButton(
                        onPressed: () => Get.toNamed(RouteName.login),
                        child: Text(tr('greeting_button')),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
