import 'package:app/global_resource.dart';
import 'package:app/presentation/widgets/images.dart';

class CallerTile extends StatelessWidget {
  const CallerTile({
    super.key,
    this.image,
    required this.name,
    this.status,
  });

  final String? image;
  final String name;
  final bool? status;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: image == null
          ? const CircleAvatar(foregroundImage: kImagePlaceholder)
          : CircleAvatar(
              foregroundImage: NetworkImage(changeUrlImage(image!)),
            ),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      trailing: () {
        switch (status) {
          case null:
            return const Text(
              'Tidak Diangkat',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            );
          case true:
            return const Text(
              'Diterima',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: colorBluePrimary2,
              ),
            );
          case false:
            return const Text(
              'Ditolak',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: colorBottomSheetDrag,
              ),
            );
        }
      }(),
    );
  }
}
