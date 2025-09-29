
import 'package:flutter/material.dart';
import 'package:yolanda/components/image_widgets.dart';
import 'package:yolanda/constants/constants.dart';

class ColoredBackIcon extends StatelessWidget {
  final Color color;
  final double? height;
  final double? width;
  const ColoredBackIcon(
      {super.key,
      required this.icon,
      required this.color,
      this.height,
      this.width});

  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 30,
      width: width ?? 30,
      padding: const EdgeInsets.all(ySpaceMin + 2),
      // decoration:
      //     BoxDecoration(shape: BoxShape.circle, color: color.withOpacity(0.05)),
      child: SvgImage(
        asset: icon,
        color: color,
      ),
    );
  }
}
