import 'package:app/global_resource.dart';

class AbsensiIzinDownloadedScreen extends StatelessWidget {
  const AbsensiIzinDownloadedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AbsenController>(
      init: AbsenController(),
      builder: (s) => Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Surat Izin',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(FeatherIcons.arrowLeft),
            onPressed: () {
              Get.back();
            },
          ),
          actions: [
            Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    FeatherIcons.download,
                    color: colorBluePrimary,
                  ),
                  onPressed: () {
                    customSnackbar1("Lampiran telah disimpan.");
                  },
                )),
          ],
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
                        onTap: null,
                        readOnly: true,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        initialValue: Get.arguments?["dokumen"]
                                .toString()
                                .split("/")
                                .last ??
                            "",
                        decoration: InputDecoration(
                          hintText: "File_surat_sakit.docx",
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
                                key: Key(Get.arguments?["ijin"] ?? "Izin"),
                                value: Get.arguments?["ijin"] ?? "Izin",
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
                                onChanged: (value) {}),
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
                          readOnly: true,
                          onChanged: (value) => s.formDeskripsi = value,
                          maxLength: null,
                          keyboardType: TextInputType.multiline,
                          maxLines: 15,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          initialValue: Get.arguments?["keterangan"] ?? "",
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
