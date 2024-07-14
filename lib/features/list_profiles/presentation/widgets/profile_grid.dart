import 'package:flutter/material.dart';

import '../../domain/entities/profile.dart';
import 'user_profile.dart';

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
