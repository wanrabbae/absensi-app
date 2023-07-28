import 'package:app/global_resource.dart';

Widget gantiEmail(s, context) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 130, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                "Mengubah email",
                style: TextStyle(
                    fontSize: 20,
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
                onChanged: (value) => s.emailBaru = value,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                decoration: InputDecoration(
                  hintText: "email anda",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.5),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorBluePrimary, width: 1.5),
                  ),
                ),
              ),
            ),
            Container(
              child: Text(
                "Masuk menggunakan e-mail baru anda.",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    ],
  );
}
