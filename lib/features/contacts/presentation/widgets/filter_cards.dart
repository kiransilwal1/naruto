import 'package:flutter/material.dart';

import '../../../../core/common/theme/app_theme.dart';

class FilterCards extends StatelessWidget {
  const FilterCards({
    super.key,
    required this.icon,
    required this.text,
  });
  final Icon icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        icon,
        Text(
          text,
          style: AppTheme.body300.copyWith(color: AppTheme.neutral400),
        )
      ]),
    );
  }
}
