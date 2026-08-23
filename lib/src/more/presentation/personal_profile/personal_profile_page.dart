import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../material/app_fail_widget.dart';
import '../../../../material/app_loading_widget.dart';
import '../../../../material/buttons/app_button.dart';
import '../../../../material/inputs/avatar_field.dart';
import '../../../../material/inputs/email_field.dart';
import '../../../../material/inputs/name_field.dart';
import '../../../../material/inputs/validator_field/validator_field.dart';
import '../../../../material/media/svg_icon.dart';
import '../../../../material/spin_kit_loading_widget.dart';
import '../../../../material/toast/app_toast.dart';
import '../../../common/domain/entity/users/client_entity.dart';
import '../../../main_page/models/client_main_page_tabs_enum.dart';
import '../../../main_page/observer/client_main_page_observer.dart';
import '../../domain/use_cases/update_profile_use_case.dart';
import 'personal_profile_cubit.dart';

class ClientPersonalProfilePage extends StatelessWidget {
  const ClientPersonalProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text(appLocalizer.personalProfile)),
      body: BlocSelector<ClientPersonalProfileCubit, ClientPersonalProfileState, Async<ClientEntity>>(
        selector: (state) => state.getDataState,
        builder: (context, state) {
          final clientData = state.data;
          if (state.isSuccess && clientData != null) {
            return _PageBody(client: clientData);
          } else if (state.isLoading) {
            return const SpinKitLoadingWidget();
          } else if (state.isFailure) {
            return AppFailWidget(onRetry: context.read<ClientPersonalProfileCubit>().getData);
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class _PageBody extends StatefulWidget {
  const _PageBody({required this.client});

  final ClientEntity client;

  @override
  State<_PageBody> createState() => __PageBodyState();
}

class __PageBodyState extends State<_PageBody> {
  final formKey = GlobalKey<FormState>();
  late final ValidatorFieldController<AttachmentEntity?> _avatorController;
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;

  void _onSavePressed() {
    final isValidForm = formKey.currentState?.validate() ?? false;
    if (isValidForm) {
      final params = UpdateProfileParams(image: _avatorController.value, name: _nameController.text, email: _emailController.text);
      context.read<ClientPersonalProfileCubit>().updateProfile(params);
    }
  }

  void _onUpdateProfileSuccess() async {
    AppToasts.success(context, message: appLocalizer.personalProfileUpdateSuccessMessage);
    AppAuthenticationBloc.of(context).add(const AuthenticatedEvent());
    await Future.delayed(const Duration(milliseconds: 1500), () {
      ClientMainPageUpdater.notifyOnChangedCallbacks(ClientMainPageTabsEnum.more);
      if (mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _avatorController = ValidatorFieldController<AttachmentEntity?>(initialValue: widget.client.avatar);
    _nameController = TextEditingController(text: widget.client.name);
    _emailController = TextEditingController(text: widget.client.email);
  }

  @override
  Widget build(BuildContext context) {
    final double bottomInset = MediaQuery.viewPaddingOf(context).bottom;

    return BlocListener<ClientPersonalProfileCubit, ClientPersonalProfileState>(
      listener: (context, state) {
        if (state.updateDataState.isSuccess) {
          AppLoadingWidget.removeOverlay();
          _onUpdateProfileSuccess();
        } else if (state.updateDataState.isFailure) {
          AppLoadingWidget.removeOverlay();
          AppToasts.error(context, message: state.updateDataState.errorMessage ?? '');
        } else if (state.updateDataState.isLoading) {
          AppLoadingWidget.overlay();
        }
      },
      child: SafeArea(
        top: false,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ProfileAvatarWidget(controller: _avatorController),
                      const SizedBox(height: 24),
                      NameField(
                        controller: _nameController,
                        lable: appLocalizer.fullName,
                        margin: EdgeInsets.zero,
                        labelTextStyle: TextStyles.semiBold14.copyWith(color: AppColors.black900),
                        prefix: SizedBox(width: 18, height: 18, child: AppSvgIcon(path: AppIcons.profile, width: 18, height: 18)),
                      ),
                      const SizedBox(height: 16),
                      EmailField(
                        controller: _emailController,
                        margin: EdgeInsets.zero,
                        isOptional: true,
                        hint: appLocalizer.emailExampleHint,
                        labelTextStyle: TextStyles.semiBold14.copyWith(color: AppColors.black900),
                        prefixIcon: SizedBox(width: 18, height: 18, child: AppSvgIcon(path: AppIcons.sms, width: 18, height: 18)),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 24, 16, bottomInset > 0 ? 8 : 32),
                child: AppButton(
                  text: appLocalizer.saveEdites,
                  onPressed: _onSavePressed,
                  textStyle: TextStyles.semiBold18.copyWith(color: Colors.white, height: 1, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _avatorController.dispose();
    super.dispose();
  }
}
