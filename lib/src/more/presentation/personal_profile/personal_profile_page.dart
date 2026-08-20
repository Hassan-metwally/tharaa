import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../material/app_fail_widget.dart';
import '../../../../material/app_loading_widget.dart';
import '../../../../material/buttons/app_button.dart';
import '../../../../material/inputs/avatar_field.dart';
import '../../../../material/inputs/intel_phone/phone_field.dart';
import '../../../../material/inputs/name_field.dart';
import '../../../../material/inputs/validator_field/validator_field.dart';
import '../../../../material/spin_kit_loading_widget.dart';
import '../../../../material/toast/app_toast.dart';
import '../../../authentication/presentation/update_phone/update_phone_page.dart';
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(appLocalizer.personalProfile),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: AppColors.appbarBorderColor, // border color
            height: 1.0,
          ),
        ),
      ),
      body: BlocSelector<ClientPersonalProfileCubit, ClientPersonalProfileState, Async<ClientEntity>>(
        selector: (state) {
          return state.getDataState;
        },
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

  void _onSavePressed() {
    final isValidForm = formKey.currentState?.validate() ?? false;
    if (isValidForm) {
      final params = UpdateProfileParams(image: _avatorController.value, name: _nameController.text);
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
  }

  @override
  Widget build(BuildContext context) {
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
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    ProfileAvatarWidget(controller: _avatorController),
                    const SizedBox(height: 20),
                    NameField(controller: _nameController, lable: appLocalizer.providerName, hint: appLocalizer.enterProviderName),
                    const SizedBox(height: 20),
                    Row(
                      spacing: 8,
                      children: [
                        Expanded(
                          flex: 3,
                          child: PhoneField(controller: TextEditingController(text: widget.client.mobile), readOnly: true),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: OutlinedButton(
                              onPressed: () {
                                UpdatePhonePage.show(context, phone: widget.client.mobile);
                              },
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(70, 44),
                                backgroundColor: AppColors.primary,
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                              ),
                              child: Text(appLocalizer.change, style: TextStyles.regular14.copyWith(color: AppColors.white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: SafeArea(
              top: false,
              child: AppButton(text: appLocalizer.saveEdites, onPressed: _onSavePressed),
            ),
          ),
        ],
      ),
    );
  }
}
