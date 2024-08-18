import 'package:app/data/models/profile.dart';
import 'package:app/presentation/widgets/images.dart';
import 'package:app/presentation/widgets/text_fields.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class StaffDetailScreen extends StatelessWidget {
  const StaffDetailScreen({super.key, required this.staff});

  final Profile staff;

  @override
  Widget build(BuildContext context) {
    final avatar = Container(
      decoration: const BoxDecoration(shape: BoxShape.circle),
      constraints: const BoxConstraints(
        maxWidth: 128,
        maxHeight: 128,
      ),
      clipBehavior: Clip.hardEdge,
      child: FadeInImage.assetNetwork(
        placeholder: 'assets/icons/logo/hora.png',
        image: staff.photo,
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.network(kImagePlaceholderUrl);
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: avatar),
            const SizedBox(height: 24),
            HoraTextFieldViewer(label: tr('name'), value: staff.name),
            const SizedBox(height: 16),
            HoraTextFieldViewer(label: tr('gender'), value: staff.gender ?? ''),
            const SizedBox(height: 16),
            HoraTextFieldViewer(label: tr('email'), value: staff.email),
            const SizedBox(height: 16),
            HoraTextFieldViewer(label: tr('address'), value: staff.address ?? ''),
          ],
        ),
      ),
    );
  }
}
