import 'package:app/global_resource.dart';
import 'components/card_search.dart';

class HomeSearchScreen extends StatelessWidget {
  const HomeSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteName.homeUndangan);
            },
            child: Container(
              padding: const EdgeInsets.only(right: 20),
              width: 40,
              height: 40,
              child: const Center(
                child: Icon(
                  FeatherIcons.plus,
                  color: Color.fromRGBO(51, 51, 51, 1),
                ),
              ),
            ),
          ),
        ],
      ),
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
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          "Telusuri",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        Text("Karyawan perusahaan",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(51, 51, 51, 0.5))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        onChanged: (value) async {
                          s.searchFunc(value);
                          // s.search = value;
                          // Future.delayed(const Duration(seconds: 2))
                          //     .then((d) => s.searchFunc(value));
                        },
                        focusNode: s.focus,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color.fromRGBO(238, 240, 244, 1),
                            contentPadding: EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            hintText: "Cari disini",
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(51, 51, 51, 0.5),
                                fontSize: 14),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
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
