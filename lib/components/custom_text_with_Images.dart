import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextWithImages extends StatelessWidget {
  const CustomTextWithImages({super.key,
    required this.imageRightColor,
    required this.imageLeftColor,
    required this.imageLeft,
    required this.imageRight,
    required this.textChild,
    this.hasNoImages = false,
    this.imageIsRight = true,
    this.right = 5,
    this.left = 5,
    this.top = 5,
    this.bottom = 5,
    this.width = 40,
    this.height = 40,
  });

  final Color imageRightColor;
  final Color imageLeftColor;
  final String imageLeft;
  final String imageRight;
  final Widget textChild;
  final bool? hasNoImages;
  final bool? imageIsRight;
  final double? right;
  final double? left;
  final double? top;
  final double? bottom;
  final double? width;
  final double? height;



  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: left!, right: right!, top: top!, bottom: bottom!),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          imageIsRight! ?
          const SizedBox.shrink():
          hasNoImages! ?
          const SizedBox.shrink():
          SizedBox(
            width: width,
            height: height,
            child: SvgPicture.asset(
              imageLeft,
              color: imageLeftColor,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: textChild
          ),
          const SizedBox(
            width: 10,
          ),
          imageIsRight! ?
          hasNoImages! ?
          const SizedBox.shrink():
          SizedBox(
            width: width,
            height: height,
            child: SvgPicture.asset(
              imageRight,
              color: imageRightColor,
            ),
          ):
          const SizedBox.shrink(),

        ],
      ),
    );
  }
}
