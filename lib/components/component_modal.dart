import 'package:app/global_resource.dart';

const LatLng currentLatLng = LatLng(-6.175221730228861, 106.827163526188);

Widget dialogViewImage(BuildContext context, String url, bool local) {
  return AlertDialog(
    insetPadding: EdgeInsets.zero,
    contentPadding: EdgeInsets.zero,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    content: Container(
      width: MediaQuery.of(context).size.width - 100,
      height: 280,
      decoration: local
          ? BoxDecoration(
              image: DecorationImage(
                image: AssetImage(url),
                fit: BoxFit.cover,
              ),
            )
          : BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(url),
                fit: BoxFit.cover,
              ),
            ),
    ),
  );
}

Widget customDialogLoading(BuildContext context, String msg) {
  return AlertDialog(
    insetPadding: EdgeInsets.zero,
    actionsPadding: EdgeInsets.zero,
    titlePadding: EdgeInsets.zero,
    content: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          msg,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(color: colorBluePrimary),
        ),
      ],
    ),
  );
}

Widget customDialogLoadingImage(
  BuildContext context,
  String msg,
  String asset,
) {
  return AlertDialog(
    insetPadding: EdgeInsets.zero,
    actionsPadding: EdgeInsets.zero,
    backgroundColor: Colors.transparent,
    elevation: 0,
    titlePadding: EdgeInsets.zero,
    content: SizedBox(
      height: 300,
      child: Column(
        children: [
          Container(
            height: 130,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Image.asset(
                asset,
                height: asset == "images/check-gif.gif" ? 140 : 90,
                width: asset == "images/check-gif.gif" ? 140 : 90,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              msg,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
