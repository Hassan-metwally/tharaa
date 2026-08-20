import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../../../core/utils/share_and_url_launch/popular_sites/popular_sites_utils.dart';
import '../../../../../material/app_fail_widget.dart';
import '../../../../../material/buttons/app_button.dart';
import '../../../../../material/inputs/app_text_form_field.dart';
import '../../../../../material/inputs/email_field.dart';
import '../../../../../material/inputs/intel_phone/phone_field.dart';
import '../../../../../material/inputs/name_field.dart';
import '../../../../../material/inputs/validator_field/validator_field.dart';
import '../../../../../material/media/svg_icon.dart';
import '../../../../../material/spin_kit_loading_widget.dart';
import '../../../../../material/toast/app_toast.dart';
import '../../../domain/entity/menu/contact_us_entity.dart';
import '../../../domain/use_cases/menu/send_contact_us_message_use_case.dart';
import '../../drop_downs/drop_downs/drop_down.dart';
import 'contact_us_cubit.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizer.contactUs),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: AppColors.appbarBorderColor, // border color
            height: 1.0,
          ),
        ),
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

  @override
  Widget build(BuildContext context) {
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
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _HeaderText(),
              const SizedBox(height: 12),
              _CardWidget(
                title: appLocalizer.sendMessage,
                icon: "",
                children: [
                  NameField(
                    controller: _nameController,
                    prefix: AppSvgIcon(path: ""),
                  ),
                  EmailField(
                    controller: _emailController,
                    prefixIcon: AppSvgIcon(path: ""),
                  ),
                  PhoneField(controller: _phoneController),
                  AppSingleDropDown(
                    controller: messageTypeController,
                    itemDisplay: (displayValue) => displayValue?.title,
                    title: appLocalizer.messageType,
                    hint: appLocalizer.selectMessageType,
                    items: ContactUsMessageType.values,
                    prefixIc: "",
                  ),
                  AppTextFormField(
                    controller: _messageContentController,
                    minLines: 5,
                    maxLines: 7,
                    prefixIcon: (isFocused) => Align(
                      heightFactor: 6.1,
                      alignment: Alignment.topCenter,
                      child: AppSvgIcon(path: ""),
                    ),
                    label: appLocalizer.messageText,
                    hint: appLocalizer.writeHere,
                    validator: (text) {
                      return Validator(text).defaultValidator;
                    },
                  ),
                  const SizedBox(height: 12),
                  BlocSelector<ContactUsCubit, ContactUsState, Async<void>>(
                    selector: (state) => state.sendMessageState,
                    builder: (context, state) {
                      return AppButton(text: appLocalizer.send, isLoading: state.isLoading, onPressed: _onSendMessage);
                    },
                  ),
                  const SizedBox(height: 12),
                ],
              ),
              const SizedBox(height: 20),
              if (widget.data.email.isNotEmpty ||
                  widget.data.mobiles.isNotEmpty ||
                  widget.data.whatsapp.isNotEmpty ||
                  widget.data.getSocialLinks.isNotEmpty)
                _CardWidget(
                  title: appLocalizer.contactData,
                  icon: "",
                  subTitle: appLocalizer.contactWays,
                  bgColor: const Color(0xffFAFAFA),
                  children: [
                    if (widget.data.email.isNotEmpty)
                      _TileWidget(
                        icon: "",
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => LaunchUrlUtils.openEmailAddress(widget.data.email),
                            child: Text(
                              widget.data.email,
                              style: TextStyles.light14.copyWith(
                                color: AppColors.primary,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (widget.data.mobiles.isNotEmpty)
                      _TileWidget(
                        icon: "",
                        hasSeperator: true,
                        children: widget.data.mobiles.map((e) {
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => LaunchUrlUtils.openPhoneNumber(e),
                            child: Text(
                              e,
                              style: TextStyles.light14.copyWith(
                                color: AppColors.primary,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primary,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    if (widget.data.whatsapp.isNotEmpty)
                      _TileWidget(
                        icon: "",
                        hasSeperator: true,
                        children: widget.data.whatsapp.map((e) {
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => LaunchUrlUtils.openInWhatsApp(e),
                            child: Text(
                              e,
                              style: TextStyles.light14.copyWith(
                                color: AppColors.primary,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primary,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.data.getSocialLinks.map((url) {
                        return PopularSitesLinksUtils(url).builder(context, (url, launchFun, siteWidget) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(100),
                            onTap: launchFun,
                            child: Container(
                              height: 40,
                              width: 40,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.cardColor,
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.enabledBorderColor),
                              ),
                              child: FittedBox(child: siteWidget),
                            ),
                          );
                        });
                      }).toList(),
                    ),
                  ],
                ),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardWidget extends StatelessWidget {
  const _CardWidget({required this.children, required this.title, this.subTitle, required this.icon, this.bgColor});
  final List<Widget> children;
  final String title;
  final String? subTitle;
  final String icon;
  final Color? bgColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        Row(
          children: [
            AppSvgIcon(path: icon),
            const SizedBox(width: 4),
            Expanded(child: Text(title, style: TextStyles.light12)),
          ],
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: bgColor ?? AppColors.cardColor,
            borderRadius: BorderRadius.circular(12),
            border: bgColor != null ? null : Border.all(color: AppColors.enabledBorderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (subTitle != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16, top: 8),
                  child: Text(subTitle ?? '', style: TextStyles.light14),
                ),
              ...children,
            ],
          ),
        ),
      ],
    );
  }
}

class _TileWidget extends StatelessWidget {
  const _TileWidget({required this.icon, required this.children, this.hasSeperator = false});
  final String icon;
  final List<Widget> children;
  final bool hasSeperator;

  @override
  Widget build(BuildContext context) {
    // Create a new list where each item is followed by a separator
    final List<Widget> items = [];
    for (int i = 0; i < children.length; i++) {
      items.add(children[i]);
      if (i != children.length - 1 && hasSeperator) {
        items.add(Text('-', style: TextStyles.regular14.copyWith(color: AppColors.primary900)));
      }
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20,
            width: 20,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.black200),
              shape: BoxShape.circle,
            ),
            child: FittedBox(child: AppSvgIcon(path: icon)),
          ),
          Expanded(child: Wrap(runSpacing: 8, spacing: 8, children: items)),
        ],
      ),
    );
  }
}

class _HeaderText extends StatelessWidget {
  const _HeaderText();

  @override
  Widget build(BuildContext context) {
    final List<String> subHeaderSeqments = appLocalizer.contactHeader.split('##');
    final String firstSection = subHeaderSeqments.firstOrNull ?? '';
    String secondSection = '';
    if (subHeaderSeqments.length > 1) {
      secondSection = subHeaderSeqments[1];
    }
    String lastSection = '';
    if (subHeaderSeqments.length > 2) {
      lastSection = subHeaderSeqments[2];
    }
    return Text.rich(
      TextSpan(
        text: firstSection,
        style: TextStyles.light14.copyWith(color: AppColors.black800),
        children: [
          if (secondSection.isNotEmpty)
            TextSpan(
              text: "\t$secondSection",
              style: TextStyles.light14.copyWith(color: AppColors.primary),
            ),
          if (lastSection.isNotEmpty) TextSpan(text: '\t$lastSection'),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
