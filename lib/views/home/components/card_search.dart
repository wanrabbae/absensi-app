import 'package:app/global_resource.dart';

Widget dataSearch(BuildContext context, s) {
  return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(top: 0),
          itemCount: s.searchHasil?.length,
          itemBuilder: (ctx, index) => SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (ctx) => dialogViewImage(
                              ctx,
                              s.gambarSearch(s.searchHasil?[index], 1),
                              s.gambarSearch(s.searchHasil?[index], 2)));
                    },
                    child: buildImageList(
                        context,
                        s.gambarSearch(s.searchHasil?[index], 1),
                        s.gambarSearch(s.searchHasil?[index], 2)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      flex: 1,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    strutStyle: const StrutStyle(fontSize: 12.0),
                                    text: TextSpan(
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: kGlobalFontFamily,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                        text: s.searchHasil?[index]
                                            ['namaKaryawan']),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ));
}
