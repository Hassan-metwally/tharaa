import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';
import 'guest_bottom_sheet.dart';

class GuestCheckerWidget extends StatelessWidget {
  const GuestCheckerWidget({
    super.key,
    required this.child,
    this.guestWidget = const SizedBox(),
    this.enableGesture = false,
    this.replaceWithDefaultGuestWidget = false,
  }) : isSliver = false;

  const GuestCheckerWidget.sliver({
    super.key,
    required Widget sliver,
    this.guestWidget = const SliverToBoxAdapter(),
    this.enableGesture = false,
    this.replaceWithDefaultGuestWidget = false,
  }) : isSliver = true,
       child = sliver;

  final Widget child;
  final Widget guestWidget;
  final bool enableGesture;
  final bool replaceWithDefaultGuestWidget;
  final bool isSliver;

  static bool isGuest(BuildContext context) => AppAuthenticationBloc.of(context).state is GuestState;

  static void check(BuildContext context, {void Function()? caseGuest, void Function()? elseCase}) {
    if (AppAuthenticationBloc.of(context).state is GuestState) {
      if (caseGuest != null) {
        caseGuest();
      }
    } else {
      if (elseCase != null) {
        elseCase();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppAuthenticationBloc, AppAuthenticationState>(
      builder: (context, state) {
        if (state is GuestState) {
          if (enableGesture && replaceWithDefaultGuestWidget == false) {
            final Widget widget = GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                GuestBottomSheet.show(context);
              },
              child: AbsorbPointer(child: child),
            );

            return widget;
          } else if (replaceWithDefaultGuestWidget) {
            final Widget widget = Center(
              child: Padding(padding: EdgeInsets.all(24.0).copyWith(top: 100.0), child: GuestBottomSheet()),
            );
            if (isSliver) {
              return SliverToBoxAdapter(child: widget);
            }
            return widget;
          } else {
            return guestWidget;
          }
        } else {
          return child;
        }
      },
    );
  }
}
