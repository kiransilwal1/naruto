import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCircularHorizontal extends StatelessWidget {
  const ShimmerCircularHorizontal({
    super.key,
    required this.height,
    required this.width,
    required this.count,
  });
  final double height;
  final double width;
  final int count;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = 0; i < count; i++)
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  height: height,
                  width: width,
                ),
              ),
            )
        ],
      ),
    );
  }
}
