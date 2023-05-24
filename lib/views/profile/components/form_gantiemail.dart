import 'package:app/global_resource.dart';

Widget gantiEmail(context, s) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          customHeaderAuth(context, "Ubah", "Alamat e-mail"),
          const SizedBox(
            height: 40,
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Anda belum memasukan alamat email";
              }
              return null;
            },
            onChanged: (value) => s.emailBaru = value,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Masukkan e-mail tujuan",
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: colorBluePrimary),
                    borderRadius: BorderRadius.circular(20)),
                errorBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: colorBluePrimary, width: 2),
                    borderRadius: BorderRadius.circular(20)),
                suffixIconConstraints:
                    const BoxConstraints(minHeight: 30, minWidth: 30),
                suffixIconColor: Colors.white,
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      s.ubahEmail("Mengirim Otp", 1);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/icons/arrow_right_primary.png",
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                )),
          ),
          const SizedBox(
            height: 220,
          )
        ],
      ),
    ),
  );
}
