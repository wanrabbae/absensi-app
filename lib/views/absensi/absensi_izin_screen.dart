import 'package:app/controllers/izin_controller.dart';
import 'package:app/global_resource.dart';
import 'dart:math' as math;

import 'package:flutter/services.dart';

class AbsensiIzinScreen extends StatefulWidget {
  const AbsensiIzinScreen({super.key});

  @override
  State<AbsensiIzinScreen> createState() => _AbsensiIzinScreenState();
}

class _AbsensiIzinScreenState extends State<AbsensiIzinScreen> {
  bool _validateAlasan = false;
  bool _validateLampiran = false;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return GetBuilder<IzinController>(
      init: IzinController(),
      dispose: (state) {
        state.controller!.clearFile();
      },
      builder: (s) => Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Surat Izin',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
              ),
              Transform.rotate(
                angle: math.pi / 4,
                child: IconButton(
                  icon: const Icon(
                    FeatherIcons.send,
                    color: colorBluePrimary,
                  ),
                  onPressed: () {
                    if (s.currentDate != null) {
                      izin() {
                        return s.absenIzin();
                      }

                      setState(() {
                        s.formIzin == null
                            ? _validateAlasan = true
                            : _validateAlasan = false;
                        s.fileName == null
                            ? _validateLampiran = true
                            : _validateLampiran = false;
                      });

                      if (_validateAlasan == false &&
                          _validateLampiran == false) {
                        SplashController().showConfirmationDialog2(
                          "Izin",
                          "Ajukan izin sekarang?",
                          izin,
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
          centerTitle: false,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(FeatherIcons.arrowLeft),
            onPressed: () {
              SplashController()
                  .showConfirmationDialog4("Izin", "Batal mengisi izin?", () {
                Get.back();
              });
            },
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            // This function will be called when the user presses the back button
            // Return true to allow the default back button behavior or false to perform custom actions
            // For example, you can show a confirmation dialog here
            bool confirmExit = await SplashController()
                .showConfirmationDialog4("Izin", "Batal mengisi izin?", () {
              Get.back();
            });

            return confirmExit;
          },
          child: Container(
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
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        TextFormField(
                          readOnly: true,
                          onChanged: (value) => s.namaOrang = value,
                          initialValue: s.user?["namaKaryawan"] ?? "",
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          decoration: const InputDecoration(
                            hintText: "Ketikkan disini",
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 1.5)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Lampiran (Harus terisi)",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        TextFormField(
                          onTap: () {
                            s.updateFile(Get.arguments["isFoto"]);
                          },
                          readOnly: true,
                          // initialValue: ,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            hintText: (s.fileName == null)
                                ? "File_surat_sakit.docx"
                                : s.fileName,
                            errorText: _validateLampiran ? "" : null,
                            errorStyle: const TextStyle(height: 0),
                            errorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5, color: Colors.red), //<-- SEE HERE
                            ),
                            focusedErrorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5, color: Colors.red), //<-- SEE HERE
                            ),
                            hintStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1)),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 1.5)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Alasan (Harus terisi)",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Center(
                          child: FormField(
                            builder: (c) => InputDecorator(
                              decoration: InputDecoration(
                                hintText: "Pilih alasan",
                                hintStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                                contentPadding: const EdgeInsets.all(0),
                                errorText: _validateAlasan ? "" : null,
                                errorStyle: const TextStyle(height: 0),
                                border: InputBorder.none,
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.black,
                                  ), //<-- SEE HERE
                                ),
                                errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5,
                                      color: Colors.red), //<-- SEE HERE
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.5)),
                              ),
                              isEmpty: s.formIzin == null,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                    icon: const Icon(
                                      FeatherIcons.chevronDown,
                                      size: 20,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20.0)),
                                    key: Key(s.formIzin ?? "Izin"),
                                    value: s.formIzin,
                                    isExpanded: true,
                                    items: s.izinList!
                                        .map<DropdownMenuItem<String>>(
                                            (value) => DropdownMenuItem<String>(
                                                  value:
                                                      value["value"].toString(),
                                                  child: Text(
                                                    '${value["nama"]}',
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        customTextRich2(context, "Keterangan",
                            " (Kosongkan jika tidak ada)"),
                        SizedBox(
                          height: 120,
                          child: TextFormField(
                            onChanged: (value) => s.formDeskripsi = value,
                            maxLength: null,
                            keyboardType: TextInputType.multiline,
                            maxLines: 15,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              hintText: "Ketikkan disini",
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1)),
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
      ),
    );
  }
}
