import 'package:app/global_resource.dart';

Widget menuProfile(BuildContext context, String title, IconData iconData,
    {required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.only(top: 1, bottom: 1),
      child: Ink(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 14, bottom: 14),
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
                          size: 24,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Center(
                          child: Text(
                            title,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Color.fromRGBO(51, 51, 51, 1)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
    ),
  );
}
