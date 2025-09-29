
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yolanda/components/image_widgets.dart';
import 'package:yolanda/styles/app_colors.dart';
import 'package:yolanda/styles/app_gradient_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.actionText,
      this.style,
      this.padding,
      this.color,
      this.fillColor,
      this.radius,
      this.width,
      this.height,
      this.disabled = false,
      this.disabledColor,
      this.hasShadow = false,
      this.hasGradient = false,
      this.outLineColor,
      this.isOutline = false,
      this.hasTrailing = false,
      this.optionWidget,
      required this.onTap})
      : super(key: key);
  final String actionText;
  final Color? color;
  final Color? fillColor;
  final Color? outLineColor;
  final bool isOutline;
  final bool disabled;
  final Color? disabledColor;
  final double? width;
  final double? height;
  final TextStyle? style;
  final double? radius;
  final bool hasShadow;
  final bool hasGradient;
  final bool hasTrailing;
  final Function? onTap;
  final Widget? optionWidget;
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!disabled) {
          HapticFeedback.heavyImpact();
          onTap!();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        width: width ?? double.infinity,
        height: height ?? 56,
        padding: padding,
        decoration: BoxDecoration(
            color: disabled
                ? disabledColor ?? Theme.of(context).disabledColor
                : (isOutline
                    ? Colors.transparent
                    : fillColor ?? Theme.of(context).primaryColor),
            boxShadow: hasShadow
                ? [
                    BoxShadow(
                        blurRadius: 15,
                        spreadRadius: 0,
                        offset: const Offset(0, 15),
                        color: Theme.of(context)
                            .secondaryHeaderColor
                            .withOpacity(0.15))
                  ]
                : null,
            gradient: hasGradient ? AppGradients.buttonGradient : null,
            border: isOutline
                ? Border.all(
                    color: outLineColor ??
                        color ??
                        Theme.of(context).canvasColor.withOpacity(.9))
                : null,
            borderRadius: hasTrailing
                ? BorderRadius.only(
                    topLeft: Radius.circular(radius ?? 8),
                    bottomLeft: Radius.circular(radius ?? 8),
                  )
                : BorderRadius.circular(radius ?? 8)),
        alignment: Alignment.center,
        child: optionWidget ??
            Text(
              actionText,
              style: style ??
                  Theme.of(context).primaryTextTheme.headlineSmall?.copyWith(
                      color: isOutline
                          ? color ??
                              Theme.of(context).canvasColor.withOpacity(.9)
                          : AppColors.white,
                      // fontFamily: "Inter",
                      fontWeight: FontWeight.w700),
            ),
      ),
    );
  }
}

class IconBorderButton extends StatelessWidget {
  final String icon;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final Color borderColor;
  final bool showShadow;
  final double padding;
  final double borderRadius;
  final bool changeIconColor;
  final Widget? iconWidget;
  final bool showBorder;
  final bool enabled;
  const IconBorderButton(
      {Key? key,
      required this.icon,
      this.showShadow = false,
      this.enabled = true,
      this.changeIconColor = false,
      this.onTap,
      this.iconWidget,
      this.showBorder = true,
      this.width,
      this.height,
      this.padding = 14,
      this.borderRadius = 8,
      this.borderColor = AppColors.steelGray})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onTap : null,
      child: Container(
          height: height ?? 48,
          width: width ?? 48,
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow: showShadow
                  ? [
                      BoxShadow(
                          blurRadius: 25,
                          spreadRadius: 0,
                          color: borderColor.withOpacity(0.05),
                          offset: const Offset(0, 1))
                    ]
                  : null,
              border: showBorder
                  ? Border.all(color: borderColor.withOpacity(0.5), width: 0.5)
                  : null),
          alignment: Alignment.center,
          child: iconWidget ??
              SvgImage(
                asset: icon,
                color: changeIconColor ? borderColor : Theme.of(context).colorScheme.primary,
              )
      ),
    );
  }
}
