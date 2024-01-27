import 'package:app/components/component_modal.dart';
import 'package:app/core/enums.dart';
import 'package:flutter/material.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({
    super.key,
    required this.tab,
    required this.value,
    this.selected = false,
    required this.onChanged,
  });

  final String tab;
  final HomeTab value;
  final bool selected;
  final ValueChanged<HomeTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            selected ? colorBlueOpacity : Colors.white,
          ),
          padding: const MaterialStatePropertyAll(EdgeInsets.fromLTRB(10, 5, 10, 5)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              side: selected
                  ? BorderSide.none
                  : const BorderSide(color: colorBlueOpacity, width: 2),
            ),
          ),
        ),
        onPressed: () => onChanged(value),
        child: Text(
          tab,
          style: TextStyle(
            color: Colors.black,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
