import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainerRounded extends StatelessWidget {
  const ShimmerContainerRounded({
    super.key,
    required this.height,
    required this.width,
  });
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 20,
          width: 60,
          color: Colors.grey,
        ),
      ),
    );
  }
}
