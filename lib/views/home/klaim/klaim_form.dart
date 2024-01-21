import 'dart:math' as math;
import 'dart:typed_data';

import 'package:app/controllers/app/app_cubit.dart';
import 'package:app/controllers/klaim/form/klaim_form_cubit.dart';
import 'package:app/global_resource.dart';
import 'package:app/views/home/components/appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KlaimForm extends StatelessWidget {
  const KlaimForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<KlaimFormCubit, KlaimFormState>(
      listener: (context, state) {
        if (state.busy == false) {
          final error = state.error;
          if (error != null) {
            customSnackbar1(error);
            return;
          }

          customSnackbar1('Klaim telah terunggah.');
          Navigator.pop(context, true);
        }
      },
      child: Scaffold(
        appBar: HoraAppBar(
          context,
          title: const Text('Unggah Klaim'),
          actions: [
            IconButton(
              onPressed: () {
                customSnackbar1('Sedang mengunggah klaim...');
                final app = context.read<AppCubit>();
                final state = app.state;
                final profile = state.currentUser!;
                context.read<KlaimFormCubit>().submit(profile);
              },
              icon: Transform.rotate(
                angle: math.pi / 4,
                child: const Icon(
                  FeatherIcons.send,
                  color: colorBluePrimary,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: Column(
          children: [
            Expanded(child: BlocBuilder<KlaimFormCubit, KlaimFormState>(
              builder: (context, state) {
                return FutureBuilder<Uint8List>(
                  future: state.file.readAsBytes(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: const Border.fromBorderSide(
                          BorderSide(color: colorSplash, width: 3),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Hero(
                                tag: 'img',
                                child: Image.memory(snapshot.data!),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 16,
                            right: 16,
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  RouteName.klaimImageViewer,
                                  arguments: snapshot.data!,
                                );
                              },
                              child: CircleAvatar(
                                backgroundColor: colorBluePrimary,
                                child: Transform.rotate(
                                  angle: math.pi / -4,
                                  child: const Icon(
                                    FeatherIcons.code,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            )),
            SafeArea(
              minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: TextFormField(
                controller: context.read<KlaimFormCubit>().keteranganController,
                decoration: const InputDecoration(
                  hintText: 'Tidak ada keterangan',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorBluePrimary, width: 2),
                  ),
                ),
                minLines: 5,
                maxLines: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
