
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:yolanda/components/image_widgets.dart';
import 'package:yolanda/constants/constants.dart';
import 'package:yolanda/constants/svgs.dart';
import 'package:yolanda/styles/app_colors.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final double padding;
  final double? strokeWidth;
  const CustomLoadingIndicator(
      {Key? key, this.strokeWidth, this.padding = ySpaceMid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: CircularProgressIndicator(strokeWidth: strokeWidth ?? 4.0),
    ));
  }
}

class CustomLogoLoadingIndicator extends StatelessWidget {
  final EdgeInsets? padding;
  final String? text;
  final bool showText;
  final double? height;
  const CustomLogoLoadingIndicator(
      {Key? key, this.padding, this.showText = false, this.text, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(vertical: ySpaceMid),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpinKitPumpingHeart(
              itemBuilder: (context, index) => SvgImage(
                asset: logo,
                height: height ?? 100,
              ),
            ),
            if (showText) ...[
              const Gap(ySpaceMid + 2),
              Text(
                text ?? "Loading Data ...",
                style: Theme.of(context)
                    .primaryTextTheme
                    .headlineSmall
                    ?.copyWith(color: AppColors.steelGray),
              )
            ]
          ],
        ),
      ),
    );
  }
}
