import 'package:app/global_resource.dart';

Widget formUndangan(context, s) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 80, top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "Undangan Melalui Email",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Anda belum memasukan alamat email";
              }
              return null;
            },
            onChanged: (value) => s.emailUndangan = value,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Masukkan e-mail tujuan",
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colorBluePrimary, width: 1.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colorBluePrimary, width: 1.5),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Anda dapat masuk menggunakan e-mail yang telah diundang sebelumnya.",
            style: TextStyle(fontSize: 11, color: Colors.grey),
          ),
          const SizedBox(
            height: 220,
          )
        ],
      ),
    ),
  );
}
