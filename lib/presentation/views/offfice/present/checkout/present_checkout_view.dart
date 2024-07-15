import 'package:app/helpers/constant.dart';
import 'package:app/presentation/blocs/office/present/detail/present_detail_cubit.dart';
import 'package:app/presentation/widgets/images.dart';
import 'package:app/presentation/widgets/text_fields.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class PresentCheckOutView extends StatefulWidget {
  const PresentCheckOutView({super.key});

  @override
  State<PresentCheckOutView> createState() => _PresentCheckOutViewState();
}

class _PresentCheckOutViewState extends State<PresentCheckOutView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BlocBuilder<PresentDetailCubit, PresentDetailState>(
            builder: (context, state) {
              final image = state.data.fotoPulang;

              return AspectRatio(
                aspectRatio: 1,
                child: FadeInImage(
                  placeholder: kImagePlaceholder,
                  image: image != null
                      ? NetworkImage(changeUrlImage(image))
                      : kImagePlaceholder,
                  imageErrorBuilder: (context, error, stackTrace) =>
                      kImagePlaceholderWidget,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          BlocBuilder<PresentDetailCubit, PresentDetailState>(
            builder: (context, state) {
              String value = '';
              final checkIn = state.data.waktuCheckOut;
              if (checkIn != null) {
                value = kTimeFullFormat.format(checkIn);
              }

              return HoraTextFieldViewer(
                label: tr('detail_present_clock_check_out'),
                value: value,
                leading: Boxicons.bxs_log_in_circle,
              );
            },
          ),
          const SizedBox(height: 16),
          BlocBuilder<PresentDetailCubit, PresentDetailState>(
            builder: (context, state) {
              String value = state.data.alamatPulang ?? '';

              return HoraTextFieldViewer(
                label: tr('detail_present_location_check_out'),
                value: value,
                leading: Boxicons.bxs_map,
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
