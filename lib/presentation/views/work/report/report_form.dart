import 'package:app/controllers/app/app_cubit.dart';
import 'package:app/data/models/profile.dart';
import 'package:app/global_resource.dart';
import 'package:app/presentation/blocs/work/laporan/form/laporan_form_cubit.dart';
import 'package:app/presentation/views/work/work_handlers.dart';
import 'package:app/presentation/widgets/bottomsheet.dart';
import 'package:app/presentation/widgets/buttons.dart';
import 'package:app/views/home/components/appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class _ReportFormState {
  bool showBusy = false;
  bool showFailed = false;
  bool showSucceed = false;

  bool get isAnyModalShow => showBusy || showFailed || showSucceed;

  void reset() {
    showBusy = false;
    showFailed = false;
    showSucceed = false;
  }
}

final _state = _ReportFormState();

class ReportForm extends StatelessWidget {
  ReportForm({super.key}) {
    _state.reset();
  }

  @override
  Widget build(BuildContext context) {
    final child = Scaffold(
      appBar: HoraAppBar(
        context,
        titleSpacing: 0,
        title: BlocBuilder<AppCubit, AppState>(
          buildWhen: (previous, current) =>
              previous.currentUser != current.currentUser,
          builder: (context, state) {
            final user = state.currentUser;
            if (user == null) {
              return Text(tr('menu_work_report'));
            }

            final photo = user.photo;
            final name = user.name;
            late final ImageProvider image;
            if (photo != null) {
              image = NetworkImage(changeUrlImage(photo));
            } else {
              image = const AssetImage('assets/icons/logo/hora.png');
            }

            return Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  foregroundImage: image,
                ),
                const SizedBox(width: 16),
                if (name != null) Text(name),
              ],
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<LaporanFormCubit>().submit();
            },
            icon: const Icon(Boxicons.bx_send),
          ),
          const SizedBox(width: 8),
        ],
      ),
      backgroundColor: Colors.black,
      extendBody: true,
      body: BlocBuilder<LaporanFormCubit, LaporanFormState>(
        buildWhen: (previous, current) => previous.file != current.file,
        builder: (context, state) {
          return InteractiveViewer(
            child: Center(child: Image.file(File(state.file.path))),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Row(
          children: [
            HoraButton(
              onPressed: () => _handleTakePicture(context),
              child: const Icon(Boxicons.bx_camera),
            ),
            const SizedBox(width: 16),
            BlocBuilder<LaporanFormCubit, LaporanFormState>(
              buildWhen: (previous, current) => previous.tag != current.tag,
              builder: (context, state) {
                final isSet = state.tag.isNotEmpty;

                if (isSet) {
                  return HoraButton(
                    onPressed: () => _handleTag(context),
                    child: const Icon(Boxicons.bx_at),
                  );
                }

                return HoraButton.white(
                  onPressed: () => _handleTag(context),
                  child: const Icon(Boxicons.bx_at),
                );
              },
            ),
            const SizedBox(width: 16),
            BlocBuilder<LaporanFormCubit, LaporanFormState>(
              buildWhen: (previous, current) =>
                  previous.description != current.description,
              builder: (context, state) {
                final isSet = state.description.isNotEmpty;

                if (isSet) {
                  return HoraButton(
                    onPressed: () => _handleInputDescription(context),
                    child: const Icon(Boxicons.bx_pencil),
                  );
                }

                return HoraButton.white(
                  onPressed: () => _handleInputDescription(context),
                  child: const Icon(Boxicons.bx_pencil),
                );
              },
            ),
            const SizedBox(width: 16),
            Expanded(
              child: BlocBuilder<LaporanFormCubit, LaporanFormState>(
                buildWhen: (previous, current) =>
                    previous.address != current.address,
                builder: (context, state) {
                  final isSet = state.address.isNotEmpty;

                  if (isSet) {
                    return HoraButton.withIcon(
                      onPressed: () => _handleInputLocation(context),
                      icon: const Icon(Boxicons.bxs_map),
                      label: Text(tr('location')),
                    );
                  }

                  return HoraButton.whiteWithIcon(
                    onPressed: () => _handleInputLocation(context),
                    icon: const Icon(Boxicons.bxs_map),
                    label: Text(tr('location')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );

    return BlocListener<LaporanFormCubit, LaporanFormState>(
      listenWhen: (previous, current) => previous.submit != current.submit,
      listener: (context, state) {
        final submit = state.submit;

        if (submit == null) return;

        if (_state.isAnyModalShow) {
          Navigator.pop(context);
        }

        switch (submit) {
          case StateSubmit.busy:
            _state.showBusy = true;
            showHoraLoadingBottomSheet(
              context,
              onCancel: () {
                context.read<LaporanFormCubit>().cancelSubmit();
              },
            ).then((_) {
              _state.showBusy = false;
            });
            break;
          case StateSubmit.failed:
            _state.showFailed = true;
            showHoraInfoBottomSheet(
              context,
              title: tr('report_bottom_sheet_info_title'),
              message: tr('report_bottom_sheet_info_message_failed'),
            ).then((_) {
              _state.showFailed = false;
            });
            break;
          case StateSubmit.succeed:
            _state.showSucceed = true;
            showHoraInfoBottomSheet(
              context,
              title: tr('report_bottom_sheet_info_title'),
              message: tr('report_bottom_sheet_info_message_succeed'),
            ).then((_) {
              _state.showSucceed = false;
              Navigator.pop(context, true);
            });
            break;
          case StateSubmit.canceled:
            customSnackbar1(tr('bottom_sheet_loading_canceled_message'));
            break;
        }
      },
      child: child,
    );
  }

  _handleTakePicture(BuildContext context) {
    pickImage().then((XFile? image) {
      if (image == null) {
        return;
      }

      final cubit = context.read<LaporanFormCubit>();
      cubit.setFile(image);
    });
  }

  _handleInputDescription(BuildContext context) {
    final cubit = context.read<LaporanFormCubit>();
    final controller = TextEditingController(text: cubit.state.description);

    showHoraCustomBottomSheet(
      context,
      title: tr('report_bottom_sheet_title'),
      slideUpWithKeyboard: true,
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: tr('report_bottom_sheet_textfield_hint'),
        ),
        textCapitalization: TextCapitalization.sentences,
        minLines: 3,
        maxLines: 3,
      ),
      button: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          final isEmpty = controller.text.isEmpty;
          return HoraButton(
            onPressed:
                isEmpty ? null : () => Navigator.pop(context, controller.text),
            child: Text(tr('report_bottom_sheet_button_done')),
          );
        },
      ),
    ).then((result) {
      if (result is String && !cubit.isClosed) {
        cubit.setDescription(result);
      }
    });
  }

  _handleTag(BuildContext context) {
    final cubit = context.read<LaporanFormCubit>();
    final tag = cubit.state.tag;
    final users = cubit.state.users;
    if (users.isEmpty) return;

    final children = <ListTile>[
      ListTile(
        dense: true,
        visualDensity: VisualDensity.compact,
        title: Text(tr('tag_friends')),
      ),
      ...users.map((u) {
        final photo = u.photo;
        final selected = u.name == tag;
        return ListTile(
          contentPadding: EdgeInsets.zero,
          selected: selected,
          leading: photo == null
              ? const CircleAvatar()
              : CircleAvatar(
            backgroundImage: NetworkImage(changeUrlImage(photo)),
          ),
          minLeadingWidth: 0,
          visualDensity: VisualDensity.compact,
          title: Text(
            u.name ?? 'Name',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          trailing: selected ? const Icon(Icons.check) : null,
          onTap: () {
            Navigator.pop(context, u);
          },
        );
      }),
    ];

    showHoraCustomListBottomSheet(context, children: children).then((user) {
      if (user is Profile && !cubit.isClosed) {
        cubit.setTag(user.name ?? '');
      }
    });
  }

  _handleInputLocation(BuildContext context) {}
}
