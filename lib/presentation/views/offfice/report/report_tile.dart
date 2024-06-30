import 'package:app/data/models/report/report.dart';
import 'package:app/global_resource.dart';

class ReportListTile extends StatelessWidget {
  const ReportListTile({super.key, required this.data});

  final Report data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: 5,
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildImage(context),
                    const SizedBox(width: 10),
                    Expanded(child: _buildNamaKaryawan(context)),
                    _buildTime(),
                  ],
                ),
                const SizedBox(height: 8),
                Image.network(
                  changeUrlImage(data.dokumen),
                  width: constraints.maxWidth,
                  height: constraints.maxWidth * 3 / 8,
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildDocument(Container(
                      color: colorSplash,
                      height: constraints.maxWidth * 3 / 8,
                    ));
                  },
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                    if (wasSynchronouslyLoaded) {
                      return _buildDocument(child);
                    }

                    return AnimatedOpacity(
                      opacity: frame == null ? 0 : 1,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeOut,
                      child: _buildDocument(child),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTime() {
    return Text(
      kTimeFormat.format(data.tanggalStart.toLocal()),
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: Colors.black,
      ),
      textAlign: TextAlign.right,
    );
  }

  Widget _buildNamaKaryawan(BuildContext context) {
    return Text(
      data.namaKaryawan,
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
    final image = changeUrlImage(data.iconIjin ?? 'assets/icons/logo/hora.png');
    final cloud = image.startsWith('wwwroot/');
    return GestureDetector(
      onTap: () {},
      child: buildImageList(
        context,
        cloud ? changeUrlImage(image) : image,
        !cloud,
        size: 32,
      ),
    );
  }

  Widget _buildDocument(Widget child) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        border: Border.fromBorderSide(
          BorderSide(color: colorSplash, width: 3),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(13)),
        child: child,
      ),
    );
  }
}
