import 'package:flutter/material.dart';

import '../../../../core/common/widgets/shimmers/shimmer_container_rounded.dart';

class HomePageShimmer extends StatelessWidget {
  const HomePageShimmer({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 32, 0, 32),
              child: Column(
                children: [
                  ShimmerContainerRounded(
                    height: 50,
                    width: size.width * 0.9,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ShimmerContainerRounded(
                    height: 50,
                    width: size.width * 0.9,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ShimmerContainerRounded(
                    height: 50,
                    width: size.width * 0.9,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ShimmerContainerRounded(
                    height: 50,
                    width: size.width * 0.9,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ShimmerContainerRounded(
                    height: 50,
                    width: size.width * 0.9,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
