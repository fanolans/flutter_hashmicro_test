import 'package:flutter/material.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';

class LoadingOverlay {
  static show(BuildContext context) {
    return OverlayLoadingProgress.start(
      context,
      barrierDismissible: false,
      widget: CircularProgressIndicator(
        color: Theme.of(context).indicatorColor,
      ),
    );
  }

  static hide() {
    return OverlayLoadingProgress.stop();
  }
}
