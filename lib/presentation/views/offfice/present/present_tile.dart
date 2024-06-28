import 'package:app/data/models/absence.dart';
import 'package:app/global_resource.dart';

class PresentListTile extends StatelessWidget {
  PresentListTile({super.key, required this.data});

  final Absence data;
  final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: 5,
      onLongPress: () {
        tooltipkey.currentState?.ensureTooltipVisible();
        Future.delayed(const Duration(seconds: 1), () {
          Tooltip.dismissAllToolTips();
        });
      },
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildImage(context),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      _buildNamaKaryawan(context),
                      if (data.waktuCheckOut == null) _buildTooltip(),
                      const Spacer(),
                      _buildTime(),
                    ],
                  ),
                  const SizedBox(height: 5),
                  _buildSubtitle(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildTooltip() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 4),
      child: Tooltip(
        triggerMode: TooltipTriggerMode.manual,
        showDuration: const Duration(seconds: 1),
        message: tr('active'),
        textStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
        decoration: const BoxDecoration(
          color: colorGreenPrimary2,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        preferBelow: false,
        verticalOffset: -16,
        margin: const EdgeInsets.only(left: 96),
        key: tooltipkey,
        child: const Icon(
          Icons.circle,
          color: colorGreenPrimary2,
          size: 12,
        ),
      ),
    );
  }

  Row _buildSubtitle() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {},
          child: Image.asset(
            'assets/icons/map-pin.png',
            width: 16,
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {},
            child: Text(
              data.alamatPulang ?? data.alamatLoc ?? '',
              maxLines: 1,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ),
        const SizedBox(width: 16),
        const Icon(Icons.keyboard_arrow_down, size: 20),
      ],
    );
  }

  Widget _buildTime() {
    return Text(
      kTimeFormat.format(data.waktuCheckOut ?? data.waktuCheckIn!),
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: Colors.black,
      ),
      textAlign: TextAlign.right,
    );
  }

  Widget _buildNamaKaryawan(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.5,
      ),
      child: Text(
        data.namaKaryawan ?? '-',
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        strutStyle: const StrutStyle(fontSize: 12.0),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
    );
  }

  GestureDetector _buildImage(BuildContext context) {
    final image =
        data.fotoPulang ?? data.fotoKaryawan ?? 'assets/icons/logo/hora.png';
    final cloud = image.startsWith('wwwroot/');
    return GestureDetector(
      onTap: () {},
      child: buildImageList(
        context,
        cloud ? changeUrlImage(image) : image,
        !cloud,
      ),
    );
  }
}
