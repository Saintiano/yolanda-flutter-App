
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:yolanda/components/loading_widgets.dart';

class LoadingOverlayWidget extends StatelessWidget {
  final Widget child;
  const LoadingOverlayWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
        useDefaultLoading: false,
        disableBackButton: true,
        closeOnBackButton: false,
        duration: const Duration(milliseconds: 250),
        reverseDuration: const Duration(milliseconds: 250),
        // overlayColor: AppColors.primary.withOpacity(0.8),
        overlayWidgetBuilder: (_) {
          return const CustomLogoLoadingIndicator();
        },
        child: child);
  }
}
