import 'package:flutter/material.dart';

import '../constants.dart';

class TaskSnackBar {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      buildSnackBar(
          {required BuildContext context, required String textDisplay}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      backgroundColor: kBackgroundLightColor,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      content: Text(textDisplay,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          )),
    ));
  }
}
