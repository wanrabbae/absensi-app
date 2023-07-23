import 'package:app/global_resource.dart';
import 'components/form_undangan.dart';
import 'dart:math' as math;

class HomeUndanganScreen extends StatelessWidget {
  const HomeUndanganScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlueOpacity,
      resizeToAvoidBottomInset: false,
      body: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (s) => SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Positioned(
              //     child: Align(
              //   alignment: Alignment.topCenter,
              //   child: Padding(
              //     padding: const EdgeInsets.only(top: 80),
              //     child: customHeaderAuth(context, "Verifikasi", "e-mail"),
              //   ),
              // )),
              Positioned(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60, left: 20),
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50.0)),
                          child: Icon(FeatherIcons.arrowLeft)),
                    ),
                  ),
                ),
              ),
              Positioned(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60, right: 20),
                    child: GestureDetector(
                      onTap: () {
                        s.kirimUndangan();
                      },
                      child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50.0)),
                          child: Transform.rotate(
                            angle: math.pi / 4,
                            child: Icon(
                              FeatherIcons.send,
                              color: colorBluePrimary,
                            ),
                          )),
                    ),
                  ),
                ),
              ),
              formUndangan(s, context),
              Positioned(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 32, left: 20, right: 20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // customTextRich(
                          //     context, "Baca tentang ", "Kemanan Akun.",
                          //     onTextClicked: () {
                          //   Get.toNamed(RouteName.webview,
                          //       arguments: "https://docs.horaapp.id/#privasi");
                          // }),
                          Text(
                            'Pastikan anda terhubung dengan internet.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              customSnackbar1(Base.connected);
                            },
                            child: Container(
                              padding: EdgeInsets.all(15),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Text(
                                  "Cek koneksi",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: colorBlueOpacity2,
  //     resizeToAvoidBottomInset: false,
  //     body: GetBuilder<HomeController>(
  //       init: HomeController(),
  //       builder: (s) => Container(
  //         margin: EdgeInsets.only(top: 60),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.max,
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Container(
  //               child: Column(
  //                 children: [
  //                   Container(
  //                     margin: EdgeInsets.symmetric(horizontal: 20),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         GestureDetector(
  //                           onTap: () {
  //                             Get.back();
  //                           },
  //                           child: Container(
  //                             decoration: BoxDecoration(
  //                                 color: Colors.white,
  //                                 borderRadius: BorderRadius.circular(50.0)),
  //                             // margin: EdgeInsets.only(right: 20),
  //                             padding: EdgeInsets.all(10),
  //                             child: Icon(FeatherIcons.x),
  //                           ),
  //                         ),
  //                         GestureDetector(
  //                           onTap: () {
  //                             s.kirimUndangan();
  //                           },
  //                           child: Container(
  //                             decoration: BoxDecoration(
  //                                 color: Colors.white,
  //                                 borderRadius: BorderRadius.circular(50.0)),
  //                             // margin: EdgeInsets.only(right: 20),
  //                             padding: EdgeInsets.all(10),
  //                             child: Transform.rotate(
  //                               angle: math.pi / 4,
  //                               child: Icon(
  //                                 FeatherIcons.send,
  //                                 color: colorBluePrimary,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   formUndangan(context, s),
  //                 ],
  //               ),
  //             ),
  //             Align(
  //               alignment: Alignment.bottomCenter,
  //               child: Padding(
  //                 padding: const EdgeInsets.all(20.0),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   mainAxisSize: MainAxisSize.min,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Center(
  //                       child: Text(
  //                         'Periksa anda terhubung dengan internet.',
  //                         style: TextStyle(fontSize: 12, color: Colors.grey),
  //                         textAlign: TextAlign.center,
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(
  //                           vertical: 10, horizontal: 10),
  //                       child: SizedBox(
  //                         width: double.infinity,
  //                         height: 50,
  //                         child: GestureDetector(
  //                           onTap: () {
  //                             customSnackbar1("Koneksi anda terhubung");
  //                           },
  //                           child: Container(
  //                             width: double.infinity,
  //                             decoration: BoxDecoration(
  //                                 color: Colors.white,
  //                                 borderRadius: BorderRadius.circular(20)),
  //                             child: Center(
  //                               child: Text(
  //                                 "Cek Koneksi",
  //                                 style: TextStyle(
  //                                   fontSize: 16,
  //                                   color: Colors.black,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
