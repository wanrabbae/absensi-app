import 'package:app/global_resource.dart';

import 'work_handlers.dart';

class WorkFAB extends StatelessWidget {
  const WorkFAB({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DefaultTabController.of(context);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        if (controller.index == 0) {
          return const SizedBox.shrink();
        }

        return AddFAB(index: controller.index);
      },
    );
  }
}

class AddFAB extends StatelessWidget {
  const AddFAB({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (index == 2) {
          handleFabReimburse(context);
        } else if (index == 1) {}
      },
      backgroundColor: colorBluePrimary2,
      foregroundColor: Colors.white,
      elevation: 0,
      child: const Icon(Icons.add),
    );
  }
}
