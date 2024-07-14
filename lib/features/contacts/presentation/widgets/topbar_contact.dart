import 'package:flutter/material.dart';

import '../../../../core/common/theme/app_theme.dart';
import '../../../list_profiles/domain/entities/profile.dart';
import 'top_icon.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
    required this.profile,
  });

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(8),
          ),
          gradient: LinearGradient(
              colors: [AppTheme.saropa900, AppTheme.saropa500],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 4, 4, 8),
        child: Column(
          children: [
            const TopIconRows(),
            CircleAvatar(
                radius: 60,
                backgroundColor: AppTheme.saropa100,
                foregroundImage: NetworkImage(
                  profile.imageUrl ??
                      'https://publicdomainvectors.org/tn_img/fb_stormshadow.webp',
                ),
                backgroundImage: const NetworkImage(
                  'https://publicdomainvectors.org/tn_img/fb_stormshadow.webp',
                ),
                onBackgroundImageError: (_, __) {}),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
              child: RichText(
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                text: TextSpan(
                  style: AppTheme.headline300.copyWith(color: Colors.black),
                  children: [
                    TextSpan(
                      text: profile.name,
                      style: AppTheme.headline500
                          .copyWith(height: 1.2, color: Colors.white),
                    ),
                    profile.age != null
                        ? TextSpan(
                            text: '\n${profile.age} Yrs Old',
                            style: AppTheme.body200.copyWith(
                                height: 1.5, color: AppTheme.neutral300),
                          )
                        : TextSpan(
                            text: '',
                            style: AppTheme.body200,
                          ),
                    profile.affiliations.isNotEmpty
                        ? TextSpan(
                            text: '\n${profile.affiliations.join(' ')}',
                            style: AppTheme.body200.copyWith(
                                height: 1.5, color: AppTheme.neutral300),
                          )
                        : TextSpan(
                            text: '',
                            style: AppTheme.body200.copyWith(
                                height: 1.5, color: AppTheme.neutral300),
                          ),
                    TextSpan(
                      text: '\n${profile.occupations}',
                      style: AppTheme.body200
                          .copyWith(height: 1.5, color: AppTheme.neutral300),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
