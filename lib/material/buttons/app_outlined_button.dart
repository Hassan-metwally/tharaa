// import 'package:flutter/material.dart';
// import 'package:thoad/core/core.dart';
// import '../media/svg_icon.dart';

// class AppOutLineButton extends StatelessWidget {
//   final Color borderColor;
//   final Color? backgroundColor;
//   final Color? iconColor;
//   final double buttonRadius;
//   final String text;
//   final TextStyle? textStyle;
//   final VoidCallback? onPressed;
//   final String? icon;
//   final Color textColor;
//   final bool isLoading;
//   final bool isEnabled;
//   final bool isExpanded;
//   final double? elevation;

//   const AppOutLineButton({
//     super.key,
//     this.isLoading = false,
//     this.isEnabled = true,
//     this.borderColor = AppColors.red400,
//     this.iconColor,
//     this.buttonRadius = 50,
//     this.icon,
//     required this.text,
//     this.textStyle,
//     this.onPressed,
//     this.textColor = AppColors.red400,
//     this.elevation,
//     // this.disableColor,
//     this.isExpanded = true,
//     this.backgroundColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final bool isDisabled = isLoading || isEnabled == false;
//     final borderColor = isDisabled
//         ? AppColors.gray300
//         : (Theme.of(context)
//                     .outlinedButtonTheme
//                     .style
//                     ?.textStyle
//                     ?.resolve(WidgetState.values.toSet()))
//                 ?.color ??
//             this.borderColor;
//     final previewColor = isDisabled
//         ? AppColors.gray300
//         : (Theme.of(context)
//                     .outlinedButtonTheme
//                     .style
//                     ?.textStyle
//                     ?.resolve(WidgetState.values.toSet()))
//                 ?.color ??
//             textColor;
//     final textStyle = (this.textStyle ??
//             Theme.of(context)
//                 .outlinedButtonTheme
//                 .style
//                 ?.textStyle
//                 ?.resolve(WidgetState.values.toSet()))
//         ?.copyWith(color: previewColor);

//     return Container(
//       margin: const EdgeInsets.all(1),
//       decoration: BoxDecoration(
//           gradient: AppColors.gradient1,
//           color: AppColors.transparent,
//           borderRadius: BorderRadius.circular(buttonRadius)),
//       child: OutlinedButton(
//         onPressed: isLoading || isEnabled == false ? null : onPressed,
//         clipBehavior: Clip.antiAliasWithSaveLayer,
//         style: OutlinedButton.styleFrom(
//           elevation: elevation,
//           backgroundColor: backgroundColor,
//           side: BorderSide(
//             color: borderColor,
//             width: 1,
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(buttonRadius),
//           ),
//           minimumSize: const Size.fromHeight(45),
//           padding: const EdgeInsets.symmetric(
//             horizontal: 12,
//             vertical: 11,
//           ),
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
//           children: [
//             if (icon != null)
//               Padding(
//                 padding: const EdgeInsetsDirectional.only(end: 8),
//                 child: AppSvgIcon(path: icon!),
//               ),
//             Flexible(
//               child: FittedBox(
//                 fit: BoxFit.scaleDown,
//                 alignment: Alignment.center,
//                 child: ShaderMask(
//                   shaderCallback: (Rect bounds) {
//                     return AppColors.gradient1.createShader(bounds);
//                   },
//                   child: Text(
//                     text,
//                     style: textStyle ??
//                         TextStyles.regular16(
//                           color: AppColors.red400,
//                         ).copyWith(fontFamily: AppFonts.zain),
//                     textAlign: TextAlign.center,
//                     maxLines: 1,
//                   ),
//                 ),
//               ),
//             ),
//             if (isLoading)
//               _LoadingWidth(
//                 previewColor,
//               )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _LoadingWidth extends StatelessWidget {
//   const _LoadingWidth(this.color);

//   final Color? color;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 12,
//       width: 12,
//       margin: const EdgeInsetsDirectional.only(start: 10),
//       child: CircularProgressIndicator(
//         color: color ?? AppColors.mainColor,
//         strokeWidth: 2,
//       ),
//     );
//   }
// }
