import 'package:app/global_resource.dart';

Widget menuProfile(
  BuildContext context,
  String title,
  IconData iconData, {
  Widget? trailing,
  VoidCallback? onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 20,
            fill: 0,
            weight: 0.1,
            color: title == tr('profile_logout') ? colorBluePrimary2 : null,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: title == tr('profile_logout')
                    ? colorBluePrimary2
                    : const Color.fromRGBO(51, 51, 51, 1),
              ),
            ),
          ),
          trailing ?? const Icon(Icons.chevron_right, size: 20),
        ],
      ),
    ),
  );
}
