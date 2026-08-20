import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'core/base/localization/l10n/app_localizations.dart';
import 'core/blocs/theme_notifier/theme_notifier.dart';
import 'core/config/router/app_routes.dart';
import 'core/config/router/app_routes_generator.dart';
import 'core/config/theme/dark_theme.dart';
import 'core/config/theme/light_theme.dart';
import 'core/core.dart';
import 'core/di/di.dart';
import 'src/authentication/presentation/login/login_page.dart';
import 'src/authentication/presentation/login/login_cubit.dart';
import 'src/common/presentation/splash/splash_page.dart';
import 'src/main_page/client_main_page.dart';
import 'src/onboarding/onboarding_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.builder(
      breakpoints: const [
        Breakpoint(start: 0, end: 450, name: MOBILE),
        Breakpoint(start: 451, end: 800, name: TABLET),
        Breakpoint(start: 801, end: 1920, name: DESKTOP),
        Breakpoint(start: 1921, end: double.infinity, name: '4K'),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AppLanguageCubit()..init()),
          BlocProvider(create: (context) => AppAuthenticationBloc()..add(const AppStartedEvent())),
          // BlocProvider(create: (context) => NotificationsCubit()),
        ],
        child: BlocBuilder<AppLanguageCubit, AppLanguageState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                if (FocusManager.instance.primaryFocus?.hasPrimaryFocus == true) {
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                }
              },
              child: ValueListenableBuilder(
                valueListenable: ThemeNotifier.instance,
                builder: (context, themeValue, child) {
                  return MaterialApp(
                    key: ValueKey(state.langCode.value + themeValue.hashCode.toString()),
                    title: appLocalizer.appName,
                    navigatorKey: appNavigatorKey,
                    debugShowCheckedModeBanner: false,
                    localizationsDelegates: AppLocalizations.localizationsDelegates,
                    supportedLocales: AppLocalizations.supportedLocales,
                    locale: state.langCode.local,
                    themeMode: themeValue.themeMode,
                    theme: const LightTheme().theme,
                    darkTheme: const DarkTheme().theme,
                    builder: (context, child) {
                      injector<LocalizationContainer>().setLocalizer(context);
                      return Overlay(
                        initialEntries: [OverlayEntry(builder: (context) => AppScaledBox(child: child ?? const SizedBox()))],
                      );
                    },
                    initialRoute: AppRoutes.appHome,
                    onGenerateRoute: AppRoutesGenerator.generateRoute,
                    onUnknownRoute: AppRoutesGenerator.errorRoute,
                    onGenerateInitialRoutes: (String initialRoute) {
                      return [AppRoutesGenerator.generateRoute(const RouteSettings(name: AppRoutes.appHome))];
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class AppBuilderScreen extends StatelessWidget {
  const AppBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppAuthenticationBloc, AppAuthenticationState>(
      builder: (context, state) {
        final Widget root;
        if (state is AuthUninitialized) {
          root = const SplashPage();
        } else if (state is AuthUnauthenticated) {
          root = const OnboardingPage();
        } else if (state is AuthLogInPageState || state is AuthLogOutState) {
          root = BlocProvider(create: (context) => LoginCubit(), child: const LoginPage());
        } else {
          root = const ClientMainPage();
        }

        return Material(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            key: ValueKey(state.runtimeType),
            child: Container(color: Colors.white, key: ValueKey(state.hashCode), child: root),
          ),
        );
      },
    );
  }
}
