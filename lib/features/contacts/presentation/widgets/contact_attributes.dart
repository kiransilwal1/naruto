import 'package:flutter/material.dart';

import '../../../../core/common/theme/app_theme.dart';

class ContactAttributeCards extends StatelessWidget {
  const ContactAttributeCards({
    required this.title,
    required this.value,
    super.key,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.receipt),
        Text(
          title,
          style: AppTheme.headline300,
        ),
        Text(
          value,
          style: AppTheme.body100,
        ),
      ],
    );
  }
}
