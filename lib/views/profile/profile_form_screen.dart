import 'package:app/global_resource.dart';
import 'components/form_profile.dart';

class ProfileFormScreen extends StatelessWidget {
  const ProfileFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (s) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(FeatherIcons.x),
                onPressed: () {
                  Get.back();
                },
              ),
              SizedBox(
                height: 0,
              ),
              // // Padding(padding: EdgeInsets.only(right: 20)),
              // Text(
              //   "Sunting",
              //   style: TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: ovalCardIcon(
                context,
                FeatherIcons.userCheck,
                onTaped: () => s.editData(),
              ),
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: formProfile(context, s)),
      ),
    );
  }
}
