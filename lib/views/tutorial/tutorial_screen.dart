import 'package:app/global_resource.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (s) => Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(25.0),
            child: AppBar(
              actions: [
                GestureDetector(
                  onTap: null,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Icon(
                      Icons.question_mark_outlined,
                      color: Colors.black,
                      size: 25,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => s.tutupTutorial(),
                  child: const Padding(
                    padding: EdgeInsets.only(right: 25),
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                )
              ],
            )),
        body: const Center(
          child: Image(
            image: AssetImage("assets/icons/tutorial.png"),
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
