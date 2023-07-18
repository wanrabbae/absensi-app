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
                "Masuk",
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Anda belum memasukan alamat email";
                  }
                  return null;
                },
                // controller: controller,
                onChanged: (value) => s.emailForm = value,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: colorBluePrimary, width: 2)),
                  // filled: true,
                  // fillColor: Colors.white,
                  hintText: "Gunakan e-mail anda",
                  // suffixText: "300",
                  suffixStyle: TextStyle(color: colorBluePrimary),
                  contentPadding: const EdgeInsets.only(left: 5),
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.only(top: 10, left: 30, right: 20),
        child: Text(
          "Anda dapat masuk menggunakan e-mail yang telah diundang sebelumnya.",
          style: TextStyle(color: Colors.grey),
        ),
      )
    ],
  );
}
