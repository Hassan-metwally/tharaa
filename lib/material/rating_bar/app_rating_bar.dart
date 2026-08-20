import 'package:flutter/material.dart';

part "rating_bar.dart";

// ignore: must_be_immutable
class AppRatingBar extends StatelessWidget {
  const AppRatingBar({
    super.key,
    required this.onRatingUpdate,
    this.initialRating,
    this.ignoreGestures,
    this.itemSize,
    this.filledIconColor,
    this.emptyIconColor,
    this.itemPadding,
    this.useEmptyOutlineIcon = true,
    this.itemCount,
  });
  final void Function(double rate) onRatingUpdate;
  final double? initialRating;
  final bool? ignoreGestures;
  final bool useEmptyOutlineIcon;
  final double? itemSize;
  final Color? filledIconColor;
  final Color? emptyIconColor;
  final double? itemPadding;
  final int? itemCount;

  @override
  Widget build(BuildContext context) {
    return RatingBar(
      initialRating: initialRating ?? 0,
      ignoreGestures: ignoreGestures ?? false,
      itemCount: itemCount ?? 5,
      itemSize: itemSize ?? 40,
      glow: false,
      ratingWidget: _RatingBarIconTypes(
        full: Icon(Icons.star_rate_rounded, color: filledIconColor ?? const Color(0xffFF7B00)),
        empty: useEmptyOutlineIcon
            ? Icon(Icons.star_rate_rounded, color: emptyIconColor ?? const Color(0xffE6E6E6))
            : const Icon(Icons.star_rate_rounded),
        half: const Icon(Icons.star_half_rounded),
      ),
      // glowColor: AppColors.mainColor,
      textDirection: TextDirection.ltr,
      itemPadding: EdgeInsets.symmetric(horizontal: itemPadding ?? 1.0),
      onRatingUpdate: onRatingUpdate,
    );
  }
}
