import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme/app_theme.dart';
import 'button_styles.dart';

class PrimaryButton extends StatelessWidget {
  final bool isDisabled;
  final AllButtonStyles style;
  final VoidCallback? onPressed;
  final double? padding;

  const PrimaryButton({
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
        width: 20,
        height: 20,
        color: Colors.white,
      );
    } else if (style is LeadingIconStyle) {
      content = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset((style as LeadingIconStyle).leadingIconImagePath,
              width: 24,
              height: 24,
              colorFilter:
                  const ColorFilter.mode(AppTheme.neutral0, BlendMode.srcIn)),
          const SizedBox(width: 8),
          Text(
            (style as LeadingIconStyle).text,
            style: AppTheme.headline300.copyWith(color: Colors.white),
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
        style: AppTheme.headline300.copyWith(color: Colors.white),
      );
    } else {
      throw ArgumentError('Invalid ButtonStyle');
    }

    return IntrinsicWidth(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.neutral500,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          padding:
              EdgeInsets.symmetric(vertical: 16, horizontal: padding ?? 40),
        ),
        child: content,
      ),
    );
  }
}
