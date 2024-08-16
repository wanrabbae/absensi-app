import 'package:app/data/models/laporan/laporan.dart';
import 'package:app/global_resource.dart';
import 'package:app/presentation/widgets/images.dart';
import 'package:flutter/material.dart';

class ReportTileView extends StatelessWidget {
  const ReportTileView(this.laporan, {super.key, required this.onTap});

  final Laporan laporan;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final image = laporan.fileReimb;
    final title = laporan.keterangan;
    final location = laporan.lokasi;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: AspectRatio(
            aspectRatio: 2,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                border: Border.fromBorderSide(
                  BorderSide(color: Colors.black, width: 1),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: FadeInImage(
                  placeholder: kImagePlaceholder,
                  image: NetworkImage(image),
                  imageErrorBuilder: (context, error, stackTrace) =>
                      kImagePlaceholderWidget,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        ListTile(
          contentPadding: const EdgeInsets.only(left: 16, right: 8),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: [
              const Icon(Icons.location_pin, size: 14),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  location,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          trailing: PopupMenuButton<String>(
            itemBuilder: (context) {
              return [];
            },
          ),
        ),
      ],
    );
  }
}
