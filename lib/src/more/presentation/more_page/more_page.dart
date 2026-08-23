import 'dart:math' as math;

import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/config/router/app_routes.dart';
import '../../../../core/core.dart';
import '../../../../core/di/di.dart';
import '../../../../material/auth_states/logged_user_checker_widget.dart';
import '../../../../material/change_language/change_language_bottom_sheet.dart';
import '../../../../material/media/app_image.dart';
import '../../../../material/media/svg_icon.dart';
import '../../../../material/spin_kit_loading_widget.dart';
import '../../../../material/widgets/animated_slide_opacity_widget.dart';
import '../../../authentication/presentation/delete_account/delete_account_bottom_sheet.dart';
import '../../../authentication/presentation/logout/logout_bottom_sheet.dart';
import '../../../common/domain/entity/menu/static_page_type_enum.dart';
import '../../../statistics/domain/entities/statistics_entity.dart';
import '../../../statistics/presentation/provider_statistics/provider_statistics_cubit.dart';
import '../../../statistics/presentation/provider_statistics/utils/get_provider_statistics_subscription.dart';
import 'more_cubit.dart';

part 'widgets/user_card.dart';
part 'widgets/user_tile.dart';

const Color _kMoreSectionFill = Color(0xFFF7F8FA);

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<MoreCubit>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(appLocalizer.more),
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(Dimensions.p16, 0, Dimensions.p16, 130),
          children: [
            const _UseCard(),
            AnimatedSlideWithOpacityWidget(
              index: 0,
              slideDirection: Alignment.bottomCenter,
              child: LoggedUserCheckerWidget(
                loggedBuilder: (user) {
                  return Padding(
                    padding: const EdgeInsets.only(top: Dimensions.p24),
                    child: _MoreSection(
                      title: appLocalizer.account,
                      children: [
                        _MoreTile(
                          icon: AppIcons.profileBulk,
                          text: appLocalizer.personalProfile,
                          onTap: () {
                            Navigator.of(context).pushNamed(AppRoutes.clientPersonalProfile);
                          },
                        ),
                        _MoreTile(
                          icon: AppIcons.mobileBulk,
                          text: appLocalizer.changePhoneNumber,
                          showDivider: false,
                          onTap: () {
                            AppRouter.pushNamed(AppRoutes.updatePhonePage);
                          },
                        ),
                        // _MoreTile(
                        //   icon: AppIcons.location,
                        //   text: appLocalizer.myAddress,
                        //   onTap: () {
                        //     AppRouter.pushNamed(AppRoutes.myAddressesPage);
                        //   },
                        // ),
                        // _MoreTile(icon: AppIcons.gift, text: appLocalizer.discountCoupons, showDivider: false, onTap: () {}),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: Dimensions.p24),
            AnimatedSlideWithOpacityWidget(
              index: 1,
              slideDirection: Alignment.bottomCenter,
              child: _MoreSection(
                title: appLocalizer.supportAndInfo,
                children: [
                  _MoreTile(
                    icon: AppIcons.smsTracking,
                    text: appLocalizer.contactUs,
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.contactPage);
                    },
                  ),
                  _MoreTile(
                    icon: AppIcons.infoCircle,
                    text: appLocalizer.whoWeAre,
                    showDivider: false,
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.staticPage, arguments: StaticPageTypeEnum.aboutUs);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: Dimensions.p24),
            AnimatedSlideWithOpacityWidget(
              index: 2,
              slideDirection: Alignment.bottomCenter,
              child: _MoreSection(
                title: appLocalizer.policies,
                children: [
                  _MoreTile(
                    icon: AppIcons.receiptItem,
                    text: appLocalizer.termsAndConditions,
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.staticPage, arguments: StaticPageTypeEnum.termsAndConditions);
                    },
                  ),
                  _MoreTile(
                    icon: AppIcons.security,
                    text: appLocalizer.privacyPolicy,
                    showDivider: false,
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.staticPage, arguments: StaticPageTypeEnum.privacyPolicy);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: Dimensions.p24),
            AnimatedSlideWithOpacityWidget(
              index: 3,
              slideDirection: Alignment.bottomCenter,
              child: _MoreSection(
                title: appLocalizer.preferences,
                children: [
                  _MoreTile(
                    icon: AppIcons.global,
                    text: appLocalizer.changeLanguage,
                    trailingText: AppLanguageCubit.of(context).isArabic ? 'اللغة العربية' : 'English',
                    showDivider: false,
                    onTap: () {
                      ChangeLanguageBottomSheet.show(context);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: Dimensions.p24),
            AnimatedSlideWithOpacityWidget(
              index: 4,
              slideDirection: Alignment.bottomCenter,
              child: LoggedUserCheckerWidget(
                loggedBuilder: (user) {
                  return _MoreSection(
                    title: appLocalizer.accountManagement,
                    children: [
                      _MoreTile(
                        icon: AppIcons.logout,
                        text: appLocalizer.logOut,
                        onTap: () {
                          LogoutBottomSheet.show(context);
                        },
                      ),
                      _MoreTile(
                        icon: AppIcons.profileDelete,
                        text: appLocalizer.deleteAccount,
                        showDivider: false,
                        onTap: () {
                          DeleteAccountBottomSheet.show(context);
                        },
                      ),
                    ],
                  );
                },
                guestWidget: _MoreSection(
                  title: appLocalizer.accountManagement,
                  children: [
                    _MoreTile(
                      icon: AppIcons.logout,
                      text: appLocalizer.login,
                      showDivider: false,
                      onTap: () {
                        AppAuthenticationBloc.of(context).add(const LoggedOutEvent());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
