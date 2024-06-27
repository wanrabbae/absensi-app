import 'package:app/global_resource.dart';
import 'package:app/presentation/widgets/empty_view.dart';

class PresentView extends StatelessWidget {
  const PresentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: EmptyView(
        image: 'assets/icons/illustrations/present.webp',
        title: tr('present'),
        subtitle: tr('present_empty'),
      ),
    );
  }
}
