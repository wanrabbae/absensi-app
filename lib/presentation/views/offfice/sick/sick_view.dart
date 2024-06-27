import 'package:app/global_resource.dart';
import 'package:app/presentation/widgets/empty_view.dart';

class SickView extends StatelessWidget {
  const SickView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: EmptyView(
        image: 'assets/icons/illustrations/sick.webp',
        title: tr('sick'),
        subtitle: tr('sick_empty'),
      ),
    );
  }
}
