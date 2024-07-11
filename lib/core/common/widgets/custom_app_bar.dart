import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 24, 30, 0),
      child: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0.0,
        titleSpacing: 0,
        title: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            'Discover',
            style: AppTheme.headline700.copyWith(color: AppTheme.neutral600),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
