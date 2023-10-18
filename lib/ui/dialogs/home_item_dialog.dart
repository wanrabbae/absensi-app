import 'package:app/cubits/live_location_cubit/live_location_cubit.dart';
import 'package:app/firebase_models/user_fm.dart';
import 'package:app/global_resource.dart';
import 'package:app/models/user_model/user_model.dart';
import 'package:app/views/live_location/live_location_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:supercharged/supercharged.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeItemDialog extends StatefulWidget {
  final UserModel? userModel;
  const HomeItemDialog({
    super.key,
    required this.userModel,
  });

  @override
  State<HomeItemDialog> createState() => _HomeItemDialogState();
}

class _HomeItemDialogState extends State<HomeItemDialog> {
  @override
  void initState() {
    super.initState();
    context.read<LiveLocationCubit>().fetch(
          userModel: widget.userModel,
        );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 5,
            left: 5,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          Positioned(
            top: size.height * 0.05,
            child: Row(
              children: [
                Text(
                  widget.userModel?.namaKaryawan ?? '-',
                  style: GoogleFonts.rubik(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                5.widthBox,
                Icon(
                  Icons.circle,
                  color: colorGreenPrimary2,
                  size: 15,
                ),
              ],
            ),
          ),
          Center(
            child: CircleAvatar(
              radius: size.height * 0.08,
              child: widget.userModel?.foto == null
                  ? Text(
                      widget.userModel?.firstCharName ?? '-',
                    )
                  : null,
              backgroundImage: widget.userModel?.foto != null ? NetworkImage(widget.userModel?.fotoUrl ?? '') : null,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(20),
              width: size.width,
              child: Row(
                // mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: FilledButton(
                    onPressed: () {
                      Get.snackbar('MAINTENANCE', 'Fitur ini sedang dalam pengembangan');
                    },
                    child: Text('Detail Hadir',
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w600,
                          color: '#1865E2'.toColor(),
                        )),
                    style: FilledButton.styleFrom(
                      backgroundColor: '#E8F0FC'.toColor(),
                    ),
                  )),
                  20.widthBox,
                  Expanded(child: BlocBuilder<LiveLocationCubit, LiveLocationState>(
                    builder: (context, state) {
                      if (state is LiveLocationLoading) {
                        return FilledButton(
                          onPressed: () {},
                          child: SpinKitThreeBounce(
                            color: Vx.white,
                            size: 20,
                          ),
                        );
                      }

                      UserFm? userFm;
                      if (state is LiveLocationOk && state.feature == 'fetch') {
                        userFm = state.data;
                      }

                      return FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: userFm == null ? Vx.gray500 : null,
                          ),
                          onPressed: () {
                            if (userFm == null) {
                              return;
                            }
                            Get.to(() => LiveLocationPage(
                                  userModel: widget.userModel,
                                ));
                          },
                          child: Text('Cek Lokasi'));
                    },
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
