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
                      Text("Lampiran"),
                      TextFormField(
                        onTap: () {
                          s.updateFile();
                        },
                        readOnly: true,
                        style: TextStyle(fontSize: 13),
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
                      Text("Alasan"),
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
                                                fontSize: 14,
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
                      Text("Keterangan (Kosongkan jika tidak ada)"),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 120,
                        child: TextFormField(
                          onChanged: (value) => s.formDeskripsi = value,
                          maxLength: null,
                          keyboardType: TextInputType.multiline,
                          maxLines: 15,
                          style: TextStyle(fontSize: 13),
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
