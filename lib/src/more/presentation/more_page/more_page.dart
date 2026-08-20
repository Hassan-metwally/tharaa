import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/router/app_routes.dart';
import '../../../../core/core.dart';
import '../../../../core/di/di.dart';
import '../../../../material/auth_states/logged_user_checker_widget.dart';
import '../../../../material/change_language/change_language_bottom_sheet.dart';
import '../../../../material/media/app_image.dart';
import '../../../../material/media/svg_icon.dart';
import '../../../../material/widgets/animated_slide_opacity_widget.dart';
import '../../../authentication/presentation/delete_account/delete_account_bottom_sheet.dart';
import '../../../authentication/presentation/logout/logout_bottom_sheet.dart';
import '../../../common/domain/entity/menu/static_page_type_enum.dart';
import 'more_cubit.dart';

part 'widgets/user_card.dart';
part 'widgets/user_tile.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<MoreCubit>(),
      child: Scaffold(
        appBar: AppBar(title: Text(appLocalizer.more)),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const _UseCard(),
            AnimatedSlideWithOpacityWidget(
              index: 0,
              slideDirection: Alignment.bottomCenter,
              child: _GroupTiles(
                children: [
                  LoggedUserCheckerWidget(
                    loggedBuilder: (user) {
                      return Column(
                        spacing: 8,
                        children: [
                          _Tile(
                            icon: "",
                            text: appLocalizer.wallet,
                            onTap: () {
                              AppRouter.pushNamed(AppRoutes.clientWalletPage);
                            },
                          ),
                          _Tile(
                            icon: "",
                            text: appLocalizer.myAddress,
                            onTap: () {
                              AppRouter.pushNamed(AppRoutes.myAddressesPage);
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  _Tile(
                    icon: "",
                    text: appLocalizer.aboutApp,
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.staticPage, arguments: StaticPageTypeEnum.aboutUs);
                    },
                  ),
                  _Tile(
                    icon: "",
                    text: appLocalizer.privacyPolicy,
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.staticPage, arguments: StaticPageTypeEnum.privacyPolicy);
                    },
                  ),
                  _Tile(
                    icon: "",
                    text: appLocalizer.termsAndConditions,
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.staticPage, arguments: StaticPageTypeEnum.termsAndConditions);
                    },
                  ),
                  _Tile(
                    icon: "",
                    text: appLocalizer.contactUs,
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.contactPage);
                    },
                  ),
                  _Tile(
                    icon: "",
                    text: appLocalizer.manageLanguage,
                    traillingText: AppLanguageCubit.of(context).state.langCode.value == 'ar' ? "اللغة العربية" : "English",
                    onTap: () {
                      ChangeLanguageBottomSheet.show(context);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            AnimatedSlideWithOpacityWidget(
              index: 5,
              slideDirection: Alignment.bottomCenter,
              child: LoggedUserCheckerWidget(
                loggedBuilder: (user) {
                  return _GroupTiles(
                    children: [
                      _Tile(
                        icon: "",
                        text: appLocalizer.logOut,
                        textStyle: TextStyles.regular14.copyWith(color: AppColors.red400),
                        onTap: () {
                          LogoutBottomSheet.show(context);
                        },
                      ),
                      _Tile(
                        icon: "",
                        text: appLocalizer.deleteAccount,
                        textStyle: TextStyles.regular14.copyWith(color: AppColors.red400),
                        onTap: () {
                          DeleteAccountBottomSheet.show(context);
                        },
                      ),
                    ],
                  );
                },
                guestWidget: _GroupTiles(
                  children: [
                    _Tile(
                      icon: "",
                      text: appLocalizer.login,
                      textStyle: TextStyles.regular14.copyWith(color: AppColors.red400),
                      onTap: () {
                        AppAuthenticationBloc.of(context).add(const LoggedOutEvent());
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
