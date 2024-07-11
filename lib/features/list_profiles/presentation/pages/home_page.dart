import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naruto/core/common/theme/app_theme.dart';

import '../../../../core/common/widgets/alert.dart';
import '../../domain/entities/profile.dart';
import '../bloc/list_profiles_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    context.read<ListProfilesBloc>().add(ListProfileInitiated());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<ListProfilesBloc, ListProfilesState>(
        listener: (context, state) {
          if (state is ListProfilesFailure) {
            showErrorPopup(context, state.message, 'BACK');
          }
        },
        builder: (context, state) {
          if (state is ListProfilesSuccess) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
              child: Center(
                child: GridView.builder(
                  itemCount: state.profiles.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: size.width ~/ 170,
                      mainAxisExtent: 225,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 50),
                  itemBuilder: (_, index) {
                    return GestureDetector(
                        onTap: () {},
                        child: UserProfile(profile: state.profiles[index]));
                  },
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class UserProfile extends StatelessWidget {
  const UserProfile({super.key, required this.profile});
  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
            radius: 80,
            backgroundImage: NetworkImage(
              profile.imageUrl ??
                  'https://publicdomainvectors.org/tn_img/fb_stormshadow.webp',
            ),
            onBackgroundImageError: (_, __) {}),
        RichText(
          textAlign: TextAlign.center,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            style: AppTheme.headline300.copyWith(color: Colors.black),
            children: [
              TextSpan(
                text: profile.name,
                style: AppTheme.headline300.copyWith(height: 1.2),
              ),
              profile.age != null
                  ? TextSpan(
                      text: '\n${profile.age} Yrs Old',
                      style: AppTheme.body100
                          .copyWith(height: 1.5, color: AppTheme.neutral400),
                    )
                  : TextSpan(
                      text: '',
                      style: AppTheme.body100,
                    ),
              TextSpan(
                text: '\n${profile.occupations}',
                style: AppTheme.body100
                    .copyWith(height: 1.5, color: AppTheme.neutral400),
              ),
            ],
          ),
        )
      ],
    );
  }
}
