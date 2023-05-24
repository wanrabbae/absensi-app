import 'package:app/global_resource.dart';
import 'package:flutter/cupertino.dart';
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
                  //             fontSize: 24, fontWeight: FontWeight.w600),
                  //       ),
                  //       Text("Karyawan perusahaan",
                  //           style: TextStyle(
                  //               fontSize: 16,
                  //               fontWeight: FontWeight.w400,
                  //               color: Color.fromRGBO(51, 51, 51, 0.5))),
                  //     ],
                  //   ),
                  // ),

                  Container(
                    padding: EdgeInsets.only(top: 50),
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.grey.shade400, width: 1.5))),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(CupertinoIcons.arrow_left),
                          ),
                          Flexible(
                            child: TextFormField(
                              onChanged: (value) async {
                                s.searchFunc(value);
                                // s.search = value;
                                // Future.delayed(const Duration(seconds: 2))
                                //     .then((d) => s.searchFunc(value));
                              },
                              focusNode: s.focus,
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                contentPadding: EdgeInsets.only(
                                    left: 20, right: 20, top: 10, bottom: 10),
                                hintText: "Telusuri",
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
