import 'package:flutter/material.dart';

import '../../../../core/resources/color_manager.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final Widget trailing;
  final VoidCallback onTap;

  const SettingsItem({
    Key? key,
    required this.title,
    required this.trailing,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        iconColor: ColorManager.kMove,
        dense: true,
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        trailing: trailing,
      ),
    );
  }
}
