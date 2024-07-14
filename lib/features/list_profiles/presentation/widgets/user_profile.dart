import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/common/theme/app_theme.dart';
import '../../../../core/common/widgets/buttons/button_styles.dart';
import '../../../../core/common/widgets/buttons/primary_buttons.dart';
import '../../../contacts/presentation/pages/contact_list.dart';
import '../../domain/entities/profile.dart';
import '../bloc/list_profiles_bloc.dart';

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
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ContactList()),
                                          );
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
