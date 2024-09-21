import 'package:app/data/models/agenda/agenda.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class AgendaTileView extends StatelessWidget {
  const AgendaTileView(this.agenda, {super.key});

  final Agenda agenda;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: agenda.status != 'Ongoing',
        onChanged: (value) {},
        visualDensity: VisualDensity.compact,
      ),
      title: Text(
        agenda.judul ?? agenda.keterangan,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: agenda.judul == null ? null : Text(agenda.keterangan),
      visualDensity: VisualDensity.compact,
      contentPadding: const EdgeInsets.fromLTRB(16, 0, 12, 0),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {},
            visualDensity: VisualDensity.compact,
            icon: const Icon(Boxicons.bx_pin),
          ),
          IconButton(
            onPressed: () {},
            visualDensity: VisualDensity.compact,
            icon: const Icon(Boxicons.bx_x),
          ),
        ],
      ),
    );
  }
}
