import 'package:app/controllers/live_location_log/live_location_log_cubit.dart';
import 'package:app/global_resource.dart';
import 'package:app/presentation/widgets/empty_view.dart';
import 'package:app/presentation/views/offfice/present/location/location_log_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationLogView extends StatefulWidget {
  const LocationLogView({super.key});

  @override
  State<LocationLogView> createState() => _LocationLogViewState();
}

class _LocationLogViewState extends State<LocationLogView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<LiveLocationLogCubit>().fetch();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<LiveLocationLogCubit, LiveLocationLogState>(
      builder: (context, state) {
        final data = state.data;
        final error = state.error;

        if (data == null && error == null) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        if (error != null) {
          return const EmptyView(
            image: 'assets/icons/absen-ilus.webp',
            title: '',
            subtitle: '',
          );
        }

        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            for (int i = 0; i < data!.length; i++)
              LocationLogTile(
                data[i],
                first: i == 0,
                second: i == 1,
                last: i == data.length - 1,
              ),
            const SizedBox(height: 16),
            Text(
              tr('live_location_log_footer'),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
