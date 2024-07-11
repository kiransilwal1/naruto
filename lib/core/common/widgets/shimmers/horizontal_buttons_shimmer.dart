import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerButtonHorizontal extends StatelessWidget {
  const ShimmerButtonHorizontal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = 0; i < 5; i++)
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey,
                  ),
                  height: 40,
                  width: 100,
                ),
              ),
            )
        ],
      ),
    );
  }
}
