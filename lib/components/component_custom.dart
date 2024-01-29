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
          style: const TextStyle(
              fontWeight: FontWeight.w800, fontSize: 24, letterSpacing: 1.5),
        ),
        Text(
          subTitle,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            // color: Color.fromRGBO(33, 33, 33, 80),
            fontSize: 20.0,
          ),
        )
      ],
    ),
  );
}

Widget customHeaderAuth2(BuildContext context, String title, String subTitle) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 24,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          subTitle,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20.0,
          ),
        )
      ],
    ),
  );
}

Widget customTextRich2(BuildContext context, String text1, String text2) {
  return Text.rich(
    TextSpan(
      text: text1,
      style: const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 16,
        color: Colors.black,
      ),
      children: [
        TextSpan(
          text: text2,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16,
            color: Colors.black,
          ),
        )
      ],
    ),
  );
}

Widget customTextRichWithLink(
  BuildContext context,
  String text1,
) {
  return Text.rich(
    textAlign: TextAlign.center,
    TextSpan(
      text: text1,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.grey.shade500,
      ),
      children: [
        TextSpan(
          text: "${tr('profile_terms')} ",
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: colorBluePrimary2,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Get.toNamed(
                RouteName.webview,
                arguments: "https://docs.horaapp.id/#kebijakan",
              );
            },
        ),
        TextSpan(
          text: "${tr('and')} ",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade500,
          ),
        ),
        TextSpan(
          text: tr('profile_privacy'),
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: colorBluePrimary2,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Get.toNamed(
                RouteName.webview,
                arguments: "https://docs.horaapp.id/#privasi",
              );
            },
        ),
      ],
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
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

Widget buttonBlue(String title, {VoidCallback? onTap}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: const MaterialStatePropertyAll<Color>(
          colorBluePrimary,
        ),
        shape: MaterialStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

Widget buttonWhite(String title, {VoidCallback? onTap}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
        shape: MaterialStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

Widget buildImageProfilePage(BuildContext context, String? url, bool local) {
  final ImageProvider image =
      (local ? AssetImage(url!) : NetworkImage(url!)) as ImageProvider<Object>;
  return Container(
    width: double.infinity,
    height: 292,
    decoration: BoxDecoration(
      image: DecorationImage(image: image, fit: BoxFit.cover),
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: colorSplash,
        width: 3,
      ),
    ),
  );
}

customSnackbar1(message) {
  message = message.toString().replaceAll('.', '');
  Get.rawSnackbar(
    messageText: Text(
      message ?? "Success action",
      style: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    snackPosition: SnackPosition.TOP,
    borderRadius: 20,
    padding: const EdgeInsets.all(25),
    margin: const EdgeInsets.symmetric(horizontal: 20),
  );
}

customSnackbarLoading(message) {
  Get.rawSnackbar(
    messageText: Text(
      message ?? "Loading...",
      style: const TextStyle(
          fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
    ),
    snackPosition: SnackPosition.TOP,
    borderRadius: 20,
    isDismissible: false,
    padding: const EdgeInsets.all(25),
    margin: const EdgeInsets.symmetric(horizontal: 20),
  );
}

customSnackbarLoadingAsset(message, asset) {
  showDialog(
    context: Get.overlayContext!,
    barrierDismissible: false,
    builder: (ctx) {
      return customDialogLoadingImage(ctx, message, asset);
    },
  );
}

Widget buildImageProfileBig(
  BuildContext context,
  String urlPhoto,
  bool isLocal,
  file,
) {
  return Stack(
    children: [
      Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          image: (isLocal)
              ? localImage(urlPhoto, file)
              : networkImage(urlPhoto, file),
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
      Positioned(
        bottom: 1,
        right: 1,
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: Colors.black,
            ),
            child: const Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Icon(FeatherIcons.camera, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    ],
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

Widget buildImageSizeIcon(BuildContext context, String url) {
  return Container(
    width: 30,
    height: 30,
    decoration: BoxDecoration(
        color: Colors.blue,
        image: DecorationImage(
            filterQuality: FilterQuality.high,
            image: NetworkImage(
              url,
            ),
            fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(20)),
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
      borderRadius: const BorderRadius.all(Radius.circular(50)),
    ),
  );
}

Widget buildImageList(BuildContext context, String url, bool local) {
  var img = local
      ? DecorationImage(
          image: AssetImage(url),
          onError: (exception, stackTrace) =>
              const AssetImage('assets/icons/logo/hora.png'),
          fit: BoxFit.cover)
      : url.contains("pulang_horas.png")
          ? DecorationImage(
              image: const AssetImage('assets/icons/logo/hora.png'),
              onError: (exception, stackTrace) =>
                  const AssetImage('assets/icons/logo/hora.png'),
              fit: BoxFit.cover,
            )
          : DecorationImage(
              image: NetworkImage(url),
              onError: (exception, stackTrace) =>
                  const AssetImage('assets/icons/logo/hora.png'),
              fit: BoxFit.cover,
            );
  return Container(
    width: 60,
    height: 60,
    decoration: BoxDecoration(
      color: Colors.white,
      image: img,
      borderRadius: const BorderRadius.all(Radius.circular(50)),
      border: const Border.fromBorderSide(
        BorderSide(color: colorSplash, width: 3),
      ),
    ),
  );
}

Widget ovalCardIcon(
  BuildContext context,
  IconData icon, {
  required VoidCallback onTaped,
}) {
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

Widget ovalCardIconGender(
  BuildContext context,
  String genderName,
  bool genderSelected,
) {
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
              : const Color.fromRGBO(51, 51, 51, 1),
        ),
      ),
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
