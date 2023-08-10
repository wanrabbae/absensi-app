import 'package:app/global_resource.dart';

Widget menuProfile(BuildContext context, String title, IconData iconData,
    {required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Ink(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        iconData,
                        size: 20,
                        fill: 0,
                        weight: 0.1,
                        color: title == "Keluar" ? colorBluePrimary2 : null,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Center(
                        child: Text(
                          title,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: title == "Keluar"
                                  ? colorBluePrimary2
                                  : Color.fromRGBO(51, 51, 51, 1)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )),
  );
}
