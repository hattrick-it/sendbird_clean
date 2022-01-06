import 'package:flutter/material.dart';
import '../../../Core/chat_colors.dart';
import '../../../Core/constants.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color appbarColor;
  const CommonAppbar({required this.title, required this.appbarColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.chevron_left,
          size: 30,
          color: ChatColors.blackColor,
        ),
      ),
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(color: ChatColors.blackColor),
      ),
      backgroundColor: appbarColor,
      elevation: 1,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Constants.HeaderHeight);
}
