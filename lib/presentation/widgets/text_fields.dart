import 'package:app/core/themes.dart';
import 'package:flutter/material.dart';

class HoraTextFieldViewer extends StatelessWidget {
  HoraTextFieldViewer({
    super.key,
    required this.label,
    required String value,
    required this.leading,
  }) : controller = TextEditingController(text: value);

  final String label;
  final TextEditingController controller;
  final IconData leading;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            prefix: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Icon(leading),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: colorBottomSheetDrag),
            ),
          ),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          maxLines: null,
        ),
      ],
    );
  }
}
