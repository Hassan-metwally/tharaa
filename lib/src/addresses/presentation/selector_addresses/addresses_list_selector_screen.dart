// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:rxdart/rxdart.dart';

// import '../../../../../core/core.dart';
// import '../../../../../core/di/di.dart';
// import '../../../../../material/app_empty_widget.dart';
// import '../../../../../material/app_fail_widget.dart';
// import '../../../../../material/media/svg_icon.dart';
// import '../../../../../material/spin_kit_loading_widget.dart';
// import '../../domain/entities/location_entity.dart';
// import '../my_addresses/my_addresses_cubit.dart';
// import '../upsert_address/upsert_address_page.dart';
// import '../utils/products_subscription.dart';

// class AddressesListSelectorWidget extends StatelessWidget {
//   final UpdateCartDeliveryFeesCubit updateCartDeliveryFeesCubit;
//   const AddressesListSelectorWidget({super.key, required this.updateCartDeliveryFeesCubit});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => injector<MyAddressesCubit>()..getAddresses(),
//       child: _AddressesListSelectorWidgetBody(updateCartDeliveryFeesCubit: updateCartDeliveryFeesCubit),
//     );
//   }
// }

// class _AddressesListSelectorWidgetBody extends StatefulWidget {
//   final UpdateCartDeliveryFeesCubit updateCartDeliveryFeesCubit;
//   const _AddressesListSelectorWidgetBody({required this.updateCartDeliveryFeesCubit});

//   @override
//   State<_AddressesListSelectorWidgetBody> createState() => _AddressesListSelectorWidgetBodyState();
// }

// class _AddressesListSelectorWidgetBodyState extends State<_AddressesListSelectorWidgetBody> {
//   final _productsSubscriptionObj = CompositeSubscription();

//   @override
//   void initState() {
//     super.initState();
//     _productsSubscriptionObj.add(
//       MyAddressesSubscription.stream().listen((params) {
//         if (mounted) {
//           context.read<MyAddressesCubit>().getAddresses();
//         }
//       }),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _productsSubscriptionObj.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: Text(appLocalizer.savedAddresses, style: TextStyles.semiBold14.copyWith(color: AppColors.black)),
//             ),
//             GestureDetector(
//               behavior: HitTestBehavior.opaque,
//               onTap: () {
//                 UpssertAddressBottomSheet.show(context);
//               },
//               child: Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   color: AppColors.primary50,
//                   border: Border.all(color: AppColors.primary),
//                 ),
//                 child: Row(
//                   children: [
//                     AppSvgIcon(path: AppIcons.mapPointAdd),
//                     const SizedBox(width: 8),
//                     Text(appLocalizer.addAddress, style: TextStyles.regular12.copyWith(color: AppColors.primary)),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(8)),
//           child: BlocBuilder<MyAddressesCubit, MyAddressesState>(
//             builder: (context, state) {
//               if (state.getMyAddressesState.isLoading) {
//                 return const SpinKitLoadingWidget();
//               } else if (state.getMyAddressesState.isFailure) {
//                 return AppFailWidget(onRetry: () => BlocProvider.of<MyAddressesCubit>(context).getAddresses());
//               } else if (state.getMyAddressesState.isSuccess) {
//                 return Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     state.getMyAddressesState.data!.isEmpty
//                         ? AppEmptyWidget(text: appLocalizer.noAddressesYet, heightPercentage: 0.3, physics: NeverScrollableScrollPhysics())
//                         : ListView.separated(
//                             physics: const NeverScrollableScrollPhysics(),
//                             shrinkWrap: true,
//                             itemCount: state.getMyAddressesState.data!.length,
//                             separatorBuilder: (context, index) => const SizedBox(height: 1),
//                             itemBuilder: (context, index) {
//                               final LocationEntity address = state.getMyAddressesState.data![index];
//                               return BlocSelector<AddClientProductOrderCubit, AddClientProductOrderState, AddClientProductOrderParams>(
//                                 selector: (state) {
//                                   return state.params;
//                                 },
//                                 builder: (context, params) {
//                                   return _SelectorAddressTile(
//                                     entity: address,
//                                     value: address.id,
//                                     groupValue: params.addressId,
//                                     onChanged: (id) {
//                                       context.read<AddClientProductOrderCubit>().updateParams(params.copyWith(addressId: address.id));
//                                       widget.updateCartDeliveryFeesCubit.updateParams(UpdateCartDeliveryFeesParams(addressId: address.id));
//                                       widget.updateCartDeliveryFeesCubit.updateCartDeliveryFees();
//                                     },
//                                   );
//                                 },
//                               );
//                             },
//                           ),
//                     const SizedBox(height: 12),
//                   ],
//                 );
//               }
//               return const SizedBox.shrink();
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _SelectorAddressTile<T> extends StatelessWidget {
//   final LocationEntity entity;
//   final T value;
//   final T? groupValue;
//   final ValueChanged<T?> onChanged;
//   const _SelectorAddressTile({required this.entity, required this.value, required this.groupValue, required this.onChanged});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => onChanged(value),
//       child: Container(
//         margin: const EdgeInsets.all(4),
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: AppColors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: AppColors.black50),
//         ),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary50),
//               child: AppSvgIcon(path: AppIcons.location3),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text.rich(
//                     style: TextStyles.medium14.copyWith(color: AppColors.black),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     TextSpan(
//                       children: [
//                         TextSpan(text: entity.district),
//                         const TextSpan(text: ' - '),
//                         TextSpan(text: entity.building),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     entity.address,
//                     style: TextStyles.regular14.copyWith(color: AppColors.black900),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(width: 12),
//             _RadioWidget(isSelected: groupValue == value),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _RadioWidget extends StatelessWidget {
//   const _RadioWidget({required this.isSelected});
//   final bool isSelected;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 16,
//       width: 16,
//       padding: const EdgeInsets.all(2),
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: const Color(0xffF9F9F9),
//         border: Border.all(color: isSelected ? AppColors.primary : AppColors.black200, width: 1.5),
//       ),
//       child: isSelected
//           ? AnimatedContainer(
//               duration: const Duration(milliseconds: 250),
//               decoration: BoxDecoration(shape: BoxShape.circle, color: isSelected ? AppColors.primary : Colors.white),
//             )
//           : const SizedBox(),
//     );
//   }
// }
