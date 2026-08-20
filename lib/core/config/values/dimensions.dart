part of core;

class Dimensions {
  const Dimensions._();

  static bool get isMobile {
    return true;
    // try {
    //   final context = AppRouter.navigatorKey.currentContext;
    //   if (context != null && context.mounted) {
    //     return ResponsiveBreakpoints.of(context).isMobile;
    //   } else {
    //     return _initialScreenWidth <= 600;
    //   }
    // } catch (_) {
    //   return _initialScreenWidth <= 600;
    // }
  }

  // static final double _initialScreenWidth = WidgetsBinding
  //         .instance.platformDispatcher.views.first.physicalSize.width /
  //     WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

  static const double buttonHeight = 48;
  static const double buttonMediumHeight = 40;
  static const double buttonMinHeight = 32;

  /// Radius Dimensions
  ///
  static const double r2 = 2.0;
  static const double r4 = 4.0;
  static const double r8 = 8.0;
  static const double r12 = 12.0;
  static const double r16 = 16.0;
  static const double r24 = 24.0;
  static const double r32 = 24.0;

  /// Icon Dimensions
  ///
  static const double ic14 = 14;
  static const double ic16 = 16;
  static const double ic18 = 18;
  static const double ic20 = 20;
  static const double ic24 = 24;
  static const double ic32 = 32;
  static const double ic40 = 40;
  static const double ic50 = 50;

  /// Padding Dimensions
  ///
  static const double p4 = 4;
  static const double p6 = 6;
  static const double p8 = 8;
  static const double p10 = 10;
  static const double p12 = 12;
  static const double p16 = 16;
  static const double p20 = 20;
  static const double p24 = 24;
  static const double p32 = 32;
  static const double p40 = 40;
  static const double p48 = 48;

  static const EdgeInsets pageMargins = EdgeInsets.symmetric(horizontal: p20, vertical: p20);
}
