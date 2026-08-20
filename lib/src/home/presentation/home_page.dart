import 'package:flutter/material.dart';

import '../../../../material/auth_states/logged_user_checker_widget.dart';
import '../../../core/config/router/app_routes.dart';
import '../../../core/core.dart';
import '../../../material/media/app_image.dart';
import '../../../material/media/svg_icon.dart';
import '../../notifications/presentation/widgets/notification_button.dart';

part 'widgets/home_app_bar.dart';
part 'widgets/home_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            _HomeAppBar(),
            Expanded(child: _HomeBody()),
          ],
        ),
      ),
    );
  }
}
