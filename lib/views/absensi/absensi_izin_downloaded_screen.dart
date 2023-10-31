import 'package:app/global_resource.dart';

import 'package:flutter/services.dart';

class AbsensiIzinDownloadedScreen extends StatelessWidget {
  const AbsensiIzinDownloadedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List? izinList = [
      {"nama": "Izin", "value": "Izin"},
      {"nama": "Sakit", "value": "Sakit"},
      {"nama": "Cuti", "value": "Cuti"}
    ];

    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Surat Izin',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
            // Container(
            //   padding: EdgeInsets.all(0),
            //   child: IconButton(
            //     icon: Icon(
            //       FeatherIcons.download,
            //       color: colorBluePrimary,
            //     ),
            //     onPressed: () {
            //       customSnackbar1("Lampiran telah disimpan.");
            //     },
            //   ),
            // ),
          ],
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(FeatherIcons.arrowLeft),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 6),
            child: IconButton(
              icon: const Icon(
                FeatherIcons.download,
                color: colorBluePrimary,
              ),
              onPressed: () {
                var fileType = Get.arguments?["dokumen"]
                    .toString()
                    .split("/")
                    .last
                    .split(".")
                    .last;

                if (fileType == "jpg" ||
                    fileType == "png" ||
                    fileType == "jpeg") {
                  saveNetworkFile(changeUrlImage(Get.arguments?["dokumen"]));
                } else {
                  saveNetworkFile(changeUrlImage(Get.arguments?["dokumen"]));
                  debugPrint("FILE DOK YOYY");
                }
              },
            ),
          )
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
                    const Text(
                      "Nama",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue:
                          Get.arguments?["namaKaryawan"].toString() ?? "",
                      keyboardType: TextInputType.text,
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
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
                    const Text(
                      "Lampiran (Harus terisi)",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      onTap: null,
                      readOnly: true,
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      initialValue: Get.arguments?["dokumen"]
                              .toString()
                              .split("/")
                              .last ??
                          "",
                      decoration: const InputDecoration(
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
                    const Text(
                      "Alasan (Harus terisi)",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
                              icon: const Icon(
                                FeatherIcons.chevronDown,
                                size: 20,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20.0)),
                              key: Key(Get.arguments?["ijin"] ?? "Izin"),
                              value: Get.arguments?["ijin"] ?? "Izin",
                              isExpanded: true,
                              items: izinList.map<DropdownMenuItem<String>>(
                                      (value) => DropdownMenuItem<String>(
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
                        maxLength: null,
                        keyboardType: TextInputType.multiline,
                        maxLines: 15,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        initialValue: Get.arguments?["keterangan"] ?? "",
                        decoration: const InputDecoration(
                          hintText: "Ketikkan disini",
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.5)),
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
    );
  }
}
