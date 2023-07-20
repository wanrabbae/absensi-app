import 'package:app/global_resource.dart';
import 'components/form_undangan.dart';

class HomeUndanganScreen extends StatelessWidget {
  const HomeUndanganScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlueOpacity2,
      resizeToAvoidBottomInset: false,
      body: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (s) => Container(
          margin: EdgeInsets.only(top: 60),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50.0)),
                              // margin: EdgeInsets.only(right: 20),
                              padding: EdgeInsets.all(10),
                              child: Icon(FeatherIcons.x),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              s.kirimUndangan();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50.0)),
                              // margin: EdgeInsets.only(right: 20),
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                FeatherIcons.send,
                                color: colorBluePrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    formUndangan(context, s),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Periksa anda terhubung dengan internet.',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: GestureDetector(
                            onTap: () {
                              customSnackbar1("Koneksi anda terhubung");
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Text(
                                  "Cek Koneksi",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
