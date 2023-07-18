import 'package:app/global_resource.dart';

Widget customHeaderAuth(BuildContext context, String title, String subTitle) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 24.0),
        ),
        Text(
          subTitle,
          style: const TextStyle(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
              // color: Color.fromRGBO(33, 33, 33, 80),
              fontSize: 20.0),
        )
      ],
    ),
  );
}

Widget customTextRich(BuildContext context, String text1, String text2,
    {required VoidCallback onTextClicked}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Center(
      child: RichText(
          text: TextSpan(
              text: text1,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w500),
              children: [
            TextSpan(
                text: text2,
                style: const TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()..onTap = onTextClicked)
          ])),
    ),
  );
}

Widget buttonGreen(String title, {VoidCallback? onTap}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
            backgroundColor:
                const MaterialStatePropertyAll<Color>(colorGreenPrimary),
            shape: MaterialStatePropertyAll<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)))),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        )),
  );
}

Widget buildRoundedActionNext(BuildContext context,
    {required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: SizedBox(
      width: 60,
      height: 60,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(50)),
        child: const Icon(
          Icons.arrow_forward_rounded,
          color: Colors.white,
        ),
      ),
    ),
  );
}

Widget buildImageProfile(BuildContext context, String? url, bool local) {
  return Container(
    width: 120,
    height: 120,
    decoration: local
        ? BoxDecoration(
            image: DecorationImage(image: AssetImage(url!), fit: BoxFit.cover),
            color: Colors.white,
            shape: BoxShape.circle)
        : BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(url!), fit: BoxFit.cover),
            color: Colors.white,
            shape: BoxShape.circle),
  );
}

customSnackbar1(message) {
  Get.rawSnackbar(
      messageText: Text(
        message ?? "Success action",
        style: TextStyle(fontSize: 15, color: Colors.white),
      ),
      snackPosition: SnackPosition.TOP,
      borderRadius: 20,
      padding: EdgeInsets.all(25),
      margin: EdgeInsets.symmetric(horizontal: 20));
}

customSnackbarLoading(message) {
  Get.rawSnackbar(
      messageText: Text(
        message ?? "Loading...",
        style: TextStyle(fontSize: 15, color: Colors.white),
      ),
      snackPosition: SnackPosition.TOP,
      borderRadius: 20,
      isDismissible: false,
      padding: EdgeInsets.all(25),
      margin: EdgeInsets.symmetric(horizontal: 20));
}

Widget buildImageProfileBig(
    BuildContext context, String urlPhoto, bool isLocal, file) {
  return Container(
    width: 150,
    height: 150,
    decoration: BoxDecoration(
        image: (isLocal)
            ? localImage(urlPhoto, file)
            : networkImage(urlPhoto, file),
        color: Colors.white,
        shape: BoxShape.circle),
    child: const Icon(
      FeatherIcons.image,
      color: Colors.white,
      size: 20,
    ),
  );
}

DecorationImage localImage(String url, file) {
  if (file == null) {
    return DecorationImage(image: AssetImage(url), fit: BoxFit.cover);
  } else {
    return DecorationImage(image: FileImage(file), fit: BoxFit.cover);
  }
}

DecorationImage networkImage(String url, file) {
  if (file == null) {
    return DecorationImage(image: NetworkImage(url), fit: BoxFit.cover);
  } else {
    return DecorationImage(image: FileImage(file), fit: BoxFit.cover);
  }
}

Widget buildImageBig(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 240,
    decoration: const BoxDecoration(
        color: Colors.blue,
        image: DecorationImage(
            image: AssetImage("assets/icons/logo/hora.png"), fit: BoxFit.cover),
        borderRadius: BorderRadius.all(Radius.circular(10))),
  );
}

Widget buildImageSizeIcon(BuildContext context, String url) {
  return Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
        color: Colors.blue,
        image: DecorationImage(
            filterQuality: FilterQuality.high,
            image: NetworkImage(
              url,
            ),
            fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(30)),
  );
}

Widget buildImageSizeIconNetwork(BuildContext context, String url, bool local) {
  var img = local
      ? DecorationImage(image: AssetImage(url), fit: BoxFit.cover)
      : DecorationImage(image: NetworkImage(url), fit: BoxFit.cover);
  return Container(
    width: 100,
    height: 100,
    decoration: BoxDecoration(
        color: Colors.blue,
        image: img,
        borderRadius: const BorderRadius.all(Radius.circular(50))),
  );
}

Widget buildImageList(BuildContext context, String url, bool local) {
  var img = local
      ? DecorationImage(image: AssetImage(url), fit: BoxFit.cover)
      : DecorationImage(image: NetworkImage(url), fit: BoxFit.cover);
  return Container(
    width: 60,
    height: 60,
    decoration: BoxDecoration(
        color: Colors.blue,
        image: img,
        borderRadius: const BorderRadius.all(Radius.circular(50))),
  );
}

Widget line(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 5, bottom: 5),
    color: const Color.fromRGBO(51, 51, 51, 0.5),
    width: MediaQuery.of(context).size.width,
    height: 1,
  );
}

Widget emptyLayout(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height / 2,
    child: Center(
      child: Image.asset(
        "assets/icons/logo/hora.png",
        height: 100,
        width: 100,
      ),
    ),
  );
}

Widget ovalCardIcon(BuildContext context, IconData icon,
    {required VoidCallback onTaped}) {
  return GestureDetector(
    onTap: onTaped,
    child: SizedBox(
      child: Center(
        child: Icon(
          icon,
          color: const Color.fromRGBO(51, 51, 51, 1),
        ),
      ),
    ),
  );
}

Widget ovalCardIconRounded(BuildContext context, IconData icon,
    {required VoidCallback onTaped}) {
  return GestureDetector(
    onTap: onTaped,
    child: SizedBox(
      width: 50,
      height: 50,
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Icon(
            icon,
            color: const Color.fromRGBO(51, 51, 51, 1),
          ),
        ),
      ),
    ),
  );
}

Widget ovalCardIconAsset(BuildContext context, String icon,
    {required VoidCallback onTaped}) {
  return GestureDetector(
    onTap: onTaped,
    child: SizedBox(
      width: 40,
      height: 40,
      child: Center(
        child: Image.asset(
          icon,
          width: 24,
          height: 24,
          fit: BoxFit.fill,
        ),
      ),
    ),
  );
}

Widget ovalCardIconAssetCard(BuildContext context, String icon,
    {required VoidCallback onTaped}) {
  return GestureDetector(
    onTap: onTaped,
    child: SizedBox(
      width: 40,
      height: 40,
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Center(
          child: Image.asset(
            icon,
            width: 20,
            height: 20,
            fit: BoxFit.fill,
          ),
        ),
      ),
    ),
  );
}

Widget ovalCardIcon55(BuildContext context, IconData icon,
    {required VoidCallback onTaped}) {
  return GestureDetector(
    onTap: onTaped,
    child: SizedBox(
      width: 55,
      height: 55,
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Icon(
          icon,
          size: 15,
          color: const Color.fromRGBO(51, 51, 51, 1),
        ),
      ),
    ),
  );
}

Widget ovalCardIconGender(
    BuildContext context, String genderName, bool genderSelected) {
  return Container(
    color: Colors.transparent,
    width: double.infinity,
    height: 60,
    child: Card(
      color:
          (genderSelected) ? Colors.white : const Color.fromRGBO(51, 51, 51, 1),
      surfaceTintColor:
          (genderSelected) ? Colors.white : const Color.fromRGBO(51, 51, 51, 1),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
              width: 1.0,
              color: (!genderSelected)
                  ? Colors.white
                  : const Color.fromRGBO(51, 51, 51, 1))),
      child: Center(
        child: Text(
          genderName,
          style: TextStyle(
            color: (!genderSelected)
                ? Colors.white
                : const Color.fromRGBO(51, 51, 51, 1),
          ),
        ),
      ),
    ),
  );
}
