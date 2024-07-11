import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
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
      appBar: AppBar(
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
                    return RichText(
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        style:
                            AppTheme.headline300.copyWith(color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Ninjas',
                            style: AppTheme.headline600
                                .copyWith(height: 1.2, color: Colors.white),
                          ),
                          TextSpan(
                            text: ' (${state.profiles.length})',
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
          )),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 32, 0, 32),
                child: Image.asset(
                  'assets/home-image.png',
                  height: size.height * 0.4,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Filter',
                  labelStyle: AppTheme.body100,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              BlocConsumer<ListProfilesBloc, ListProfilesState>(
                listener: (context, state) {
                  if (state is ListProfilesFailure) {
                    showErrorPopup(context, state.message, 'BACK');
                  }
                },
                builder: (context, state) {
                  if (state is ListProfilesSuccess) {
                    return Card(
                      child: ExpansionTile(
                        title: const Text('Ninjas'),
                        children: [
                          SizedBox(
                              height: 500,
                              child: ProfileGrids(
                                  size: size, profiles: state.profiles)),
                        ],
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileGrids extends StatelessWidget {
  const ProfileGrids({
    super.key,
    required this.size,
    required this.profiles,
  });

  final Size size;
  final List<Profile> profiles;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 0, 16),
      child: Center(
        child: GridView.builder(
          itemCount: profiles.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: size.width ~/ 170,
              mainAxisExtent: 225,
              crossAxisSpacing: 0,
              mainAxisSpacing: 10),
          itemBuilder: (_, index) {
            return GestureDetector(
                onTap: () {}, child: UserProfile(profile: profiles[index]));
          },
        ),
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
            radius: 50,
            backgroundColor: AppTheme.saropa100,
            foregroundImage: NetworkImage(
              profile.imageUrl ??
                  'https://publicdomainvectors.org/tn_img/fb_stormshadow.webp',
            ),
            backgroundImage: const NetworkImage(
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
              profile.affiliations.isNotEmpty
                  ? TextSpan(
                      text: '\n${profile.affiliations.join(' ')}',
                      style: AppTheme.body100
                          .copyWith(height: 1.5, color: AppTheme.neutral400),
                    )
                  : TextSpan(
                      text: '',
                      style: AppTheme.body100
                          .copyWith(height: 1.5, color: AppTheme.neutral400),
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
