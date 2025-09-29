import 'package:flutter/material.dart';
import 'package:yolanda/constants/constants.dart';

class DialogWidgets {

  static Future customBodyDialog(
      context, {
        Function? onTap,
        required bool noDismissIcon,
        bool isScrollControlled = true,
        required MaterialType transparency,
        required Widget child,

      }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      isDismissible: noDismissIcon,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(bottomSheetBorderRadius),
        ),
      ),
      builder: (builder) {
        return Material(
          type: transparency,
          // type: MaterialType.transparency,
          child: child,
        );
      },
    );
  }

}