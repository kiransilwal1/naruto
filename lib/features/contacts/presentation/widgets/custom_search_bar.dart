import 'package:flutter/material.dart';

import '../../../../core/common/theme/app_theme.dart';
import 'filter_cards.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.filters,
  });

  final List filters;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      child: Container(
        decoration: const BoxDecoration(
          color: AppTheme.saropa900,
          gradient: LinearGradient(
            colors: [AppTheme.saropa900, AppTheme.saropa500],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        height: 200,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 8,
                            ),
                            CircleAvatar(
                                radius: 20,
                                backgroundColor: AppTheme.saropa100,
                                backgroundImage: const NetworkImage(
                                  'https://publicdomainvectors.org/tn_img/fb_stormshadow.webp',
                                ),
                                onBackgroundImageError: (_, __) {}),
                            const SizedBox(
                              width: 8,
                            ),
                            const Icon(
                              Icons.search_rounded,
                              color: AppTheme.neutral400,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                    focusColor: Colors.white,
                                    border: InputBorder.none,
                                    labelText: 'Search',
                                    labelStyle: AppTheme.body300
                                        .copyWith(color: AppTheme.neutral400),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
                        child: Icon(
                          Icons.history,
                          color: AppTheme.neutral400,
                          size: 30,
                          weight: 2,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (Map items in filters)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Container(
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: AppTheme.neutral400,
                                  style: BorderStyle.solid,
                                  width: 2.0),
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(8),
                              ),
                            ),
                            child: FilterCards(
                              icon: items['icon'],
                              text: items['text'],
                            ),
                          ),
                        )
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
