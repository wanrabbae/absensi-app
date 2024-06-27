import 'package:app/global_resource.dart';
import 'package:app/presentation/widgets/empty_view.dart';

class LeaveView extends StatelessWidget {
  const LeaveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: EmptyView(
        image: 'assets/icons/illustrations/leave.webp',
        title: tr('leave'),
        subtitle: tr('leave_empty'),
      ),
    );
  }
}
