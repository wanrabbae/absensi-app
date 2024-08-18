import 'package:app/core/themes.dart';
import 'package:app/presentation/blocs/company/company_cubit.dart';
import 'package:app/presentation/widgets/buttons.dart';
import 'package:app/presentation/widgets/empty_view.dart';
import 'package:app/presentation/widgets/images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class StaffView extends StatefulWidget {
  const StaffView({super.key});

  @override
  State<StaffView> createState() => _StaffViewState();
}

class _StaffViewState extends State<StaffView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: BlocBuilder<CompanyCubit, CompanyState>(
        buildWhen: (previous, current) => previous.staff != current.staff,
        builder: (context, state) {
          if (state.staff.isEmpty) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 64),
              child: SimpleEmptyView(
                title: tr('company_tab_staff_not_found'),
                button: HoraButton(
                  onPressed: () {},
                  child: Text(tr('company_tab_staff_not_found_action_button')),
                ),
              ),
            );
          }

          return RefreshIndicator.adaptive(
            onRefresh: () => context.read<CompanyCubit>().getStaffList(),
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                final staff = state.staff[index];

                return Tooltip(
                  message: staff.name,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    child: FadeInImage.assetNetwork(
                      placeholder: kImagePlaceholderUrl,
                      image: staff.photo,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.network(kImagePlaceholderUrl);
                      },
                    ),
                  ),
                );
              },
              itemCount: state.staff.length,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: colorBluePrimary,
        foregroundColor: Colors.white,
        child: const Icon(Boxicons.bx_user_plus),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
