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
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2)),
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
