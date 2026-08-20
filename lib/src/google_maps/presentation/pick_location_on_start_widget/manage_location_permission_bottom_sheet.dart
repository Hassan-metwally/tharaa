// import '../../../../../core/core.dart';
// import '../../../../../core/di/di.dart';
// import '../../../../../material/buttons/app_button.dart';
// import '../../../../../material/media/svg_icon.dart';
// import '../../../../../material/overlay/show_modal_bottom_sheet.dart';
// import '../../../../../material/toast/app_toast.dart';
// import 'package:flutter/material.dart';

// import '../../domain/use_cases/location/get_current_location_use_case.dart';

// class ManageLocationPremisstionBottomSheet extends StatefulWidget {
//   const ManageLocationPremisstionBottomSheet(this.message, {super.key});

//   final String message;

//   static Future<void> show(BuildContext context, {required String message}) async {
//     return await showAppModalBottomSheet(enableDrag: false, context: context, child: ManageLocationPremisstionBottomSheet(message));
//   }

//   @override
//   State<ManageLocationPremisstionBottomSheet> createState() => _ManageLocationPremisstionBottomSheetState();
// }

// class _ManageLocationPremisstionBottomSheetState extends State<ManageLocationPremisstionBottomSheet> {
//   bool isLoading = false;

//   void _pickLocation() async {
//     setState(() {
//       isLoading = true;
//     });

//     final address = await injector<GetCurrentLocationUseCase>().call();
//     if (mounted) {
//       AppAuthenticationBloc.of(context).add(AuthenticatedEvent());
//     } else if (mounted && address == null) {
//       AppToasts.error(context, message: appLocalizer.failedToGetCurrentLocationMessage);
//     }

//     setState(() {
//       isLoading = true;
//     });
//     AppRouter.popUntil();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         AppSvgIcon(path: "AppIcons.location", size: 40),
//         const SizedBox(height: 24),
//         Text(
//           appLocalizer.locateYourself,
//           style: TextStyles.medium16.copyWith(color: AppColors.black),
//           textAlign: TextAlign.center,
//         ),
//         const SizedBox(height: 12),
//         Text(
//           widget.message,
//           textAlign: TextAlign.center,
//           style: TextStyles.regular16.copyWith(color: AppColors.black),
//         ),
//         const SizedBox(height: 24),
//         Row(
//           children: [
//             Expanded(
//               child: AppButton(isLoading: isLoading, text: appLocalizer.enableLocation, onPressed: _pickLocation),
//             ),
//             const SizedBox(width: 8),
//             Expanded(
//               child: AppButton(
//                 text: appLocalizer.cancel,
//                 buttonColor: AppColors.primary50,
//                 textStyle: TextStyles.medium16.copyWith(color: AppColors.primary),
//                 onPressed: () => AppRouter.pop(),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//       ],
//     );
//   }
// }
