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
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   title: Container(
        //     margin: EdgeInsets.only(right: 250),
        //     child: Text(
        //       'Sunting',
        //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        //     ),
        //   ),
        //   leading: Container(
        //     // width: 300,
        //     padding: EdgeInsets.only(left: 3),
        //     decoration: BoxDecoration(border: Border.all()),
        //     child: Row(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         IconButton(
        //           icon: Icon(FeatherIcons.x),
        //           onPressed: () {
        //             Get.back();
        //           },
        //         ),
        //         SizedBox(
        //           height: 0,
        //         ),
        //         // // Padding(padding: EdgeInsets.only(right: 20)),
        //         // Text(
        //         //   "Sunting",
        //         //   style: TextStyle(
        //         //     fontSize: 18,
        //         //     fontWeight: FontWeight.bold,
        //         //   ),
        //         // ),
        //       ],
        //     ),
        //   ),
        //   actions: [
        //     Padding(
        //         padding: const EdgeInsets.only(right: 20),
        //         child: GestureDetector(
        //           onTap: () => s.editData(),
        //           child: SizedBox(
        //             child: Center(
        //               child: Icon(
        //                 FeatherIcons.userCheck,
        //                 color: colorBluePrimary2,
        //               ),
        //             ),
        //           ),
        //         ))
        //   ],
        // ),
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.only(top: 60),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(FeatherIcons.x),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      Text(
                        'Sunting',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: GestureDetector(
                      onTap: () => s.editData(),
                      child: SizedBox(
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
              Expanded(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: formProfile(context, s)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
