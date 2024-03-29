import 'package:app/global_resource.dart';

import 'components/form_profile.dart';

class ProfileFormScreen extends StatelessWidget {
  const ProfileFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (s) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: false,
          title: Text(
            tr('edit'),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
          ),
          leading: Container(
            padding: const EdgeInsets.only(left: 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(FeatherIcons.x),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () => s.editData(),
                child: const SizedBox(
                  child: Center(
                    child: Icon(
                      FeatherIcons.userCheck,
                      color: colorBluePrimary2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: formProfile(context, s),
        ),
      ),
    );
  }
}
