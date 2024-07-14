import 'package:flutter/material.dart';

import '../../../../core/common/theme/app_theme.dart';
import '../../domain/entities/profile.dart';
import 'profile_grid.dart';

class ExpandableView extends StatelessWidget {
  const ExpandableView({
    super.key,
    required this.size,
    required this.profiles,
    required this.title,
  });

  final Size size;
  final List<Profile> profiles;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: RichText(
          textAlign: TextAlign.start,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            style: AppTheme.headline300.copyWith(color: Colors.black),
            children: [
              TextSpan(
                text: title,
                style: AppTheme.body300
                    .copyWith(height: 1.2, color: AppTheme.neutral500),
              ),
              TextSpan(
                text: ' (${profiles.length})',
                style: AppTheme.body200
                    .copyWith(height: 1.2, color: AppTheme.neutral400),
              ),
            ],
          ),
        ),
        children: [
          SizedBox(
              height: 500, child: ProfileGrids(size: size, profiles: profiles)),
        ],
      ),
    );
  }
}
