
import 'package:flutter/material.dart';
import 'package:yolanda/styles/app_colors.dart';

class Custom_Button_V2 extends StatelessWidget {
  final String actionText;
  final Color? color;
  final Color? fillColor;
  final Color outLineColor;
  final bool isOutline;
  final bool disabled;
  final Color disabledColor;
  final double? width;
  final double? height;
  final TextStyle? style;
  final double radius;
  final bool hasShadow;
  final bool hasGradient;
  final bool hasImage;
  final Function? onTap;
  final double left;
  final double right;
  final double bottom;
  final double elevation;
  final double top;
  final double padding;
  final double borderlineWidth;
  final String rightImage;
  final String leftImage;
  final bool imageIsLeft;
  final Color? overlayColor;
  final Color? shadowColor;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const Custom_Button_V2({
    Key? key,
    required this.actionText,
    this.color = Colors.white,
    this.fillColor,
    this.outLineColor = AppColors.black, //const Color(0xFFB99745),
    this.isOutline = false,
    this.disabled = false,
    this.disabledColor = const Color(0xFF959490),
    this.width,
    this.height,
    this.style,
    this.radius = 10,
    this.hasShadow = false,
    this.hasGradient = false,
    this.hasImage = false,
    this.left = 30,
    this.right = 30,
    this.bottom = 30,
    this.top = 30,
    required this.onTap,
    this.rightImage = "assets/images/dashboard/forward_arrow.png",
    this.leftImage = "assets/images/dashboard/forward_arrow.png",
    this.imageIsLeft = true,
    this.overlayColor = AppColors.black, //const Color(0xFFB99745),
    this.shadowColor = AppColors.black, //const Color(0xFFB99745),
    this.backgroundColor = const Color(0xFF2FCA6D),
    this.foregroundColor = Colors.white,
    this.elevation = 15,
    this.padding = 20,
    this.borderlineWidth = 0.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key, //const Key('customButton'),
      height: height,
      width: width,
      margin:
          EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
      child: ElevatedButton(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
            TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.none,
                // fontFamily: 'Inter',
                color: color
            ),
          ),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          foregroundColor: MaterialStateProperty.all(foregroundColor),
          overlayColor: MaterialStateProperty.all(overlayColor),
          shadowColor: MaterialStateProperty.all(shadowColor),
          elevation: MaterialStateProperty.all(elevation),
          padding: MaterialStateProperty.all(EdgeInsets.all(padding)),
          minimumSize: MaterialStateProperty.all(const Size(150, 50)),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          animationDuration: const Duration(milliseconds: 100),
          enableFeedback: true,
          splashFactory: NoSplash.splashFactory,
          side: MaterialStateProperty.all(
            BorderSide(
              color: isOutline ? outLineColor : Colors.transparent,
              width: borderlineWidth,
            ),
          ),
          // overlayColor: MaterialStateProperty.resolveWith<Color?>(
          //       (Set<MaterialState> states) {
          //       if (states.contains(MaterialState.pressed)) {
          //         return Colors.redAccent; //<-- SEE HERE
          //       }
          //       return null; // Defer to the widget's default.
          //   },
          // ),
        ),
        onPressed: () {
          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> new WelcomeScreen()));
          // Navigator.of(context).push(MaterialPageRoute(builder: (_) => LoginScreen()));
          onTap!();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            hasImage
                ? imageIsLeft
                    ? Image.asset(
                        leftImage,
                        color: const Color(0xFF000000),
                        height: 24,
                        width: 24,
                      )
                    : Container()
                : Container(),
            const SizedBox(
              width: 8,
            ),
            Center(
              child: Text(
                actionText,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none,
                    // fontFamily: 'Inter',
                    color: color
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            hasImage
                ? imageIsLeft
                    ? Container()
                    : Image.asset(
                        rightImage,
                        // color: foregroundColor,
                        height: 24,
                        width: 24,
                      )
                : Container(),
          ],
        ),
      ),
    );
  }
}
