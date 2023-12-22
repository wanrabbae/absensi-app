import 'package:app/global_resource.dart';

Widget formProfile(context, s) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.max,
    children: [
      Expanded(
        flex: 1,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: GestureDetector(
                    onTap: () async {
                      showDialog(
                          barrierDismissible: true,
                          useSafeArea: true,
                          context: context,
                          builder: (ctx) {
                            return Center(
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                width: MediaQuery.of(ctx).size.width - 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        s.imagePick(1);
                                      },
                                      child: const Icon(
                                        FeatherIcons.camera,
                                        size: 40,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        s.imagePick(2);
                                      },
                                      child: const Icon(
                                        FeatherIcons.image,
                                        size: 40,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: buildImageProfileBig(
                        context,
                        HomeController().gambarSearch(s.user, 1),
                        HomeController().gambarSearch(s.user, 2),
                        s.formFoto),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4, left: 4),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2, bottom: 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Nama"),
                                  TextFormField(
                                    style:
                                        const TextStyle(fontWeight: FontWeight.bold),
                                    initialValue: s.user?['namaKaryawan'],
                                    onChanged: (value) => s.profileNama = value,
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      enabledBorder: UnderlineInputBorder(),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: colorBluePrimary)),
                                      errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.redAccent)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Jenis Kelamin"),
                                  DropdownButtonFormField<String>(
                                    value: s.user?["gender"],
                                    icon: const Icon(FeatherIcons.chevronDown),
                                    onChanged: (newValue) {
                                      // Update the selected value when the user chooses a gender
                                      s.selectedGender = newValue;
                                    },
                                    items: const [
                                      DropdownMenuItem(
                                        value: 'pria',
                                        child: Text(
                                          'Pria',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 'wanita',
                                        child: Text(
                                          'Wanita',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      enabledBorder: UnderlineInputBorder(),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: colorBluePrimary),
                                      ),
                                      errorBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.redAccent),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Alamat e-mail"),
                                  TextFormField(
                                    initialValue: s.user?['alamatEmail'],
                                    style:
                                        const TextStyle(fontWeight: FontWeight.bold),
                                    readOnly: true,
                                    onTap: () {
                                      SplashController()
                                          .showConfirmationDialogEmail('Email',
                                              "Anda ingin mengubah email?", () {
                                        Get.toNamed(
                                            RouteName.profileGantiemail);
                                      });
                                      // showModalBottomSheet(
                                      //     shape: const RoundedRectangleBorder(
                                      //         borderRadius: BorderRadius.only(
                                      //             topLeft: Radius.circular(20),
                                      //             topRight: Radius.circular(20))),
                                      //     context: context,
                                      //     builder: (ctx) =>
                                      //         changeEmailLayout(context));
                                    },
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      enabledBorder: UnderlineInputBorder(),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: colorBluePrimary)),
                                      errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.redAccent)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.only(top: 20, bottom: 2),
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Text("Alamat e-mail"),
                            //       TextFormField(
                            //         initialValue: s.user?['alamatEmail'],
                            //         style:
                            //             TextStyle(fontWeight: FontWeight.bold),
                            //         onChanged: (value) => s.emailBaru = value,
                            //         decoration: const InputDecoration(
                            //           border: UnderlineInputBorder(),
                            //           enabledBorder: UnderlineInputBorder(),
                            //           focusedBorder: UnderlineInputBorder(
                            //               borderSide: BorderSide(
                            //                   color: colorBluePrimary)),
                            //           errorBorder: UnderlineInputBorder(
                            //               borderSide: BorderSide(
                            //                   color: Colors.redAccent)),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),

                            Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 2),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Alamat tempat tinggal"),
                                      TextFormField(
                                        key: Key(s.profileAlamat.toString()),
                                        onChanged: (value) =>
                                            s.profileAlamat = value,
                                        initialValue: s.profileAlamat,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 10,
                                        minLines: 3,
                                        decoration: const InputDecoration(
                                          border: UnderlineInputBorder(),
                                          enabledBorder: UnderlineInputBorder(),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: colorBluePrimary)),
                                          errorBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.redAccent)),
                                        ),
                                      ),
                                    ])),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.only(top: 20, bottom: 2),
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Text("Alamat tempat tinggal"),
                            //       TextFormField(
                            //         key: Key(s.profileAlamat.toString()),
                            //         initialValue: s.profileAlamat,
                            //         style:
                            //             TextStyle(fontWeight: FontWeight.bold),
                            //         keyboardType: TextInputType.multiline,
                            //         maxLines: 10,
                            //         minLines: 3,
                            //         decoration: const InputDecoration(
                            //           border: UnderlineInputBorder(),
                            //           enabledBorder: UnderlineInputBorder(),
                            //           focusedBorder: UnderlineInputBorder(
                            //               borderSide: BorderSide(
                            //                   color: colorBluePrimary)),
                            //           errorBorder: UnderlineInputBorder(
                            //               borderSide: BorderSide(
                            //                   color: Colors.redAccent)),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: 80,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () => s.hapusAkun(),
              child: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: GestureDetector(
                  // onTap: () => s.hapusAkun(),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FeatherIcons.trash2,
                        fill: 0.1,
                        color: Color.fromRGBO(225, 24, 24, 1),
                        weight: 1.5,
                      ),
                      Text(
                        "Hapus",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color.fromRGBO(225, 24, 24, 1)),
                      ),
                    ],
                  ),
                )),
              ),
            ),
          ),
        ),
      )
    ],
  );
}

 //location dialog

            //       .then(
            //   (value) {
            // if (value != null) {
            // addressController.text = value;
            // }
            // });


//hapus akun

              // () {
              // final dialogConfirm = showDialog(
              // context: context,
              // builder: (ctx) =>
              //     customDialog(
              //         context, "Anda ingin menghapus akun?", "YA",
              //         onTap: () => AppRoute.pop(true)));
              // dialogConfirm.then((value) {
              //   if (value) {
              //     showDialog(
              //         context: context,
              //         builder: (ctx) {
              //           Future.delayed(const Duration(seconds: 2))
              //               .then((value) => AppRoute.pop());
              //           return customDialogLoading(
              //               context, "Menghapus akun...");
              //         }).then((value) => showDialog(
              //         context: context,
              //         builder: (ctx) => customDialog(
              //                 context, "Akun anda telah terhapus", "OK",
              //                 onTap: () {
              //               // ref.read(prefProvider).clear();
              //               // AppRoute.pushAndFinish(Routes.AUTH_GREETING);
              // })));
              // }
              // });
              // },