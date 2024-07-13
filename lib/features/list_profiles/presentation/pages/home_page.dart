import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naruto/core/common/theme/app_theme.dart';
import 'package:naruto/core/common/widgets/buttons/button_styles.dart';
import 'package:naruto/core/common/widgets/buttons/primary_buttons.dart';

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
                    List<Profile> profiles = state.profiles
                        .where((profile) => profile.affiliations.length > 1)
                        .toList();
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
              const Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text('Ninja Suggestions'),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Filter',
                    labelStyle: AppTheme.body100,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide:
                            const BorderSide(color: AppTheme.saropa200)),
                  ),
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
                    List<Profile> profiles = state.profiles
                        .where((profile) => profile.affiliations.length > 1)
                        .toList();
                    List<String> villages = [
                      'Kirigakure',
                      'Akatsuki',
                      'Konohagakure',
                      'Otogakure',
                      'Iwagakure',
                      'Kumogakure',
                      'Uzushiogakure',
                      'Sunagakure',
                      'Yugakure'
                    ];
                    Map<String, List<Profile>> villageNinjas = {};
                    for (String village in villages) {
                      villageNinjas[village] = profiles
                          .where((element) =>
                              element.affiliations.contains(village))
                          .toList();
                    }
                    return SizedBox(
                      height: 500,
                      child: ListView(
                        children: [
                          for (String key in villageNinjas.keys)
                            ExpandableView(
                                size: size,
                                profiles: villageNinjas[key]!,
                                title: key)
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
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Stack(
              children: <Widget>[
                // Background translucent overlay
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(); // Dismiss the popup
                  },
                  child: Container(
                    color: Colors.black.withOpacity(0.5), // Adjust opacity here
                  ),
                ),
                // Popup container
                Center(
                  child: Container(
                    height: size.height * 0.5,
                    width: size.width * 0.8,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 40,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(8),
                              ),
                              gradient: LinearGradient(
                                  colors: [
                                    AppTheme.saropa900,
                                    AppTheme.saropa500
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 4, 4, 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  'assets/kunai.svg',
                                  color: Colors.white,
                                  height: 20,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Add Ninjas',
                                  style: AppTheme.body300
                                      .copyWith(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CircleAvatar(
                            radius: 80,
                            backgroundColor: AppTheme.saropa100,
                            foregroundImage: NetworkImage(
                              profile.imageUrl ??
                                  'https://publicdomainvectors.org/tn_img/fb_stormshadow.webp',
                            ),
                            backgroundImage: const NetworkImage(
                              'https://publicdomainvectors.org/tn_img/fb_stormshadow.webp',
                            ),
                            onBackgroundImageError: (_, __) {}),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: size.width * 0.7,
                          child: RichText(
                            textAlign: TextAlign.center,
                            softWrap: true,
                            text: TextSpan(
                              style: AppTheme.headline300
                                  .copyWith(color: Colors.black),
                              children: [
                                TextSpan(
                                  text: profile.name,
                                  style: AppTheme.headline300
                                      .copyWith(height: 1.2),
                                ),
                                profile.age != null
                                    ? TextSpan(
                                        text: '\n${profile.age} Yrs Old',
                                        style: AppTheme.body100.copyWith(
                                            height: 1.5,
                                            color: AppTheme.neutral400),
                                      )
                                    : TextSpan(
                                        text: '',
                                        style: AppTheme.body100,
                                      ),
                                profile.affiliations.isNotEmpty
                                    ? TextSpan(
                                        text:
                                            '\n${profile.affiliations.join(' ')}',
                                        style: AppTheme.body100.copyWith(
                                            height: 1.5,
                                            color: AppTheme.neutral400),
                                      )
                                    : TextSpan(
                                        text: '',
                                        style: AppTheme.body100.copyWith(
                                            height: 1.5,
                                            color: AppTheme.neutral400),
                                      ),
                                TextSpan(
                                  text: '\n${profile.occupations}',
                                  style: AppTheme.body100.copyWith(
                                      height: 1.5, color: AppTheme.neutral400),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child: RichText(
                            textAlign: TextAlign.start,
                            softWrap: true,
                            text: TextSpan(
                              style: AppTheme.body100
                                  .copyWith(color: Colors.black),
                              children: [
                                TextSpan(
                                  text:
                                      'Would you like to add ${profile.name} to your contacts?',
                                  style: AppTheme.body10.copyWith(
                                      height: 1.2,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 40),
                                ),
                                child: Text(
                                  'Cancel',
                                  style: AppTheme.body200
                                      .copyWith(color: AppTheme.neutral500),
                                ),
                              ),
                              BlocBuilder<ListProfilesBloc, ListProfilesState>(
                                builder: (context, state) {
                                  if (state is ListProfilesSuccess) {
                                    return PrimaryButton(
                                        isDisabled: false,
                                        onPressed: () {
                                          context.read<ListProfilesBloc>().add(
                                              AddProfileEvent(
                                                  profile: profile,
                                                  profiles: state.profiles));
                                        },
                                        style: LeadingIconStyle(
                                            text:
                                                'Add ${profile.name.split(' ')[0]}',
                                            leadingIconImagePath:
                                                'assets/add-ninja.svg'));
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              )

                              // ElevatedButton(
                              //   onPressed: () {},
                              //   style: ElevatedButton.styleFrom(
                              //     backgroundColor: AppTheme.saropa900,
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(4),
                              //     ),
                              //     padding: const EdgeInsets.symmetric(
                              //         vertical: 20, horizontal: 20),
                              //   ),
                              //   child: Text(
                              //     'Add ${profile.name}',
                              //     style: AppTheme.body200
                              //         .copyWith(color: Colors.white),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Column(
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
      ),
    );
  }
}
