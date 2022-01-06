import 'package:flutter/material.dart';
import '../../../Core/chat_colors.dart';

class BuildSelectorButton extends StatelessWidget {
  final String? title;
  final GestureTapCallback? onPressed;
  final Color? buttonColor;
  final Color? textColor;

  const BuildSelectorButton({
    this.title,
    this.onPressed,
    this.buttonColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 70,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: ChatColors.disbleSendButton,
          primary: buttonColor,
        ),
        onPressed: onPressed,
        child: Text(
          title ?? '',
          style: TextStyle(
            color: textColor,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
