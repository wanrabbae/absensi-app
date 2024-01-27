import 'package:app/global_resource.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (s) => Scaffold(
        backgroundColor: colorBluePrimary2,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 60, 16, 0),
              child: customHeaderAuth2(context, "HORA", tr('tutorial_title')),
            ),
            PageView(
              controller: pageController,
              children: [
                _TutorialContent(
                  'assets/icons/tutorial/clock.png',
                  tr('tutorial_content_1'),
                ),
                _TutorialContent(
                  'assets/icons/tutorial/marker.webp',
                  tr('tutorial_content_2'),
                ),
                _TutorialContent(
                  'assets/icons/tutorial/camera.webp',
                  tr('tutorial_content_3'),
                ),
                _TutorialContent(
                  'assets/icons/tutorial/folder.webp',
                  tr('tutorial_content_4'),
                ),
                _TutorialContent(
                  'assets/icons/tutorial/chat.png',
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: tr('tutorial_content_5a')),
                        TextSpan(
                          text: 'cs@horaapp.id',
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white70,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launchUrlString('mailto:cs@horaapp.id');
                            },
                        ),
                        TextSpan(text: tr('tutorial_content_5b')),
                      ],
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            _Footer(pageController),
          ],
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer(this.pageController);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 12,
      left: 12,
      right: 12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: AnimatedBuilder(
              animation: pageController,
              builder: (context, child) {
                return AnimatedSmoothIndicator(
                  count: 5,
                  activeIndex: pageController.page?.toInt() ?? 0,
                  effect: const ScaleEffect(
                    activeDotColor: Colors.white,
                    dotColor: Colors.white54,
                    scale: 1.5,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 14,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 64),
          Text(
            tr('tutorial_footer_text'),
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          const SizedBox(height: 4),
          buttonWhite(
            tr('tutorial_footer_button'),
            onTap: () {
              Get.toNamed(RouteName.greeting);
            },
          )
        ],
      ),
    );
  }
}

class _TutorialContent extends StatelessWidget {
  const _TutorialContent(this.image, this.label)
      : assert(label is String || label is Widget);

  final String image;
  final dynamic label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              image: AssetImage(image),
              height: 80,
              width: 80,
            ),
            const SizedBox(height: 60),
            label is String
                ? Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  )
                : label as Widget,
          ],
        ),
      ),
    );
  }
}
