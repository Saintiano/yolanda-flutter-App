import 'package:flutter/material.dart';

class Custom_Shape_Card extends StatelessWidget {
  const Custom_Shape_Card({super.key,
    this.child,
    required this.gradientColor1,
    required this.gradientColor2,
    required this.gradientColor3,
    required this.gradientColor4,
    required this.height,
    required this.width,
    required this.bottomLeftRadius,
    required this.bottomRightRadius,
    required this.topLeftRadius,
    required this.topRightRadius,
    required this.backgroundImageUrl,
    required this.backgroundImageOpacity,
    this.hasBackgroundImage = false,
    this.borderColor = Colors.blue,
    this.borderWidth = 2.0,
    this.leftMargin = 0,
    this.rightMargin = 0,
    this.hasBorderColor = true,
    this.hasBackGroundColor = true,
  });

  final Widget? child;
  final Color gradientColor1;
  final Color gradientColor2;
  final Color gradientColor3;
  final Color gradientColor4;
  final Color borderColor;
  final double borderWidth;
  final bool hasBorderColor;
  final bool hasBackGroundColor;

  final double height;
  final double width;
  final double bottomLeftRadius;
  final double bottomRightRadius;
  final double topLeftRadius;
  final double topRightRadius;
  final double leftMargin;
  final double rightMargin;

  final bool hasBackgroundImage;
  final String backgroundImageUrl;
  final double backgroundImageOpacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: leftMargin, right: rightMargin),
      height: height,
      width: width,
      decoration: hasBackgroundImage ?
      hasBorderColor ?
      BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(backgroundImageOpacity), BlendMode.dstATop),
            image: NetworkImage(backgroundImageUrl),
            fit: BoxFit.cover,
          ),
          gradient: hasBackGroundColor ?
          LinearGradient(
              colors: [
                gradientColor1,
                gradientColor2,
                gradientColor3,
                gradientColor4,
                //add more colors for gradient
              ],
              tileMode: TileMode.mirror,
              // begin: Alignment.bottomRight, //begin of the gradient color
              // end: Alignment.topRight,
              begin: Alignment.bottomRight,
              end: const FractionalOffset(0.2, 0.4),
              // begin: Alignment.topRight, //begin of the gradient color
              // end: Alignment.bottomRight, //end of the gradient color
              stops: [0.0, 0.2, 0.5, 0.8] //stops for individual color
            //set the stops number equal to numbers of color
          ): null,
          border: Border.all(
            color: borderColor, // Set the desired border color
            width: borderWidth, // Set the desired border width
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(bottomLeftRadius),
            bottomRight: Radius.circular(bottomRightRadius),
            topLeft: Radius.circular(topLeftRadius),
            topRight: Radius.circular(topRightRadius),
          )
      ):
      BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(backgroundImageOpacity), BlendMode.dstATop),
            image: NetworkImage(backgroundImageUrl),
            fit: BoxFit.cover,
          ),
          gradient: hasBackGroundColor ?
          LinearGradient(
              colors: [
                gradientColor1,
                gradientColor2,
                gradientColor3,
                gradientColor4,
                //add more colors for gradient
              ],
              tileMode: TileMode.mirror,
              // begin: Alignment.bottomRight, //begin of the gradient color
              // end: Alignment.topRight,
              begin: Alignment.bottomRight,
              end: const FractionalOffset(0.2, 0.4),
              // begin: Alignment.topRight, //begin of the gradient color
              // end: Alignment.bottomRight, //end of the gradient color
              stops: [0.0, 0.2, 0.5, 0.8] //stops for individual color
            //set the stops number equal to numbers of color
          ): null,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(bottomLeftRadius),
            bottomRight: Radius.circular(bottomRightRadius),
            topLeft: Radius.circular(topLeftRadius),
            topRight: Radius.circular(topRightRadius),
          )
      ) :
      hasBorderColor ?
      BoxDecoration(
          gradient: hasBackGroundColor ?
          LinearGradient(
              colors: [
                gradientColor1,
                gradientColor2,
                gradientColor3,
                gradientColor4,
                //add more colors for gradient
              ],
              tileMode: TileMode.mirror,
              // begin: Alignment.bottomRight, //begin of the gradient color
              // end: Alignment.topRight,
              begin: Alignment.bottomRight,
              end: const FractionalOffset(0.2, 0.4),
              // begin: Alignment.topRight, //begin of the gradient color
              // end: Alignment.bottomRight, //end of the gradient color
              stops: [0.0, 0.2, 0.5, 0.8] //stops for individual color
            //set the stops number equal to numbers of color
          ): null,
          border: Border.all(
            color: borderColor, // Set the desired border color
            width: borderWidth, // Set the desired border width
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(bottomLeftRadius),
            bottomRight: Radius.circular(bottomRightRadius),
            topLeft: Radius.circular(topLeftRadius),
            topRight: Radius.circular(topRightRadius),
          )
      ):
      BoxDecoration(
          gradient: hasBackGroundColor ?
          LinearGradient(
              colors: [
                gradientColor1,
                gradientColor2,
                gradientColor3,
                gradientColor4,
                //add more colors for gradient
              ],
              tileMode: TileMode.mirror,
              // begin: Alignment.bottomRight, //begin of the gradient color
              // end: Alignment.topRight,
              begin: Alignment.bottomRight,
              end: const FractionalOffset(0.2, 0.4),
              // begin: Alignment.topRight, //begin of the gradient color
              // end: Alignment.bottomRight, //end of the gradient color
              stops: [0.0, 0.2, 0.5, 0.8] //stops for individual color
            //set the stops number equal to numbers of color
          ): null,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(bottomLeftRadius),
            bottomRight: Radius.circular(bottomRightRadius),
            topLeft: Radius.circular(topLeftRadius),
            topRight: Radius.circular(topRightRadius),
          )
      ),
      child: child!,
    );
  }
}
