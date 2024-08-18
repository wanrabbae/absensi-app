import 'package:app/helpers/constant.dart';
import 'package:app/presentation/blocs/app/app_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class CompanyAppBar extends StatelessWidget {
  const CompanyAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (previous, current) => previous.company != current.company,
      builder: (context, state) {
        final company = state.company;
        return SliverLayoutBuilder(
          builder: (context, constraints) {
            final scrolled = constraints.scrollOffset < 110;
            final avatar = Container(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              constraints: BoxConstraints(
                maxWidth: scrolled ? 96 : 40,
                maxHeight: scrolled ? 96 : 40,
              ),
              clipBehavior: Clip.hardEdge,
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/icons/logo/hora.png',
                image: company.logo,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/icons/logo/hora.png');
                },
              ),
            );
            final title = Text(
              company.name,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            );

            return SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              backgroundColor: Colors.white,
              forceMaterialTransparency: true,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 1,
                titlePadding: scrolled
                    ? const EdgeInsets.only(bottom: 16)
                    : const EdgeInsetsDirectional.only(
                        start: 56,
                        bottom: 8,
                      ),
                title: scrolled
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Flexible(child: avatar),
                          const SizedBox(height: 8),
                          title,
                        ],
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          avatar,
                          const SizedBox(width: 8),
                          title,
                        ],
                      ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Boxicons.bx_bell),
                ),
                PopupMenuButton(
                  itemBuilder: (context) {
                    return [];
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class CompanyTabBar extends StatelessWidget {
  const CompanyTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: _SliverAppBarDelegate(
        TabBar(
          labelColor: Colors.black,
          labelStyle: const TextStyle(
            fontFamily: kGlobalFontFamily,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          unselectedLabelColor: Colors.grey,
          unselectedLabelStyle: const TextStyle(
            fontFamily: kGlobalFontFamily,
            fontSize: 16,
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            Tab(text: tr('company_tab_pocket')),
            Tab(text: tr('company_tab_staff')),
            Tab(text: tr('company_tab_statistic')),
          ],
        ),
      ),
      pinned: true,
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _tabBar;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
