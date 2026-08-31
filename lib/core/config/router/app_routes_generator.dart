import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../src/addresses/presentation/my_addresses/my_addresses_cubit.dart';
import '../../../src/addresses/presentation/my_addresses/my_addresses_page.dart';
import '../../../src/cart/presentation/cart_page/cart_page.dart';
import '../../../src/authentication/presentation/update_phone/update_phone_cubit.dart';
import '../../../src/authentication/presentation/update_phone/update_phone_page.dart';
import '../../../src/coupons/presentation/coupons/coupons_page.dart';
import '../../../src/more/presentation/personal_profile/personal_profile_cubit.dart';
import '../../../src/more/presentation/personal_profile/personal_profile_page.dart';
import '../../../app.dart';
import '../../../src/authentication/presentation/register/register_cubit.dart';
import '../../../src/authentication/presentation/register/register_page.dart';
import '../../../src/authentication/presentation/login/login_cubit.dart';
import '../../../src/authentication/presentation/login/login_page.dart';
import '../../../src/authentication/presentation/otp/otp_page.dart';
import '../../../src/common/domain/entity/menu/static_page_type_enum.dart';
import '../../../src/common/presentation/menu/contact_us/contact_us_page.dart';
import '../../../src/common/presentation/menu/static_page/static_page.dart';
import '../../../src/google_maps/presentation/maps_main_page.dart';
import '../../../src/categories/presentation/main_categories/main_categories_page.dart';
import '../../../src/categories/presentation/sub_categories/sub_categories_page.dart';
import '../../../src/products/presentation/products/products_page.dart';
import '../../../src/products/presentation/products/search_products_page.dart';
import '../../../src/notifications/presentation/notifications_page.dart';
import '../../../src/orders/presentation/show_order_details/show_order_details_page.dart';
import '../../../src/products/presentation/show_product_details/show_product_details_page.dart';
import '../../../src/wallet/presentation/_client_wallet/client_wallet_page.dart';
import '../../../src/wallet/presentation/payment_web_view/payment_webview_page.dart';
import '../../core.dart';
import '../../di/di.dart';
import 'app_routes.dart';

class AppRoutesGenerator {
  const AppRoutesGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Widget page;
    switch (settings.name) {
      case AppRoutes.appHome:
        page = const AppBuilderScreen();

      case AppRoutes.clientLoginPage:
        page = BlocProvider(create: (context) => LoginCubit(), child: const LoginPage());
      case AppRoutes.clientRegisterPage:
        page = BlocProvider(create: (context) => RegisterCubit(), child: const RegisterPage());
      case AppRoutes.clientPersonalProfile:
        page = BlocProvider(
          create: (context) => injector<ClientPersonalProfileCubit>()..getData(),
          child: const ClientPersonalProfilePage(),
        );
      case AppRoutes.clientWalletPage:
        page = const ClientWalletPage();
      case AppRoutes.cartPage:
        page = const CartPage();
      case AppRoutes.myAddressesPage:
        page = BlocProvider(create: (context) => injector<MyAddressesCubit>()..getAddresses(), child: const MyAddressesPage());
      case AppRoutes.couponsPage:
        page = const CouponsPage();
      case AppRoutes.mainCategoriesPage:
        final arguments = settings.arguments as MainCategoriesPage;
        page = arguments;
      case AppRoutes.subCategoriesPage:
        final arguments = settings.arguments as SubCategoriesPage;
        page = arguments;
      case AppRoutes.productsPage:
        final arguments = settings.arguments as ProductsPage;
        page = arguments;
      case AppRoutes.searchProductsPage:
        final arguments = settings.arguments as SearchProductsPage;
        page = arguments;
      case AppRoutes.showProductDetailsPage:
        final arguments = settings.arguments as ShowProductDetailsPage;
        page = arguments;
      case AppRoutes.showOrderDetailsPage:
        final arguments = settings.arguments as ShowOrderDetailsPage;
        page = arguments;

      /// Common and static and common pages
      ///
      case AppRoutes.staticPage:
        final argument = settings.arguments as StaticPageTypeEnum;
        page = StaticPage(pageType: argument);
      case AppRoutes.contactPage:
        page = const ContactUsPage();
      case AppRoutes.paymentWebView:
        final argument = settings.arguments as PaymentWebViewPage;
        page = argument;

      /// Maps
      ///
      case AppRoutes.mapsMainPage:
        final MapsMainPage arguments = settings.arguments as MapsMainPage;
        page = arguments;

      /// Notifications
      ///
      case AppRoutes.notificationsPage:
        final arguments = settings.arguments as NotificationsPage;
        page = arguments;

      /// Authentication
      ///
      case AppRoutes.otp:
        final arguments = settings.arguments as OtpPage;
        page = arguments;
      case AppRoutes.updatePhonePage:
        page = BlocProvider(create: (context) => UpdatePhoneCubit(), child: const UpdatePhonePage());
      // case AppRoutes.resetPassword:
      //   page = BlocProvider(create: (context) => ResetPasswordCubit(), child: const ResetPasswordPage());
      // case AppRoutes.updatePasswordPage:
      //   page = BlocProvider(create: (context) => UpdatePasswordCubit(), child: const UpdatePasswordPage());
      // // case AppRoutes.updatePhonePage:
      //   page = BlocProvider(
      //     create: (context) => UpdatePhoneCubit(),
      //     child: const StudentUpdatePhonePage(),
      //   );

      /// More Pages
      ///

      default:
        page = const Scaffold(body: Center(child: Text('404 - Page not found')));
    }
    return MaterialPageRoute(builder: (context) => page, settings: settings);
  }

  static Route<dynamic> errorRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(child: Text('404 - Page not found', style: TextStyles.regular20)),
      ),
    );
  }
}

class AppScaledBox extends StatelessWidget {
  const AppScaledBox({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: ResponsiveValue<double>(
        context,
        defaultValue: 450,
        conditionalValues: const [
          Condition.between(start: 0, end: 370, value: 355, landscapeValue: 500),
          Condition.between(start: 370, end: 450, value: 370, landscapeValue: 520),
          Condition.between(start: 450, end: 800, value: 440, landscapeValue: 780),
          Condition.between(start: 800, end: 1400, value: 540, landscapeValue: 820),
          Condition.between(start: 1400, end: 9999, value: 640, landscapeValue: 900),
        ],
      ).value,
      child: BouncingScrollWrapper.builder(context, child, dragWithMouse: true),
    );
  }
}
