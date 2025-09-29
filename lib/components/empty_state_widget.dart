
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:yolanda/constants/constants.dart';
import 'package:yolanda/constants/svgs.dart';

import 'image_widgets.dart';

class EmptyStateWidget extends StatelessWidget {
  final bool isError;
  final bool isException;
  final String message;
  final String? icon;
  final double messageSpacing;
  final Widget? messageWidget;
  const EmptyStateWidget(
      {super.key,
      this.icon,
      required this.message,
      this.messageWidget,
      this.isException = false,
      this.messageSpacing = ySpace1,
      this.isError = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isException
          ? const EdgeInsets.only(
              left: generalHorizontalPadding,
              right: generalHorizontalPadding,
              top: ySpace3 * 2)
          : const EdgeInsets.symmetric(
              horizontal: generalHorizontalPadding - ySpaceMin,
              vertical: ySpace3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgImage(
            color: Theme.of(context).colorScheme.primary,
            asset: icon ?? (isError ? warningIcon : logo),
            height: 50,
          ),
          Gap(messageSpacing),
          messageWidget ??
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .primaryTextTheme
                    .headlineSmall
                    ?.copyWith(color: Theme.of(context).colorScheme.primary),
              )
        ],
      ),
    );
  }
}
