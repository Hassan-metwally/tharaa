// import 'package:flutter/material.dart';
// import 'package:thoad/core/core.dart';

// class AppTextButton extends StatelessWidget {
//   final Color? buttonColor;
//   final String text;
//   final Color? textColor;
//   final TextStyle? textStyle;
//   final void Function()? onPressed;

//   final EdgeInsetsGeometry? padding;
//   final bool isLoading;
//   final bool isEnabled;

//   const AppTextButton({
//     super.key,
//     this.isLoading = false,
//     this.buttonColor,
//     required this.text,
//     this.textStyle,
//     this.onPressed,
//     this.textColor,
//     this.isEnabled = true,
//     this.padding,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final bool isDisabled =
//         isLoading || onPressed == null || isEnabled == false;
//     final textStateColor =
//         isDisabled ? textColor ?? AppColors.mainColor : AppColors.mainColor;
//     return Padding(
//       padding: padding ?? EdgeInsets.zero,
//       child: GestureDetector(
//         onTap: isEnabled && !isLoading ? onPressed : null,
//         behavior: HitTestBehavior.opaque,
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               text,
//               style: textStyle ??
//                   TextStyles.bold14(color: textStateColor)
//                       .copyWith(fontFamily: AppFonts.zain),
//               textAlign: TextAlign.center,
//               maxLines: 1,
//             ),
//             if (isLoading)
//               _LoadingWidth(
//                 color: textStateColor,
//               )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _LoadingWidth extends StatelessWidget {
//   const _LoadingWidth({required this.color});

//   final Color color;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 15,
//       width: 15,
//       margin: const EdgeInsets.symmetric(horizontal: 12),
//       child: CircularProgressIndicator(
//         color: color,
//         strokeWidth: 3,
//       ),
//     );
//   }
// }
