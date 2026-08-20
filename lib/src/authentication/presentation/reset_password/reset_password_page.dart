// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../core/core.dart';
// import '../../../../material/buttons/app_button.dart';
// import '../../../../material/inputs/password_field.dart';
// import '../../../../material/media/svg_icon.dart';
// import '../../../../material/toast/app_toast.dart';
// import '../../domain/use_case/reset_password_use_case.dart';
// import 'reset_password_cubit.dart';

// class ResetPasswordPage extends StatefulWidget {
//   const ResetPasswordPage({super.key});

//   @override
//   State<ResetPasswordPage> createState() => _ResetPasswordPageState();
// }

// class _ResetPasswordPageState extends State<ResetPasswordPage> {
//   final newPasswordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//   final formKey = GlobalKey<FormState>();

//   void onSave() {
//     final bool isValid = formKey.currentState?.validate() ?? false;
//     if (isValid) {
//       context.read<ResetPasswordCubit>().resetPassword(
//         ResetPasswordParams(password: newPasswordController.text, passwordConfirmation: confirmPasswordController.text),
//       );
//     }
//   }

//   void onResetSuccess() {
//     AppToasts.success(context, message: appLocalizer.passwordResetSuccessMessage);
//     Navigator.popUntil(context, (route) => route.isFirst);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ResetPasswordCubit, Async<void>>(
//       listener: (context, state) {
//         if (state.isSuccess) {
//           onResetSuccess();
//         } else if (state.isFailure) {
//           AppToasts.error(context, message: state.errorMessage ?? '');
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           resizeToAvoidBottomInset: false,
//           appBar: AppBar(elevation: 0),
//           body: Form(
//             key: formKey,
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   AppSvgIcon(path: AppIllustrations.resetPasswordIllustration),
//                   const SizedBox(height: 16),
//                   Text(appLocalizer.changePassword, style: TextStyles.regular20.copyWith(color: AppColors.primary900)),
//                   const SizedBox(height: 12),
//                   Text.rich(
//                     TextSpan(
//                       text: appLocalizer.enterPassword,
//                       children: [
//                         TextSpan(
//                           text: "\t${appLocalizer.newWord}",
//                           style: TextStyles.light16.copyWith(color: AppColors.secondary),
//                         ),
//                       ],
//                     ),
//                     textAlign: TextAlign.center,
//                     style: TextStyles.light16.copyWith(color: AppColors.primary800),
//                   ),
//                   const SizedBox(height: 32),
//                   PasswordField(controller: newPasswordController, labelText: appLocalizer.newPassword, readOnly: state.isLoading),
//                   PasswordField(
//                     controller: confirmPasswordController,
//                     labelText: appLocalizer.confirmPassword,
//                     readOnly: state.isLoading,
//                     validator: (text) => Validator(text).confirmPasswordValidator(newPasswordController.text),
//                   ),
//                   const SizedBox(height: 40),
//                 ],
//               ),
//             ),
//           ),
//           bottomNavigationBar: SafeArea(
//             top: false,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//               child: SizedBox(
//                 height: 56,
//                 child: AppButton(text: appLocalizer.save, isLoading: state.isLoading, onPressed: onSave),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
