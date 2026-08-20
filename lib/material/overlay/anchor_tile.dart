// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:thoad/core/core.dart';
// import 'package:thoad/material/overlay/show_dialog.dart';

// class AnchorTile extends StatelessWidget {
//   const AnchorTile({
//     super.key,
//     required this.child,
//     required this.children,
//     this.minChildrenWidth = 170,
//     this.align = AlignmentDirectional.centerStart,
//     this.dx = .25,
//     this.dy = 0.09,
//     this.headerText,
//   });

//   final Widget child;
//   final List<Widget> children;
//   final double minChildrenWidth;
//   final AlignmentDirectional align;
//   final double dx;
//   final String? headerText;
//   final double dy;

//   @override
//   Widget build(BuildContext context) {
//     final List<Widget> children = [];
//     for (int index = 0; index < this.children.length; index++) {
//       final bool isLast = index == this.children.length - 1;
//       children.add(this.children[index]);
//       if (!isLast) {
//         children.add(Container(
//           width: minChildrenWidth,
//           height: 1,
//           color: AppColors.primary50,
//         ));
//       }
//     }

//     return GestureDetector(
//         behavior: HitTestBehavior.opaque,
//         onTap: () {
//           _showAnimatedDialog(
//             context: context,
//             align: align,
//             dx: dx,
//             dy: dy,
//             hasBorder: headerText?.isNotEmpty == true,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 if (headerText?.isNotEmpty == true)
//                   Text(
//                     headerText ?? '',
//                     textAlign: TextAlign.center,
//                     style: TextStyles.medium14,
//                   ),
//                 if (headerText?.isNotEmpty == true)
//                   Container(
//                     height: 2,
//                     width: minChildrenWidth,
//                     color: AppColors.primary600,
//                     margin: const EdgeInsets.only(top: 10),
//                   ),
//                 ...children
//               ],
//             ),
//           );
//         },
//         child: child);
//   }
// }

// class AnchorTileDefaultChild extends StatelessWidget {
//   const AnchorTileDefaultChild({
//     super.key,
//     required this.text,
//     required this.onTap,
//     this.textStyle = TextStyles.regular14,
//   });
//   final String text;
//   final VoidCallback onTap;
//   final TextStyle textStyle;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       behavior: HitTestBehavior.opaque,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(
//           text,
//           style: textStyle,
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
// }

// Future<T?> _showAnimatedDialog<T>({
//   required BuildContext context,
//   required Widget child,
//   double minChildrenWidth = 150,
//   double dx = 0.25,
//   double dy = 0.12,
//   AlignmentDirectional align = AlignmentDirectional.centerStart,
//   bool hasBorder = false,
//   double topPadding = 32,
// }) async {
//   if (FocusManager.instance.primaryFocus?.hasPrimaryFocus == true) {
//     FocusScope.of(context).requestFocus(FocusNode());
//     SystemChannels.textInput.invokeMethod('TextInput.hide');
//   }
//   final Offset startOffset, endOffset;
//   if (align == AlignmentDirectional.centerStart && !isLTR) {
//     startOffset = Offset(0.5, dy);
//     endOffset = Offset(dx, dy);
//   } else if (align == AlignmentDirectional.centerStart && isLTR) {
//     startOffset = Offset(-0.5, dy);
//     endOffset = Offset(-dx, dy);
//   } else if (align == AlignmentDirectional.centerEnd && !isLTR) {
//     startOffset = Offset(-0.5, dy);
//     endOffset = Offset(-dx, dy);
//   } else if (align == AlignmentDirectional.centerEnd && isLTR) {
//     startOffset = Offset(0.5, dy);
//     endOffset = Offset(dx, dy);
//   } else {
//     startOffset = Offset(0.5, dy);
//     endOffset = Offset(dx, dy);
//   }
//   return await showGeneralDialog<T?>(
//     context: context,
//     barrierDismissible: true,
//     barrierLabel: "ShowAnimatedDialog",
//     routeSettings: const RouteSettings(name: "ShowAnimatedDialog"),
//     barrierColor: Colors.transparent,
//     pageBuilder: (BuildContext buildContext, Animation animation,
//         Animation secondaryAnimation) {
//       return Align(
//         alignment: Alignment.topCenter,
//         child: Material(
//           color: Colors.transparent,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: SingleChildScrollView(
//             padding: EdgeInsets.only(
//               bottom: 60,
//               left: 32,
//               right: 32,
//               top: topPadding,
//             ),
//             physics: const BouncingScrollPhysics(),
//             child: Container(
//               clipBehavior: Clip.antiAliasWithSaveLayer,
//               constraints: BoxConstraints(
//                 minWidth: minChildrenWidth,
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12.0),
//                 border: hasBorder
//                     ? Border.all(
//                         color: AppColors.primary600,
//                         width: 2,
//                       )
//                     : null,
//                 boxShadow: [
//                   const BoxShadow(
//                     color: AppColors.primary600,
//                     offset: Offset(8, 8),
//                   ),
//                   if (!hasBorder)
//                     const BoxShadow(
//                       color: AppColors.primary50,
//                       offset: Offset(-.5, -.5),
//                       blurRadius: .5,
//                       spreadRadius: .5,
//                     ),
//                 ],
//               ),
//               padding: const EdgeInsets.only(bottom: 12, top: 12),
//               child: child,
//             ),
//           ),
//         ),
//       );
//     },
//     transitionBuilder: (context, anim1, anim2, child) {
//       return SlideTransition(
//         position: Tween<Offset>(
//           begin: startOffset,
//           end: endOffset,
//         ).animate(anim1),
//         child: child,
//       );
//     },
//     transitionDuration: const Duration(milliseconds: 300),
//   );
// }
