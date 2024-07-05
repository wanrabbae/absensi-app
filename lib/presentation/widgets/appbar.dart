import 'package:app/components/component_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Icon horaBackButtonIcon = Icon(Icons.arrow_back);

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

class HoraAppBar extends AppBar {
  HoraAppBar(
    BuildContext context, {
    super.key,
    super.title,
    super.actions,
    super.flexibleSpace,
    super.bottom,
    super.elevation,
    super.automaticallyImplyLeading,
    super.systemOverlayStyle,
    super.backgroundColor,
    super.titleSpacing,
    Color? backButtonColor,
    bool leadingCircleButton = false,
    super.actionsIconTheme,
  }) : super(
          leading: () {
            final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
            final bool canPop = parentRoute?.canPop ?? false;
            final bool useCloseButton = parentRoute is PageRoute<dynamic> &&
                parentRoute.fullscreenDialog;
            final ScaffoldState? scaffold = Scaffold.maybeOf(context);
            final bool hasEndDrawer = scaffold?.hasEndDrawer ?? false;

            if (automaticallyImplyLeading) {
              if ((!hasEndDrawer && canPop) ||
                  (parentRoute?.impliesAppBarDismissal ?? false)) {
                Widget child = useCloseButton
                    ? const CloseButton()
                    : HoraBackButton(color: backButtonColor);

                if (leadingCircleButton) {
                  child = Container(
                    margin: const EdgeInsets.only(left: 16),
                    decoration: kCircleButtonDecoration,
                    child: child,
                  );
                }

                return child;
              }
            }
            return null;
          }(),
        );

  factory HoraAppBar.transparent(
    BuildContext context, {
    Key? key,
    Widget? title,
    List<Widget>? actions,
    Widget? flexibleSpace,
    PreferredSizeWidget? bottom,
    double? elevation,
    bool automaticallyImplyLeading = true,
    SystemUiOverlayStyle? systemOverlayStyle,
    double? titleSpacing,
    Color? backButtonColor,
  }) {
    return HoraAppBar(
      context,
      key: key,
      title: title != null
          ? DefaultTextStyle.merge(
              child: title,
              style: const TextStyle(color: Colors.white),
            )
          : null,
      actions: actions,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      elevation: elevation,
      automaticallyImplyLeading: automaticallyImplyLeading,
      systemOverlayStyle: systemOverlayStyle,
      backgroundColor: Colors.transparent,
      titleSpacing: titleSpacing,
      backButtonColor: Colors.white,
      actionsIconTheme: Theme.of(context).iconTheme.copyWith(
            color: Colors.white,
          ),
    );
  }
}
