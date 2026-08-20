// import 'package:flutter/material.dart';

// import '../../../../core/core.dart';
// import '../../../../material/buttons/app_button.dart';
// import '../../../../material/media/svg_icon.dart';
// import '../../../../material/overlay/show_modal_bottom_sheet.dart';

// class CompleteBankDataBottomSheet extends StatelessWidget {
//   const CompleteBankDataBottomSheet._();

//   static void show(BuildContext context) async {
//     return await showAppModalBottomSheet(
//       context: context,
//       child: const CompleteBankDataBottomSheet._(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         AppSvgIcon(path: "AppIcons.walletMoneyIc"),
//         const SizedBox(height: 12),
//         Text(
//           appLocalizer.bankAccountDetails,
//           style: TextStyles.medium18.copyWith(color: AppColors.black),
//         ),
//         const SizedBox(height: 32),
//         Text(
//           appLocalizer.enterBankDetails,
//           style: TextStyles.regular14.copyWith(color: AppColors.black),
//         ),
//         const SizedBox(height: 24),
//         Row(
//           spacing: 12,
//           children: [
//             Expanded(
//               child: AppButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 text: appLocalizer.agree,
//               ),
//             ),
//             Expanded(
//               child: AppButton(
//                 // buttonColor: "AppColors.card2Color",
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 text: appLocalizer.cancel,
//                 textStyle: TextStyles.medium16.copyWith(color: AppColors.black),
//               ),
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }
