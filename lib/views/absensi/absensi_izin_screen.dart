import 'package:app/global_resource.dart';

class AbsensiIzinScreen extends StatelessWidget {
  const AbsensiIzinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AbsenController>(
      init: AbsenController(),
      builder: (s) => Scaffold(
        backgroundColor: colorGrayPrimary,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: colorGrayPrimary,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Align(
                alignment: Alignment.topRight,
                child: ovalCardIcon(context, FeatherIcons.x,
                    onTaped: () => Get.back()),
              ),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          width: MediaQuery.of(context).size.width,
          color: colorGrayPrimary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Center(
                  child: customHeaderAuth(context, "Surat izin",
                      changeFormatDate(3, s.currentDate!))),
              const SizedBox(
                height: 40,
              ),
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                              child: TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(20.0),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: (s.fileName == null)
                                  ? "File_surat_sakit.docx"
                                  : s.fileName,
                              border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: colorBluePrimary),
                                  borderRadius: BorderRadius.circular(20)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: colorBluePrimary, width: 2),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              s.updateFile();
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              child: const Icon(
                                FeatherIcons.paperclip,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 60,
                        constraints: const BoxConstraints(minHeight: 60),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Center(
                          child: DropdownButtonHideUnderline(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: DropdownButton(
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
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 320,
                        child: TextFormField(
                          onChanged: (value) => s.formDeskripsi = value,
                          maxLength: null,
                          keyboardType: TextInputType.multiline,
                          maxLines: 15,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.all(20),
                              border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: colorBluePrimary),
                                  borderRadius: BorderRadius.circular(20)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: colorBluePrimary, width: 2),
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        if (s.currentDate != null) {
                          s.absenIzin();
                        }
                      },
                      style: s.currentDate != null
                          ? const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(colorBluePrimary),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)))))
                          : const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(colorGrayPrimary),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))))),
                      child: const Text(
                        "AJUKAN",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
