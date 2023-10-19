import 'package:app/components/component_modal.dart';
import 'package:app/generated/assets.dart';
import 'package:app/models/user_model/user_model.dart';
import 'package:flutter/material.dart';

class CustomMarker extends StatefulWidget {
  final UserModel? userModel;
  const CustomMarker({
    super.key,
    this.userModel,
  });

  @override
  State<CustomMarker> createState() => _CustomMarkerState();
}

class _CustomMarkerState extends State<CustomMarker> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (widget.userModel?.fotoKaryawan == null)
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: colorGreenPrimary2,
                width: 2,
              ),
            ),
            child: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(
                Assets.logoHora,
              ),
            ),
          ),
        if (widget.userModel?.fotoKaryawan != null)
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: colorGreenPrimary2,
                width: 2,
              ),
            ),
            child: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                widget.userModel?.fotoUrl ?? '',
              ),
            ),
          ),
      ],
    );
  }
}
