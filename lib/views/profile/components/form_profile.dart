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
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () => s.imagePick(1),
                                    child: const Icon(
                                      FeatherIcons.camera,
                                      size: 40,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => s.imagePick(2),
                                    child: const Icon(
                                      FeatherIcons.image,
                                      size: 40,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: buildImageProfileBig(
                      context,
                      HomeController().gambarSearch(s.user, 1),
                      HomeController().gambarSearch(s.user, 2),
                      s.formFoto,
                    ),
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
                                Text(tr('name')),
                                TextFormField(
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  initialValue: s.user?['namaKaryawan'],
                                  onChanged: (value) => s.profileNama = value,
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
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(tr('gender')),
                                DropdownButtonFormField<String>(
                                  value: s.user?["gender"],
                                  icon: const Icon(FeatherIcons.chevronDown),
                                  onChanged: (newValue) {
                                    // Update the selected value when the user chooses a gender
                                    s.selectedGender = newValue;
                                  },
                                  items: [
                                    DropdownMenuItem(
                                      value: 'pria',
                                      child: Text(
                                        tr('gender_male'),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: 'wanita',
                                      child: Text(
                                        tr('gender_female'),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
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
                            padding: const EdgeInsets.only(top: 20, bottom: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(tr('email')),
                                TextFormField(
                                  initialValue: s.user?['alamatEmail'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  readOnly: true,
                                  onTap: () {
                                    SplashController()
                                        .showConfirmationDialogEmail(
                                      tr('email'),
                                      tr('email_change_confirmation'),
                                      () => Get.toNamed(
                                          RouteName.profileGantiemail),
                                    );
                                  },
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
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(tr('address')),
                                TextFormField(
                                  key: Key(s.profileAlamat.toString()),
                                  onChanged: (value) => s.profileAlamat = value,
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
                                      borderSide:
                                          BorderSide(color: colorBluePrimary),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.redAccent),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          FeatherIcons.trash2,
                          fill: 0.1,
                          color: Color.fromRGBO(225, 24, 24, 1),
                          weight: 1.5,
                        ),
                        Text(
                          tr('delete'),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color.fromRGBO(225, 24, 24, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
