import 'package:app/presentation/views/offfice/present/caller/caller_tile.dart';
import 'package:flutter/material.dart';

class CallerView extends StatefulWidget {
  const CallerView({super.key});

  @override
  State<CallerView> createState() => _CallerViewState();
}

class _CallerViewState extends State<CallerView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      children: const [
        CallerTile(name: 'PT. Sama Mikro Solusi', status: false),
        CallerTile(name: 'Bill', status: true),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
