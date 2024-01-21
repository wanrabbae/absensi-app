import 'dart:math' as math;

import 'package:app/data/models/klaim/klaim.dart';
import 'package:app/global_resource.dart';
import 'package:app/views/home/components/appbar.dart';

class KlaimDetailView extends StatelessWidget {
  const KlaimDetailView({super.key, required this.klaim});

  final Klaim klaim;

  @override
  Widget build(BuildContext context) {
    final keteranganController =
        TextEditingController(text: klaim.keterangan ?? '');
    final imageUrl = changeUrlImage(klaim.file);

    return Scaffold(
      appBar: HoraAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: Container(
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
                        child: Image.network(imageUrl),
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
                          arguments: imageUrl,
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
            ),
          ),
          SafeArea(
            minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: TextFormField(
              controller: keteranganController,
              decoration: const InputDecoration(
                hintText: 'Tidak ada keterangan',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colorBluePrimary, width: 2),
                ),
              ),
              readOnly: true,
              minLines: 5,
              maxLines: null,
            ),
          ),
        ],
      ),
    );
  }
}
