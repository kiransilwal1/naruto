import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'button_styles.dart';

// ignore: must_be_immutable
class MinimalButton extends StatelessWidget {
  final bool isDisabled;
  final AllButtonStyles style;
  final VoidCallback? onPressed;
  Color? color;

  MinimalButton({
    Key? key,
    this.color,
    required this.isDisabled,
    required this.style,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content;
    color = color ?? AppTheme.neutral500;
    if (style is IconOnlyStyle) {
      content = Image.asset(
        (style as IconOnlyStyle).iconImagePath,
        height: 24,
        color: AppTheme.neutral500,
      );
    } else if (style is LeadingIconStyle) {
      content = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            (style as LeadingIconStyle).leadingIconImagePath,
            width: 24,
            height: 24,
            color: AppTheme.neutral500,
          ),
          const SizedBox(width: 8),
          Text(
            (style as LeadingIconStyle).text,
            style: AppTheme.headline300.copyWith(color: AppTheme.neutral500),
          ),
        ],
      );
    } else if (style is TrailingIconStyle) {
      content = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            (style as TrailingIconStyle).text,
            style: AppTheme.headline300.copyWith(color: AppTheme.neutral500),
          ),
          const SizedBox(width: 8),
          Image.asset(
            (style as TrailingIconStyle).trailingIconImagePath,
            width: 24,
            height: 24,
            color: AppTheme.neutral500,
          ),
        ],
      );
    } else if (style is LabelButtonStyle) {
      content = Text(
        (style as LabelButtonStyle).text,
        style: AppTheme.headline600
            .copyWith(color: isDisabled ? Colors.grey : color),
      );
    } else {
      throw ArgumentError('Invalid ButtonStyle');
    }

    return TextButton(
      onPressed: onPressed,
      child: content,
    );
  }
}
