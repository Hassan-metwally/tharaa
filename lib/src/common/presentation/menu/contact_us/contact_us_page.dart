import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../../../core/utils/share_and_url_launch/popular_sites/popular_sites_utils.dart';
import '../../../../../material/app_fail_widget.dart';
import '../../../../../material/buttons/app_button.dart';
import '../../../../../material/inputs/app_text_form_field.dart';
import '../../../../../material/inputs/email_field.dart';
import '../../../../../material/inputs/name_field.dart';
import '../../../../../material/inputs/phone_field.dart';
import '../../../../../material/inputs/validator_field/validator_field.dart';
import '../../../../../material/media/svg_icon.dart';
import '../../../../../material/spin_kit_loading_widget.dart';
import '../../../../../material/toast/app_toast.dart';
import '../../../domain/entity/menu/contact_us_entity.dart';
import '../../../domain/use_cases/menu/send_contact_us_message_use_case.dart';
import '../../drop_downs/drop_downs/drop_down.dart';
import 'contact_us_cubit.dart';

part 'widgets/contact_us_tab_switcher.dart';
part 'widgets/contact_us_info_tab.dart';
part 'widgets/contact_us_send_message_tab.dart';

const Color _kContactUsFill = Color(0xFFF7F8FA);
const Color _kTabBorder = Color(0xFFD2D8E1);
const Color _kCallNow = Color(0xFF22C55E);
const Color _kSectionShadow = Color(0x0DB06828);

enum _ContactUsTab { contactInformation, sendMessage }

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(appLocalizer.contactUs),
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: BlocProvider(
        create: (context) => ContactUsCubit()..getData(),
        child: BlocBuilder<ContactUsCubit, ContactUsState>(
          builder: (context, state) {
            final data = state.dataState.data;
            if (state.dataState.isLoading) {
              return const Center(child: SpinKitLoadingWidget());
            } else if (state.dataState.isFailure) {
              return AppFailWidget(
                onRetry: () {
                  ContactUsCubit.of(context).getData();
                },
              );
            } else if (state.dataState.isSuccess && data != null) {
              return _ContactUsBody(data: data);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _ContactUsBody extends StatefulWidget {
  const _ContactUsBody({required this.data});

  final ContactUsEntity data;

  @override
  State<_ContactUsBody> createState() => __ContactUsBodyState();
}

class __ContactUsBodyState extends State<_ContactUsBody> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageContentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ValidatorFieldController<ContactUsMessageType?> messageTypeController = ValidatorFieldController();
  _ContactUsTab _selectedTab = _ContactUsTab.sendMessage;

  void _onSendMessage() {
    final isValidForm = _formKey.currentState?.validate() ?? false;
    final messageType = messageTypeController.value;
    if (isValidForm && messageType != null) {
      ContactUsCubit.of(context).sendMessage(
        SendContactUsMessageParams(
          countryCode: "+966",
          email: _emailController.text,
          name: _nameController.text,
          phone: _phoneController.text,
          type: messageType,
          message: _messageContentController.text,
        ),
      );
    }
  }

  void _onTabChanged(_ContactUsTab tab) {
    if (_selectedTab == tab) return;
    FocusScope.of(context).unfocus();
    setState(() => _selectedTab = tab);
  }

  @override
  Widget build(BuildContext context) {
    final double bottomInset = MediaQuery.viewPaddingOf(context).bottom;

    return BlocListener<ContactUsCubit, ContactUsState>(
      listener: (context, state) async {
        if (state.sendMessageState.isSuccess) {
          AppToasts.success(context, message: appLocalizer.sendContactUsMessageSuccess);
          if (context.mounted) {
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        } else if (state.sendMessageState.isFailure) {
          AppToasts.error(context, message: state.sendMessageState.errorMessage ?? '');
        }
      },
      child: SafeArea(
        top: false,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.p16),
                child: _ContactUsTabSwitcher(selectedTab: _selectedTab, onChanged: _onTabChanged),
              ),
              const SizedBox(height: Dimensions.p24),
              Expanded(
                child: IndexedStack(
                  index: _selectedTab.index,
                  children: [
                    _ContactUsInfoTab(data: widget.data),
                    _ContactUsSendMessageTab(
                      nameController: _nameController,
                      emailController: _emailController,
                      phoneController: _phoneController,
                      messageContentController: _messageContentController,
                      messageTypeController: messageTypeController,
                    ),
                  ],
                ),
              ),
              if (_selectedTab == _ContactUsTab.sendMessage)
                Padding(
                  padding: EdgeInsets.fromLTRB(Dimensions.p16, Dimensions.p24, Dimensions.p16, bottomInset > 0 ? 8 : Dimensions.p32),
                  child: BlocSelector<ContactUsCubit, ContactUsState, Async<void>>(
                    selector: (state) => state.sendMessageState,
                    builder: (context, state) {
                      return AppButton(
                        text: appLocalizer.sendTheMessage,
                        isLoading: state.isLoading,
                        onPressed: _onSendMessage,
                        textStyle: TextStyles.semiBold18.copyWith(color: Colors.white, height: 1, fontWeight: FontWeight.w600),
                      );
                    },
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
    _phoneController.dispose();
    _messageContentController.dispose();
    messageTypeController.dispose();
    super.dispose();
  }
}
