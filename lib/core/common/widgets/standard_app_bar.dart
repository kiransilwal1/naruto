import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'buttons/button_styles.dart';
import 'buttons/minimal_buttons.dart';

// ignore: must_be_immutable
class StandardAppBar extends StatelessWidget {
  StandardAppBar({
    super.key,
    this.action,
    required this.title,
    required this.onBack,
  });
  final String title;
  final Function() onBack;
  Widget? action;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      leading: MinimalButton(
        isDisabled: false,
        style: const IconOnlyStyle(iconImagePath: 'assets/icons/back.png'),
        onPressed: onBack,
      ),
      actions: action == null ? [] : [action!],
      title: Text(
        textAlign: TextAlign.center,
        title,
        style: AppTheme.headline400.copyWith(color: AppTheme.neutral500),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
