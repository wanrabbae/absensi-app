import 'package:app/global_resource.dart';

Widget dialogGender(context, value) {
  return Wrap(
    children: [
      GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (s) => SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: ovalCardIcon(context, FeatherIcons.x,
                            onTaped: () => Get.back()),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GestureDetector(
                      onTap: () {
                        s.changeGender("pria");
                      },
                      child: ovalCardIconGender(context, Icons.male_rounded,
                          s.selectedGender != "pria"),
                    ),
                    const SizedBox(width: 30),
                    GestureDetector(
                      onTap: () {
                        s.changeGender("wanita");
                      },
                      child: ovalCardIconGender(context, Icons.female_rounded,
                          s.selectedGender != "wanita"),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text("Tekan tombol untuk menyimpan"),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(colorBluePrimary),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                        ),
                      ),
                      child: const Text(
                        "Simpan",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    ],
  );
}
