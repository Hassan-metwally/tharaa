// import 'package:bounce/bounce.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../../core/core.dart';
// import '../../../../../material/app_fail_widget.dart';
// import '../../../../../material/auth_states/logged_user_checker_widget.dart';
// import '../../../../../material/spin_kit_loading_widget.dart';
// import '../../../../../material/widgets/theme_checker_widget.dart';
// import '../../../domain/entity/menu/faq_entity.dart';
// import 'faqs_cubit.dart';

// class FaqsPage extends StatelessWidget {
//   const FaqsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return LoggedUserCheckerWidget(
//       loggedBuilder: (user) => Scaffold(
//         body: BlocProvider(
//           create: (context) => FaqsCubit(),
//           child: BlocBuilder<FaqsCubit, Async<List<FaqEntity>>>(
//             builder: (context, state) {
//               if (state.isSuccess) {
//                 return _FaqScreen(data: state.data ?? []);
//               } else if (state.isLoading) {
//                 return SpinKitLoadingWidget(color: AppColors.primary);
//               } else if (state.isFailure) {
//                 return AppFailWidget(
//                   onRetry: () {
//                     FaqsCubit.of(context).getFaqData();
//                   },
//                 );
//               }
//               return const SizedBox();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _FaqScreen extends StatelessWidget {
//   const _FaqScreen({required this.data});
//   final List<FaqEntity> data;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//       child: Column(
//         children: [for (final faq in data) CustomExpandableTile(title: faq.name, description: faq.description)],
//       ),
//     );
//   }
// }

// class CustomExpandableTile extends StatefulWidget {
//   final String title;
//   final String description;

//   const CustomExpandableTile({super.key, required this.title, required this.description});

//   @override
//   State<CustomExpandableTile> createState() => _CustomExpandableTileState();
// }

// class _CustomExpandableTileState extends State<CustomExpandableTile> with SingleTickerProviderStateMixin {
//   bool _expanded = false;
//   late final AnimationController _controller;
//   late final Animation<double> _expandAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(duration: const Duration(milliseconds: 350), vsync: this);
//     _expandAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
//   }

//   void _toggleExpand() {
//     setState(() {
//       _expanded = !_expanded;
//       _expanded ? _controller.forward() : _controller.reverse();
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Material(
//         elevation: 1,
//         // color: AppColors.tileColorTeacher,
//         borderRadius: BorderRadius.circular(12),
//         child: Column(
//           children: [
//             Bounce(
//               onTap: _toggleExpand,
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 padding: const EdgeInsets.only(left: 16),
//                 decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(12),
//                     bottomLeft: Radius.circular(12),
//                     bottomRight: Radius.circular(6),
//                     topRight: Radius.circular(6),
//                   ),
//                   // gradient: _expanded
//                   //     ? AppColors.linearGradient1Horizntal
//                   //     : LinearGradient(colors: [
//                   //         AppColors.tileColorTeacher,
//                   //         AppColors.tileColorTeacher
//                   //       ]),
//                 ),
//                 child: Row(
//                   children: [
//                     const SizedBox(
//                       width: 6,
//                       height: 48,
//                       // decoration: BoxDecoration(
//                       //   gradient: AppColors.primaryGradient,
//                       //   borderRadius: const BorderRadius.only(
//                       //     topRight: Radius.circular(16),
//                       //     bottomRight: Radius.circular(16),
//                       //   ),
//                       // ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: ThemeCheckerWidget(
//                         darkchild: Text(widget.title, style: TextStyles.medium14.copyWith(color: Colors.white)),
//                         lightChild: Text(
//                           widget.title,
//                           // style: TextStyles.medium14.copyWith(
//                           //   color: _expanded ? Colors.white : AppColors.text,
//                           // ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                         // gradient: AppColors.primaryGradient,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Icon(
//                         _expanded ? Icons.remove : Icons.add,
//                         // color: AppColors.tileColorTeacher,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizeTransition(
//               sizeFactor: _expandAnimation,
//               axisAlignment: -1.0,
//               child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(12),
//                 decoration: const BoxDecoration(
//                   // color: AppColors.tileColorTeacher,
//                   borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
//                 ),
//                 child: Text(
//                   widget.description,
//                   // style: TextStyles.medium14.copyWith(color: AppColors.text3),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
