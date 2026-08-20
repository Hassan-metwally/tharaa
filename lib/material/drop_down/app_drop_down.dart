// import 'package:flutter/material.dart';
// import 'package:thoad/material/app_loading_widget.dart';

// import '../../core/core.dart';

// class AppDropdownSingleSelect<T> extends StatelessWidget {
//   final String? title;
//   final TextStyle? titleStyle;
//   final String? hint;
//   final T? selectedValue;
//   final String? Function(T? value)? validator;
//   final Color? fillColor;
//   final List<T> items;
//   final void Function(T? value)? onChanged;
//   final String Function(T displayValue) itemDisplay;
//   final Widget? prefixIcon;
//   final bool isLoading;
//   final bool isFailer;
//   final bool isOptional;
//   final double titlePadding;

//   const AppDropdownSingleSelect({
//     super.key,
//     this.title,
//     this.selectedValue,
//     this.hint,
//     this.isLoading = false,
//     required this.items,
//     this.onChanged,
//     required this.itemDisplay,
//     this.prefixIcon,
//     this.fillColor,
//     this.validator,
//     this.titleStyle,
//     this.isFailer = false,
//     this.isOptional = false,
//     this.titlePadding = 8,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final selectdItem = items.firstWhereOrNull(
//       (value) => value == selectedValue,
//     );
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (title != null)
//           Padding(
//             padding: EdgeInsets.only(bottom: titlePadding),
//             child: Text.rich(
//               TextSpan(
//                 text: title,
//                 style: titleStyle ?? TextStyles.regular12,
//                 children: [
//                   if (isOptional)
//                     TextSpan(
//                       text: '\t*',
//                       style: (titleStyle ?? TextStyles.regular12)
//                           .copyWith(color: AppColors.error),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         DropdownButtonFormField<T>(
//           validator: validator,
//           menuMaxHeight: MediaQuery.of(context).size.height * .85,
//           decoration: InputDecoration(
//             fillColor: fillColor,
//             filled: fillColor != null,
//             prefixIcon: prefixIcon != null
//                 ? UnconstrainedBox(
//                     child: Padding(
//                         padding: const EdgeInsetsDirectional.only(start: 16),
//                         child: prefixIcon),
//                   )
//                 : null,
//           ),
//           hint: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 hint ?? title ?? '',
//                 style: TextStyles.regular12.copyWith(
//                   color: AppColors.greyColor,
//                 ),
//               ),
//             ],
//           ),
//           value: selectdItem,
//           icon: _getSuffixWidget,
//           iconSize: 16,
//           elevation: 1,
//           onChanged: onChanged,
//           isExpanded: true,
//           selectedItemBuilder: (context) {
//             return items.map((T value) {
//               return Text(
//                 itemDisplay(value),
//                 style: TextStyles.regular12,
//               );
//             }).toList();
//           },
//           items: items.map((T value) {
//             final bool isSelected = value == selectdItem;
//             return DropdownMenuItem<T>(
//               value: value,
//               child: Text(
//                 itemDisplay(value),
//                 style: isSelected ? TextStyles.bold14 : TextStyles.regular14,
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }

//   Widget get _getSuffixWidget {
//     if (isFailer) {
//       return const Icon(
//         Icons.info_outline,
//         color: Colors.red,
//         size: 20,
//       );
//     } else if (isLoading) {
//       const AppLoadingWidget(
//         size: 15,
//         strokeWidth: 3,
//       );
//     } else {
//       return Icon(
//         Icons.keyboard_arrow_down,
//         color: AppColors.primary300,
//         size: 20,
//       );
//     }
//     return const SizedBox();
//   }
// }
