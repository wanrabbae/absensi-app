import 'package:app/data/models/absence.dart';
import 'package:app/global_resource.dart';
import 'package:app/presentation/widgets/bottomsheet.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class PresentListTile extends StatelessWidget {
  PresentListTile({super.key, required this.data, this.isCurrent = false});

  final Absence data;
  final bool isCurrent;
  final GlobalKey<TooltipState> tooltipKey = GlobalKey<TooltipState>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: 5,
      onLongPress: () {
        tooltipKey.currentState?.ensureTooltipVisible();
        Future.delayed(const Duration(seconds: 1), () {
          Tooltip.dismissAllToolTips();
        });
      },
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 4, 8),
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
                      Flexible(
                        fit: FlexFit.tight,
                        child: _buildNamaKaryawan(context),
                      ),
                      if (data.waktuCheckOut == null) _buildTooltip(),
                    ],
                  ),
                  _buildSubtitle(),
                ],
              ),
            ),
            const SizedBox(width: 10),
            if (!isCurrent) ...{
              IconButton(
                onPressed: () => _handleCallingUser(context),
                style: IconButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                ),
                icon: const Icon(Boxicons.bx_bell),
              ),
              IconButton(
                onPressed: () => _handleRequestLiveLocation(context),
                style: IconButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                ),
                icon: const Icon(Boxicons.bx_map),
              ),
            },
            IconButton(
              onPressed: () => _handleShowDetail(context),
              style: IconButton.styleFrom(
                visualDensity: VisualDensity.compact,
              ),
              icon: const Icon(Boxicons.bx_dots_vertical_rounded),
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
        key: tooltipKey,
        child: const Icon(
          Icons.circle,
          color: colorGreenPrimary2,
          size: 12,
        ),
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      data.alamatPulang ?? data.alamatLoc ?? '',
      maxLines: 1,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: 16, color: Colors.black),
    );
  }

  Widget _buildNamaKaryawan(BuildContext context) {
    return Text(
      data.namaKaryawan ?? '-',
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      strutStyle: const StrutStyle(fontSize: 12.0),
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 16,
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
        size: 48,
      ),
    );
  }

  _handleCallingUser(BuildContext context) {
    showHoraInfoBottomSheet(
      context,
      title: tr('caller_bottom_sheet_title'),
      message: tr('caller_bottom_sheet_message'),
    );
  }

  _handleRequestLiveLocation(BuildContext context) {
    showHoraInfoBottomSheet(
      context,
      title: tr('request_location_bottom_sheet_title'),
      message: tr('request_location_sent'),
    );
  }

  _handleShowDetail(BuildContext context) {
    Get.toNamed(RouteName.absenDetail, arguments: data);
  }
}
