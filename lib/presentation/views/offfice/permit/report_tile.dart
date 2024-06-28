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

  Row _buildSubtitle() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/icons/file-yellow.png',
                height: 16,
              ),
              const SizedBox(width: 5),
              Text(
                data.type.status,
                maxLines: 1,
                softWrap: true,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        const Icon(Icons.keyboard_arrow_down, size: 20),
      ],
    );
  }

  Widget _buildTime() {
    return Text(
      kTimeFormat.format(data.tanggalStart),
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
        data.namaKaryawan,
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
    final image = changeUrlImage(data.iconIjin ?? 'assets/icons/logo/hora.png');
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
