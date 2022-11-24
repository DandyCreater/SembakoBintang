import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DialogHelper {
  loadingDialog(BuildContext context, double height, double width) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => SizedBox(
            height: height,
            width: width,
            child: Center(child: Lottie.asset('assets/lottie/loading.json'))));
  }
}
