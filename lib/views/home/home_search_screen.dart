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
                Container(
                  padding: const EdgeInsets.only(top: 50),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: colorDivider, width: 1.5),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Get.back(),
                          icon: const Icon(FeatherIcons.arrowLeft),
                        ),
                        Flexible(
                          child: TextFormField(
                            autofocus: true,
                            onChanged: (value) async {
                              s.searchFunc(value);
                            },
                            focusNode: s.focus,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              contentPadding: const EdgeInsets.only(
                                left: 7,
                                right: 10,
                                top: 10,
                                bottom: 10,
                              ),
                              hintText: tr('search'),
                              hintStyle: const TextStyle(
                                  color: Color.fromRGBO(51, 51, 51, 0.5),
                                  fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                dataSearch(context, s),
              ],
            ),
          );
        },
      ),
    );
  }
}
