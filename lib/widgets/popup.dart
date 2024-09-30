library coustom_flutter_widgets;

import 'package:flutter/material.dart';

class CoustomPopupWindow {
  final String? title;
  final Widget? content;
  final Color? bgColor;
  final double? borderRadius;
  final String? buttonText;
  final TextStyle? buttonTextStyle;
  final List<Widget>? actionButtons;

  CoustomPopupWindow({
    this.title,
    this.content,
    this.bgColor,
    this.borderRadius,
    this.buttonText,
    this.buttonTextStyle,
    this.actionButtons,
  });

  void showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
          ),
          backgroundColor: bgColor ?? Colors.white,
          title: Text(
            title ?? "",
          ),
          content: content ?? const Text('Click "Close" button to back'),
          actions: actionButtons ??
              [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    buttonText ?? "Close",
                    style: buttonTextStyle,
                  ),
                ),
              ],
        );
      },
    );
  }
}

/* 

==================================================================

CoustomPopupWindow( // Pass named parameters).showPopup(context);

==================================================================

*/
