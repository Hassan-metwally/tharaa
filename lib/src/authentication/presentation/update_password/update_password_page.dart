// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../core/core.dart';
// import '../../../../material/app_loading_widget.dart';
// import '../../../../material/buttons/app_button.dart';
// import '../../../../material/inputs/password_field.dart';
// import '../../../../material/toast/app_toast.dart';
// import '../../domain/use_case/update_password_use_case.dart';
// import 'update_password_cubit.dart';

// class UpdatePasswordPage extends StatefulWidget {
//   const UpdatePasswordPage({super.key});

//   @override
//   State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
// }

// class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
//   final oldPassword = TextEditingController();
//   final newPassword = TextEditingController();
//   final confirmNewPassword = TextEditingController();
//   final formKey = GlobalKey<FormState>();

//   void onSave() {
//     final isValidForm = formKey.currentState?.validate() ?? false;
//     if (isValidForm) {
//       final params = UpdatePasswordParams(
//         password: newPassword.text,
//         oldPassword: oldPassword.text,
//         passwordConfirmation: confirmNewPassword.text,
//       );
//       context.read<UpdatePasswordCubit>().updatePassword(params);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(title: Text(appLocalizer.changePassword)),
//       body: Form(
//         key: formKey,
//         child: BlocListener<UpdatePasswordCubit, Async<void>>(
//           listener: (context, state) {
//             if (state.isLoading) {
//               AppLoadingWidget.overlay();
//             } else if (state.isSuccess) {
//               AppToasts.success(context, message: appLocalizer.passwordResetSuccessMessage);
//               Navigator.of(context).popUntil((route) => route.isFirst);
//               AppAuthenticationBloc.of(context).add(const LoggedOutEvent());
//             } else if (state.isFailure) {
//               AppLoadingWidget.removeOverlay();
//               AppToasts.error(context, message: state.errorMessage ?? '');
//             }
//           },
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               children: [
//                 PasswordField(controller: oldPassword, labelText: appLocalizer.currentPassword),
//                 PasswordField(controller: newPassword, labelText: appLocalizer.newPassword),
//                 PasswordField(
//                   controller: confirmNewPassword,
//                   labelText: appLocalizer.confirmPassword,
//                   validator: (text) => Validator(text).confirmPasswordValidator(newPassword.text),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: SafeArea(
//         top: false,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//           child: AppButton(text: appLocalizer.save, onPressed: onSave),
//         ),
//       ),
//     );
//   }
// }
