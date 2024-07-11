import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'button_styles.dart';

class SecondaryButton extends StatelessWidget {
  final bool isDisabled;
  final AllButtonStyles style;
  final VoidCallback? onPressed;
  final double? padding;

  const SecondaryButton({
    Key? key,
    required this.isDisabled,
    required this.style,
    this.onPressed,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (style is IconOnlyStyle) {
      content = Image.asset(
        (style as IconOnlyStyle).iconImagePath,
        width: 24,
        height: 24,
        color: Colors.white,
      );
    } else if (style is LeadingIconStyle) {
      content = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            (style as LeadingIconStyle).leadingIconImagePath,
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 8),
          Text(
            (style as LeadingIconStyle).text,
            style: AppTheme.headline400.copyWith(color: AppTheme.neutral500),
          ),
        ],
      );
    } else if (style is TrailingIconStyle) {
      content = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            (style as TrailingIconStyle).text,
            style: AppTheme.headline300.copyWith(color: Colors.white),
          ),
          const SizedBox(width: 8),
          Image.asset(
            (style as TrailingIconStyle).trailingIconImagePath,
            width: 24,
            height: 24,
            color: Colors.white,
          ),
        ],
      );
    } else if (style is LabelButtonStyle) {
      content = Text(
        (style as LabelButtonStyle).text,
        textAlign: TextAlign.center,
        style: AppTheme.headline400
            .copyWith(color: AppTheme.neutral500, fontWeight: FontWeight.w600),
      );
    } else {
      throw ArgumentError('Invalid ButtonStyle');
    }

    return IntrinsicWidth(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.neutral0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            padding:
                EdgeInsets.symmetric(vertical: 16, horizontal: padding ?? 30),
            elevation: 1),
        child: content,
      ),
    );
  }
}
