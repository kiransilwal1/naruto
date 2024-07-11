abstract class AllButtonStyles {
  const AllButtonStyles();
}

class LabelButtonStyle extends AllButtonStyles {
  final String text;
  const LabelButtonStyle({required this.text});
}

class LeadingIconStyle extends AllButtonStyles {
  final String text;
  final String leadingIconImagePath;
  const LeadingIconStyle(
      {required this.text, required this.leadingIconImagePath});
}

class TrailingIconStyle extends AllButtonStyles {
  final String text;
  final String trailingIconImagePath;
  const TrailingIconStyle(
      {required this.text, required this.trailingIconImagePath});
}

class IconOnlyStyle extends AllButtonStyles {
  final String iconImagePath;
  const IconOnlyStyle({required this.iconImagePath});
}
