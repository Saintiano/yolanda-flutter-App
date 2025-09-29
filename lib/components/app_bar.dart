
import 'package:flutter/material.dart';
import 'package:yolanda/components/image_widgets.dart' show SvgImage;
import 'package:yolanda/constants/constants.dart';
import 'package:yolanda/constants/responsiveness.dart';
import 'package:yolanda/constants/svgs.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? height;
  final Color? color;
  final bool showBackButton;
  final Color? backgroundColor;

  //Should not be greater than 7
  final double? fontSize;
  final double? elevation;
  final String text;
  final Widget? trailingWidget;
  final Function()? onTap;
  const CustomAppBar({
    Key? key,
    required this.text,
    this.onTap,
    this.height,
    this.trailingWidget,
    this.backgroundColor,
    this.color,
    this.elevation = 0.5,
    this.fontSize,
    this.showBackButton = true,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height ?? 70);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: SizeConfig.xMargin(context, 100),
      color: backgroundColor ?? Theme.of(context).colorScheme.secondary,
      padding: const EdgeInsets.symmetric(
              horizontal: generalHorizontalPadding - 3, vertical: ySpaceMid) +
          const EdgeInsets.only(top: ySpace2),

      child: Row(children: [
        InkWell(
          onTap: onTap ?? () => Navigator.pop(context),
          child: SizedBox(
            height: 40,
            width: 40,
            child: SvgImage(
              asset: back_arrow,
              color: color ?? Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        const Spacer(),
        if (trailingWidget == null) const Spacer(),
        SizedBox(
          width: SizeConfig.xMargin(context, 36),
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.center,
            softWrap: true,
            style: Theme.of(context).primaryTextTheme.displaySmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
                fontSize: SizeConfig.textSize(context, fontSize ?? 4.1)),
          ),
        ),
        const Spacer(),
        trailingWidget ??
            const Spacer(
              flex: 2,
            ),
      ]),
    );
  }
}
