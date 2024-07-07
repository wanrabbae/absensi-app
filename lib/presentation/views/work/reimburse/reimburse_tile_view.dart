import 'package:app/data/models/klaim/klaim.dart';
import 'package:app/global_resource.dart';
import 'package:flutter/cupertino.dart';

class ReimburseTileView extends StatelessWidget {
  const ReimburseTileView(this.klaim, {super.key, required this.onTap});

  final Klaim klaim;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: 5,
      onTap: onTap,
      child: Column(
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              _buildProfileImage(klaim, size: 60),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(child: _buildTitle()),
                        _buildTrailing(),
                      ],
                    ),
                    _buildSubtitle(),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildKlaimImage(klaim),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      klaim.namaKaryawan,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      klaim.keterangan ?? tr('claim_form_field_hint'),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: const TextStyle(
        color: colorBlackPrimaryHalf,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    );
  }

  Widget _buildTrailing() {
    return Text(
      kTimeFormat.format(klaim.tanggal.toLocal()),
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: Colors.black,
      ),
      textAlign: TextAlign.right,
    );
  }
}

class ReimburseGridTileView extends StatelessWidget {
  const ReimburseGridTileView(this.klaim, {super.key, required this.onTap});

  final Klaim klaim;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Widget child = Stack(
      children: [
        Positioned.fill(child: _buildKlaimImage(klaim)),
        Center(child: _buildProfileImage(klaim, size: 40)),
      ],
    );

    child = InkWell(radius: 5, onTap: onTap, child: child);

    return child;
  }
}

Widget _buildKlaimImage(Klaim klaim) {
  return Container(
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      border: Border.fromBorderSide(
        BorderSide(color: colorSplash, width: 3),
      ),
    ),
    child: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(18)),
      child: Image.network(changeUrlImage(klaim.file), fit: BoxFit.cover),
    ),
  );
}

Widget _buildProfileImage(Klaim klaim, {required double size}) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: Colors.white,
      image: klaim.foto.startsWith('assets')
          ? DecorationImage(
              image: AssetImage(klaim.foto),
              fit: BoxFit.cover,
            )
          : DecorationImage(
              image: NetworkImage(changeUrlImage(klaim.foto)),
              fit: BoxFit.cover,
            ),
      borderRadius: const BorderRadius.all(Radius.circular(50)),
      border: const Border.fromBorderSide(
        BorderSide(color: colorBottomSheetDrag, width: 3),
      ),
    ),
  );
}
