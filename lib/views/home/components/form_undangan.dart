import 'package:app/global_resource.dart';

Widget formUndangan(s, context) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 130, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Undang melalui email",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w800),
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
                autofocus: true,
                onChanged: (value) => s.emailUndangan = value,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                decoration: const InputDecoration(
                  hintText: "e-mail teman",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.5),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorBluePrimary, width: 1.5),
                  ),
                ),
              ),
            ),
            const Text(
              "Beritahu teman anda untuk segera memeriksa kotak masuk e-mail.",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    ],
  );
}
