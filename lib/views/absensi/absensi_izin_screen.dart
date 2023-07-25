import 'package:app/global_resource.dart';
import 'dart:math' as math;

class AbsensiIzinScreen extends StatelessWidget {
  const AbsensiIzinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AbsenController>(
      init: AbsenController(),
      builder: (s) => Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Surat Izin',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Container(
                  // padding: EdgeInsets.only(top: 5),
                  child: Transform.rotate(
                    angle: math.pi / 4,
                    child: IconButton(
                      icon: Icon(
                        FeatherIcons.send,
                        color: colorBluePrimary,
                      ),
                      onPressed: () {
                        if (s.currentDate != null) {
                          izin() {
                            return s.absenIzin();
                          }

                          SplashController().showConfirmationDialog2(
                            "Izin",
                            "Ajukan Izin Sekarang?",
                            izin,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          centerTitle: false,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(FeatherIcons.arrowLeft),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Nama",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      TextFormField(
                        readOnly: true,
                        onChanged: (value) => s.namaOrang = value,
                        initialValue: s.user?["namaKaryawan"] ?? "",
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: "Ketikkan disini",
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.5)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Lampiran",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      TextFormField(
                        onTap: () {
                          s.updateFile();
                        },
                        readOnly: true,
                        // initialValue: ,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: (s.fileName == null)
                              ? "File_surat_sakit.docx"
                              : s.fileName,
                          hintStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.5)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Alasan",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 40,
                        constraints: const BoxConstraints(minHeight: 60),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.black, width: 1))),
                        child: Center(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                icon: Icon(
                                  FeatherIcons.chevronDown,
                                  size: 20,
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20.0)),
                                key: Key(s.formIzin),
                                value: s.formIzin,
                                isExpanded: true,
                                items: s.izinList!
                                    .map<DropdownMenuItem<String>>((value) =>
                                        DropdownMenuItem<String>(
                                          value: value["value"].toString(),
                                          child: Text(
                                            '${value["nama"]}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    s.updateFormIzin(value);
                                  }
                                }),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      customTextRich2(
                          context, "Keterangan", " (Kosongkan jika tidak ada)"),
                      SizedBox(
                        height: 120,
                        child: TextFormField(
                          onChanged: (value) => s.formDeskripsi = value,
                          maxLength: null,
                          keyboardType: TextInputType.multiline,
                          maxLines: 15,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            hintText: "Ketikkan disini",
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 1.5)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
