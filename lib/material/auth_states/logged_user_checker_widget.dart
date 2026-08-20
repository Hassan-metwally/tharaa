import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';

class LoggedUserCheckerWidget extends StatelessWidget {
  const LoggedUserCheckerWidget({super.key, required this.loggedBuilder, this.guestWidget});

  final Widget Function(CacheUserEntity user)? loggedBuilder;
  final Widget? guestWidget;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppAuthenticationBloc, AppAuthenticationState>(
      builder: (context, state) {
        if (state is GuestState) {
          return guestWidget ?? const SizedBox();
        } else if (state is AuthAuthenticatedState) {
          if (loggedBuilder != null) {
            return loggedBuilder!(state.user);
          }
        }
        return const SizedBox();
      },
    );
  }
}
