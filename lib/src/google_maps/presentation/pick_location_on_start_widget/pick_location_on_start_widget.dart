// import '../../../../../core/di/di.dart';

// import '../../../../../core/config/router/app_routes.dart';
// import '../../../../../core/core.dart';
// import '../../../../../material/media/svg_icon.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../core/domain/entities/cached_address_entity.dart';
// import '../../domain/entities/address_entity.dart';
// import '../../domain/use_cases/location/update_user_location_use_case.dart';
// import '../maps_main_page.dart';
// import 'manage_location_permission_bottom_sheet.dart';

// class PickLocationOnStartWidget extends StatefulWidget {
//   const PickLocationOnStartWidget({super.key, required this.addressColor, required this.iconColor, required this.message});

//   final Color iconColor;
//   final Color addressColor;
//   final String message;

//   @override
//   State<PickLocationOnStartWidget> createState() => _PickLocationOnStartWidgetState();
// }

// class _PickLocationOnStartWidgetState extends State<PickLocationOnStartWidget> {
//   final UpdateUserLocationUseCase _updateLocationUseCase = injector<UpdateUserLocationUseCase>();

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (!hasInitialAddress) {
//         ManageLocationPremisstionBottomSheet.show(context, message: widget.message);
//       }
//     });
//   }

//   bool get hasInitialAddress {
//     final authState = AppAuthenticationBloc.of(context).state;
//     if (authState is AuthAuthenticatedState) {
//       return authState.user.address != null;
//     }
//     return false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: BlocBuilder<AppAuthenticationBloc, AppAuthenticationState>(
//             builder: (context, state) {
//               CachedAddressEntity? address;
//               if (state is AuthAuthenticatedState) {
//                 address = state.user.address;
//               }
//               if (address != null) {
//                 return Row(
//                   children: [
//                     GestureDetector(
//                       behavior: HitTestBehavior.opaque,
//                       onTap: () {
//                         ManageLocationPremisstionBottomSheet.show(context, message: widget.message);
//                       },
//                       child: Padding(
//                         padding: const EdgeInsetsDirectional.only(end: 4),
//                         child: AppSvgIcon(path: "AppIcons.location4", color: widget.iconColor),
//                       ),
//                     ),
//                     Expanded(
//                       child: GestureDetector(
//                         behavior: HitTestBehavior.opaque,
//                         onTap: () {
//                           AppRouter.pushNamed(
//                             AppRoutes.mapsMainPage,
//                             arguments: MapsMainPage(onlyPreviewAddress: false, initialMapAddress: address?.getAsMapAddressEntity),
//                           ).then((value) async {
//                             if (context.mounted && value != null && value is MapAddressEntity) {
//                               await _updateLocationUseCase(
//                                   UpdateUserAddressParams(address: value.address, lat: value.lat, lng: value.long));
//                               AppAuthenticationBloc.of(context).add(AuthenticatedEvent());
//                             }
//                           });
//                         },
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(
//                               address.addressFirstSection,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyles.regular11.copyWith(color: widget.addressColor),
//                             ),
//                             if (address.addressSecondSection?.isNotEmpty == true) const SizedBox(height: 4),
//                             if (address.addressSecondSection?.isNotEmpty == true)
//                               Text(
//                                 address.addressSecondSection ?? '',
//                                 style: TextStyles.regular11.copyWith(color: widget.addressColor),
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                   ],
//                 );
//               } else {
//                 return GestureDetector(
//                   behavior: HitTestBehavior.opaque,
//                   onTap: () {
//                     ManageLocationPremisstionBottomSheet.show(context, message: widget.message);
//                   },
//                   child: Row(
//                     children: [
//                       AppSvgIcon(path: "AppIcons.location4", color: widget.iconColor, height: 16, width: 16),
//                       const SizedBox(width: 4),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(appLocalizer.selectYourlocation, style: TextStyles.regular14.copyWith(color: widget.addressColor)),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
