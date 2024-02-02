import 'dart:math' as math;

import 'package:app/controllers/izin_controller.dart';
import 'package:app/global_resource.dart';
import 'package:app/views/_components/dialog.dart';
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
              Text(
                tr('permit_letter'),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
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
                        showConfirmationDialog2(
                          tr('permit'),
                          tr('apply_for_permit'),
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
              showConfirmationDialog4(
                  tr('permit'), tr('apply_for_permit_cancellation'), () {
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
            bool confirmExit = await showConfirmationDialog4(
                tr('permit'), tr('apply_for_permit_cancellation'), () {
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
                        Text(
                          tr('name'),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextFormField(
                          readOnly: true,
                          onChanged: (value) => s.namaOrang = value,
                          initialValue: s.user?["namaKaryawan"] ?? "",
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            hintText: tr('type_here'),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          tr('attachment_required'),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
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
                                ? tr('attachment_hint')
                                : s.fileName,
                            errorText: _validateLampiran ? "" : null,
                            errorStyle: const TextStyle(height: 0),
                            errorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.5,
                                color: Colors.red,
                              ),
                            ),
                            focusedErrorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.5,
                                color: Colors.red,
                              ),
                            ),
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          tr('reason_required'),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Center(
                          child: FormField(
                            builder: (c) => InputDecorator(
                              decoration: InputDecoration(
                                hintText: tr('choose_reason'),
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
                                  ),
                                ),
                                errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.5,
                                    color: Colors.red,
                                  ),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              isEmpty: s.formIzin == null,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  icon: const Icon(
                                    FeatherIcons.chevronDown,
                                    size: 20,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                  key: Key(s.formIzin ?? tr('permit')),
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
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      s.updateFormIzin(value);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        customTextRich2(
                          context,
                          tr('description'),
                          tr('description_end'),
                        ),
                        SizedBox(
                          height: 120,
                          child: TextFormField(
                            onChanged: (value) => s.formDeskripsi = value,
                            maxLength: null,
                            keyboardType: TextInputType.multiline,
                            maxLines: 15,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              hintText: tr('type_here'),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
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
