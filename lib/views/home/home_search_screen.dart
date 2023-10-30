import 'package:app/global_resource.dart';
import 'components/card_search.dart';

class HomeSearchScreen extends StatelessWidget {
  const HomeSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<HomeController>(
          init: HomeController(),
          dispose: (state) {
            // state.controller?.focus.dispose();
            state.controller?.searchHasil = [];
          },
          builder: (s) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: const [
                  //       Text(
                  //         "Telusuri",
                  //         style: TextStyle(
                  //             fontSize: 24, fontWeight: FontWeight.bold),
                  //       ),
                  //       Text("Karyawan perusahaan",
                  //           style: TextStyle(
                  //               fontSize: 16,
                  //               fontWeight: FontWeight.w500,
                  //               color: Color.fromRGBO(51, 51, 51, 0.5))),
                  //     ],
                  //   ),
                  // ),

                  Container(
                    padding: const EdgeInsets.only(top: 50),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: colorBluePrimary, width: 1.5))),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(FeatherIcons.arrowLeft),
                          ),
                          Flexible(
                            child: TextFormField(
                              autofocus: true,
                              onChanged: (value) async {
                                s.searchFunc(value);
                                // s.search = value;
                                // Future.delayed(const Duration(seconds: 2))
                                //     .then((d) => s.searchFunc(value));
                              },
                              focusNode: s.focus,
                              style: const TextStyle(fontWeight: FontWeight.w600),
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                contentPadding: EdgeInsets.only(
                                    left: 7, right: 10, top: 10, bottom: 10),
                                hintText: "Pencarian",
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(51, 51, 51, 0.5),
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  dataSearch(context, s)
                ],
              ),
            );
          }),
    );
  }
}
