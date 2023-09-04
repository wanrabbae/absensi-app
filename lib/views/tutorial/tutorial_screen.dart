import 'package:app/global_resource.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (s) => Scaffold(
        backgroundColor: colorBluePrimary2,
        // appBar: PreferredSize(
        //     preferredSize: const Size.fromHeight(25.0),
        //     child: AppBar(
        //       actions: [
        //         GestureDetector(
        //           onTap: null,
        //           child: const Padding(
        //             padding: EdgeInsets.only(right: 15),
        //             child: Icon(
        //               Icons.question_mark_outlined,
        //               color: Colors.black,
        //               size: 25,
        //             ),
        //           ),
        //         ),
        //         GestureDetector(
        //           onTap: () => s.tutupTutorial(),
        //           child: const Padding(
        //             padding: EdgeInsets.only(right: 25),
        //             child: Icon(
        //               FeatherIcons.x,
        //               color: Colors.black,
        //               size: 30,
        //             ),
        //           ),
        //         )
        //       ],
        //     )),
        body: Container(
          alignment: Alignment.center,
          child: Stack(
            children: [
              Positioned(
                top: 60,
                child: customHeaderAuth2(context, "HORA", "Petunjuk Pemakaian"),
              ),
              Center(
                child: Image(
                  image: AssetImage("assets/icons/tutorial2.png"),
                ),
              ),
              Positioned(
                  bottom: 20,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // customTextRich(
                          //     context, "Baca tentang ", "Kebijakan Privasi.",
                          //     onTextClicked: () {
                          //   Get.toNamed(RouteName.webview,
                          //       arguments: "https://docs.horaapp.id/#kebijakan");
                          // }),
                          // const SizedBox(
                          //   height: 5,
                          // ),
                          Text(
                            "Anda sudah mengerti?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Rubik',
                              color: Colors.white,
                            ),
                          ),
                          buttonWhite(
                            "Saya mengerti",
                            onTap: () {
                              Get.toNamed(RouteName.greeting);
                            },
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
