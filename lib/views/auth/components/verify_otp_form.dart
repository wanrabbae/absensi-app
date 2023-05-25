import 'package:app/global_resource.dart';

Widget formData(s, context) {
  return Column(
    // mainAxisAlignment: MainAxisAlignment.center,
    // crossAxisAlignment: CrossAxisAlignment.center,
    // mainAxisSize: MainAxisSize.max,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 150, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                "Kode OTP",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: TextFormField(
                onChanged: (value) {
                  s.otpForm = value;
                  // if (value == "1234") {
                  //   ref.read(prefProvider).setIsLogin(true);
                  //   AppRoute.push(Routes.TUTORIAL).then((value) {
                  //     ref.read(prefProvider).setIsFirstOpen(true);
                  //     if (value != null) {
                  //       AppRoute.push(Routes.MAIN);
                  //     }
                  //   });
                  // } else {
                  //   showDialog(
                  //       context: context,
                  //       builder: (ctx) => customDialog(
                  //           context, "Periksa kembali kode OTP", "OK",
                  //           onTap: () => AppRoute.pop()));
                  // }
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: colorBluePrimary, width: 2)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: colorBluePrimary, width: 2)),
                  contentPadding: const EdgeInsets.only(left: 5),
                  hintText: "Masukkan 6 angka kode",
                ),
              ),
            ),
          ],
        ),
      ),
      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: customTextRich(
      //       context, "Tidak menerima kode OTP ? ", "Kirim Ulang",
      //       onTextClicked: () {
      //     LoginController().emailKirim(s.emailForm, 1);
      //   }),
      // ),
      Container(
        padding: const EdgeInsets.only(top: 10, left: 30, right: 20),
        child: Text(
          "Temukan 6 angka kode OTP pada kotak masuk e-mail anda.",
          style: TextStyle(color: Colors.grey),
        ),
      )
    ],
  );
}
