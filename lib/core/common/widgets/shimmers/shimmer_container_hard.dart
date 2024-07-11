import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainerHardEdge extends StatelessWidget {
  const ShimmerContainerHardEdge({
    super.key,
    required this.height,
    required this.width,
  });
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        color: Colors.grey,
      ),
    );
  }
}
