import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'rating_star.dart';

class Reviews extends StatelessWidget {
  const Reviews({
    super.key,
    required this.name,
    required this.rating,
    required this.description,
    required this.imageUrl,
  });
  final String name;
  final int rating;
  final String description;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: AppTheme.neutral100,
          foregroundImage: NetworkImage(imageUrl),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: AppTheme.headline300,
                  ),
                  Text(
                    'Today',
                    style:
                        AppTheme.body100.copyWith(color: AppTheme.neutral300),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(1, 0, 1, 0),
                    child: CurvedStar(
                      size: 10.0,
                      rating: rating.toDouble(),
                      index: index + 1,
                    ),
                  );
                }),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                description,
                style: AppTheme.body100.copyWith(color: AppTheme.neutral500),
              )
            ],
          ),
        ),
      ],
    );
  }
}
