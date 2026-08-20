// part of '../client_more_page.dart';

// class _GridCardsWidget extends StatelessWidget {
//   const _GridCardsWidget();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Row(
//         spacing: 4,
//         children: [
//           Expanded(
//             child: AnimatedSlideWithOpacityWidget(
//               slideDirection: AlignmentDirectional.centerStart,
//               child: _GridCard(icon: AppIcons.shareIc, text: appLocalizer.shareApp, onTap: () {}),
//             ),
//           ),
//           Expanded(
//             child: _GridCard(icon: AppIcons.addCircleIc, text: appLocalizer.myAdds, onTap: () {}),
//           ),
//           Expanded(
//             child: AnimatedSlideWithOpacityWidget(
//               slideDirection: AlignmentDirectional.centerEnd,
//               child: _GridCard(icon: AppIcons.crownIc, text: appLocalizer.packagesAndSubscriptions, onTap: () {}),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _GridCard extends StatelessWidget {
//   const _GridCard({required this.icon, required this.text, required this.onTap});

//   final String icon;
//   final String text;
//   final VoidCallback onTap;

//   @override
//   Widget build(BuildContext context) {
//     return Bounce(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//         decoration: BoxDecoration(
//           color: AppColors.cardColor,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: AppColors.enabledBorderColor),
//         ),
//         child: Column(
//           spacing: 14,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             AppSvgIcon(path: icon, size: 24),
//             FittedBox(
//               fit: BoxFit.scaleDown,
//               child: Text(text, style: TextStyles.light12, maxLines: 1),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
