import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'buttons/button_styles.dart';
import 'buttons/primary_buttons.dart';

void showErrorPopup(BuildContext context, String text, String buttonText,
    {String? title, Function()? onTap}) {
  onTap ??= () {
    Navigator.of(context).pop();
  };
  title ??= 'Error';
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Text(
              title!,
              style: AppTheme.headline500,
            ),
            content: Text(
              text,
              style: AppTheme.body400,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            actions: <Widget>[
              PrimaryButton(
                isDisabled: false,
                style: const LabelButtonStyle(text: 'BACK'),
                onPressed: onTap,
              )
            ],
          );
        },
      );
    },
  );
}
