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
                                  Text("Nama"),
                                  TextFormField(
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
                                  Text("Jenis Kelamin"),
                                  TextFormField(
                                    key: Key(s.valueGender().toString()),
                                    initialValue: s.valueGender(),
                                    onTap: () {
                                      showModalBottomSheet(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight:
                                                      Radius.circular(20))),
                                          context: context,
                                          builder: (ctx) =>
                                              dialogGender(context, s));
                                    },
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                        border: UnderlineInputBorder(),
                                        enabledBorder: UnderlineInputBorder(),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: colorBluePrimary)),
                                        errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.redAccent)),
                                        suffixIcon: Padding(
                                          padding: EdgeInsets.only(left: 50),
                                          child:
                                              Icon(FeatherIcons.moreVertical),
                                        )),
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
                                  Text("Alamat e-mail"),
                                  TextFormField(
                                    initialValue: s.user?['alamatEmail'],
                                    readOnly: true,
                                    onTap: () {
                                      SplashController().showConfirmationDialog(
                                          'Email', "Anda ingin mengubah email?",
                                          () {
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
                                        suffixIcon: Padding(
                                          padding: EdgeInsets.only(left: 50),
                                          child:
                                              Icon(FeatherIcons.moreVertical),
                                        )),
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
                                  Text("Alamat tempat tinggal"),
                                  TextFormField(
                                    key: Key(s.profileAlamat.toString()),
                                    initialValue: s.profileAlamat,
                                    onTap: () {
                                      showModalBottomSheet(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight:
                                                      Radius.circular(20))),
                                          context: context,
                                          builder: (ctx) =>
                                              const DialogDetectLocation());
                                    },
                                    readOnly: true,
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
                                        suffixIcon: Padding(
                                          padding: EdgeInsets.only(left: 50),
                                          child:
                                              Icon(FeatherIcons.moreVertical),
                                        )),
                                  ),
                                ],
                              ),
                            ),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FeatherIcons.trash2,
                        color: Color.fromRGBO(225, 24, 24, 1),
                        weight: 1.5,
                      ),
                      const Text(
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