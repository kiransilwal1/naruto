import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/common/theme/app_theme.dart';
import '../../domain/entities/profile.dart';
import '../bloc/list_profiles_bloc.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: AppTheme.saropa600,
        elevation: 0,
        toolbarHeight: 80,
        title: Row(
          children: [
            SvgPicture.asset(
              'assets/kunai.svg',
              color: Colors.white,
              height: 30,
            ),
            const SizedBox(
              width: 16,
            ),
            BlocBuilder<ListProfilesBloc, ListProfilesState>(
              builder: (context, state) {
                if (state is ListProfilesSuccess) {
                  List<Profile> profiles = state.profiles
                      .where((profile) => profile.affiliations.length > 1)
                      .toList();
                  return RichText(
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: AppTheme.headline300.copyWith(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Ninjas',
                          style: AppTheme.headline600
                              .copyWith(height: 1.2, color: Colors.white),
                        ),
                        TextSpan(
                          text: ' (${profiles.length})',
                          style: AppTheme.body200.copyWith(
                              height: 1.2, color: AppTheme.neutral300),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Text(
                    'Ninjas',
                    style: AppTheme.headline800.copyWith(color: Colors.white),
                  );
                }
              },
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ));
  }
}
