import 'package:flutter/material.dart';
import 'package:projectmanager/src/theme/theme_helper.dart';
import 'package:projectmanager/src/utils/size_utils.dart';

class AppbarTitle extends StatelessWidget {
  const AppbarTitle({super.key, required this.text, this.onTap, this.margin});

  final String text;

  final Function? onTap;

  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: GestureDetector(
        onTap: () {
          onTap?.call();
        },
        child: Text(
          text,
          style: theme.textTheme.titleLarge!.copyWith(
            color: appTheme.nearBlack,
            fontSize: 20.fSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
