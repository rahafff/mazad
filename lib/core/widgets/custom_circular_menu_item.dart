import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomCircularMenuItem extends StatelessWidget {
  /// if icon and animatedIcon are passed, icon will be ignored
  final String icon;
  final Color? color;
  final Color? iconColor;
  final VoidCallback onTap;
  final double iconSize;
  final double padding;
  final double margin;
  final List<BoxShadow>? boxShadow;
  final bool enableBadge;
  final double? badgeRightOffet;
  final double? badgeLeftOffet;
  final double? badgeTopOffet;
  final double? badgeBottomOffet;
  final double? badgeRadius;
  final TextStyle? badgeTextStyle;
  final String? badgeLabel;
  final Color? badgeTextColor;
  final Color? badgeColor;

  /// if animatedIcon and icon are passed, icon will be ignored
  final AnimatedIcon? animatedIcon;

  /// creates a menu item .
  /// [onTap] must not be null.
  /// [padding] and [margin]  must be equal or greater than zero.
  const CustomCircularMenuItem({
    Key? key,
    required this.onTap,
    required this.icon,
    this.color,
    this.iconSize = 30,
    this.boxShadow,
    this.iconColor,
    this.animatedIcon,
    this.padding = 10,
    this.margin = 10,
    this.enableBadge = false,
    this.badgeBottomOffet,
    this.badgeLeftOffet,
    this.badgeRightOffet,
    this.badgeTopOffet,
    this.badgeRadius,
    this.badgeTextStyle,
    this.badgeLabel,
    this.badgeTextColor,
    this.badgeColor,
  })  : assert(padding >= 0.0),
        assert(margin >= 0.0),
        super(key: key);

  Widget _buildCircularMenuItem(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: boxShadow ??
            [
              BoxShadow(
                color: color ?? Theme.of(context).primaryColor,
                blurRadius: 10,
              ),
            ],
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Material(
          color: color ?? Theme.of(context).primaryColor,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: animatedIcon ??
                  ImageIcon(
                    AssetImage(icon),
                    size: iconSize,
                    color: iconColor ?? Colors.white,
                  ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCircularMenuItemWithBadge(BuildContext context) {
    return _Badge(
      color: badgeColor,
      bottomOffset: badgeBottomOffet,
      rightOffset: badgeRightOffet,
      leftOffset: badgeLeftOffet,
      topOffset: badgeTopOffet,
      radius: badgeRadius,
      textStyle: badgeTextStyle,
      onTap: onTap,
      textColor: badgeTextColor,
      label: badgeLabel,
      child: _buildCircularMenuItem(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return enableBadge
        ? _buildCircularMenuItemWithBadge(context)
        : _buildCircularMenuItem(context);
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    Key? key,
    required this.child,
    required this.label,
    this.color,
    this.textColor,
    this.onTap,
    this.radius,
    this.bottomOffset,
    this.leftOffset,
    this.rightOffset,
    this.topOffset,
    this.textStyle,
  }) : super(key: key);

  final Widget child;
  final String? label;
  final Color? color;
  final Color? textColor;
  final Function? onTap;
  final double? rightOffset;
  final double? leftOffset;
  final double? topOffset;
  final double? bottomOffset;
  final double? radius;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          right: (leftOffset == null && rightOffset == null) ? 8 : rightOffset,
          top: (topOffset == null && bottomOffset == null) ? 8 : topOffset,
          left: leftOffset,
          bottom: bottomOffset,
          child: FittedBox(
            child: GestureDetector(
              onTap: onTap as void Function()? ?? () {},
              child: CircleAvatar(
                maxRadius: radius ?? 10,
                minRadius: radius ?? 10,
                backgroundColor: color ?? Theme.of(context).primaryColor,
                child: FittedBox(
                  child: Text(
                    label ?? '',
                    textAlign: TextAlign.center,
                    style: textStyle ??
                        TextStyle(
                            fontSize: 10,
                            color: textColor ??
                                Theme.of(context).colorScheme.secondary),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
