import 'package:app/global_resource.dart';
import 'package:app/presentation/widgets/empty_view.dart';

class PermitView extends StatelessWidget {
  const PermitView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: EmptyView(
        image: 'assets/icons/illustrations/permit.webp',
        title: tr('permit'),
        subtitle: tr('permit_empty'),
      ),
    );
  }
}
