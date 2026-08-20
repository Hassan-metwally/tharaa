import 'package:flutter/material.dart';

class SliverPersistentHeaderCustomDelegate extends SliverPersistentHeaderDelegate {
  final Widget widget;

  final double height;
  SliverPersistentHeaderCustomDelegate({required this.widget, this.height = 0});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      width: double.infinity,
      height: kToolbarHeight + height,
      child: Center(child: widget),
    );
  }

  @override
  double get maxExtent => kToolbarHeight + height;

  @override
  double get minExtent => kToolbarHeight + height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
