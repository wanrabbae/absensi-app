import 'package:app/core/themes.dart';
import 'package:app/data/models/profile.dart';
import 'package:app/data/source/remote/api_service.dart';
import 'package:app/presentation/widgets/empty_view.dart';
import 'package:app/presentation/widgets/images.dart';
import 'package:app/presentation/widgets/loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HoraSearchDelegate extends SearchDelegate<Profile?> {
  HoraSearchDelegate(
    this.api, {
    required this.idPerusahaan,
    required String searchFieldLabel,
  }) : super(searchFieldLabel: searchFieldLabel);

  final ApiService api;
  final String idPerusahaan;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return BackButton(onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Profile>>(
      future: api.getKaryawanList(idPerusahaan: idPerusahaan),
      builder: (context, snapshot) {
        final data = snapshot.data;
        final error = snapshot.error;

        if (data != null) {
          final list = [...data].where((u) {
            if (query.isEmpty) return true;
            return (u.name ?? '').contains(query) ||
                (u.email ?? '').contains(query);
          }).toList(growable: false);

          return ListView.separated(
            itemBuilder: (context, index) {
              final user = list[index];
              final photo = user.photo;
              return ListTile(
                trailing: const Icon(Icons.check),
                leading: FadeInImage(
                  placeholder: kImagePlaceholder,
                  image:
                      photo != null ? NetworkImage(photo) : kImagePlaceholder,
                  imageErrorBuilder: (context, error, stackTrace) =>
                      kImagePlaceholderWidget,
                  fit: BoxFit.cover,
                ),
                onTap: () {
                  Navigator.pop(context, user);
                },
                title: Text(user.name ?? ''),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(height: 0, color: colorDivider);
            },
            itemCount: list.length,
          );
        }

        if (error != null) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 64),
            child: EmptyView(
              image: 'assets/icons/illustrations/agenda.webp',
              title: tr('menu_search'),
              subtitle: tr(error.toString()),
            ),
          );
        }

        return const Center(child: LoadingAnimation());
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
