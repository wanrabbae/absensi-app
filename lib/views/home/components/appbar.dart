import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

const Icon horaBackButtonIcon = Icon(FeatherIcons.arrowLeft);

class HoraAppBar extends AppBar {
  HoraAppBar(
    BuildContext context, {
    super.key,
    Widget? leading,
    super.title,
    super.actions,
    super.flexibleSpace,
    super.bottom,
    super.elevation,
    super.automaticallyImplyLeading,
    super.systemOverlayStyle,
    super.backgroundColor,
    super.titleSpacing = 8,
    Color? backButtonColor,
    super.actionsIconTheme,
  }) : super(
          centerTitle: false,
          leading: leading ?? () {
            final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
            final bool canPop = parentRoute?.canPop ?? false;
            final bool useCloseButton = parentRoute is PageRoute<dynamic> &&
                parentRoute.fullscreenDialog;
            final ScaffoldState? scaffold = Scaffold.maybeOf(context);
            final bool hasEndDrawer = scaffold?.hasEndDrawer ?? false;

            if (automaticallyImplyLeading) {
              if ((!hasEndDrawer && canPop) ||
                  (parentRoute?.impliesAppBarDismissal ?? false)) {
                return useCloseButton
                    ? const CloseButton()
                    : HoraBackButton(color: backButtonColor);
              }
            }
            return null;
          }(),
        );

  factory HoraAppBar.white(
    BuildContext context, {
    Key? key,
    Widget? title,
    List<Widget>? actions,
    Widget? flexibleSpace,
    PreferredSizeWidget? bottom,
    double? elevation,
    bool automaticallyImplyLeading = true,
    SystemUiOverlayStyle? systemOverlayStyle,
    Color? backgroundColor,
    double? titleSpacing,
    Color? backButtonColor,
  }) {
    return HoraAppBar(
      context,
      key: key,
      title: title != null
          ? DefaultTextStyle.merge(
              child: title,
              style: const TextStyle(color: Colors.black87),
            )
          : null,
      actions: actions,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      elevation: elevation,
      automaticallyImplyLeading: automaticallyImplyLeading,
      systemOverlayStyle: systemOverlayStyle,
      backgroundColor: Colors.white,
      titleSpacing: titleSpacing,
      backButtonColor: Colors.black87,
      actionsIconTheme: Theme.of(context).iconTheme.copyWith(
            color: Colors.black87,
          ),
    );
  }
}

class HoraBackButton extends StatelessWidget {
  const HoraBackButton({Key? key, this.color, this.onPressed})
      : super(key: key);

  final Color? color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: horaBackButtonIcon,
      color: color,
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        } else {
          Navigator.maybePop(context);
        }
      },
    );
  }
}
