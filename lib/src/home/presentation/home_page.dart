import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/router/app_routes.dart';
import '../../../core/core.dart';
import '../../../core/di/di.dart';
import '../../../material/media/svg_icon.dart';
import '../../ads/presentation/ads/ads_widget.dart';
import '../../categories/presentation/main_categories/main_categories_home_widget.dart';
import '../../products/presentation/products/most_requested_products_widget.dart';
import '../../products/presentation/products/offers_products_widget.dart';
import '../../products/presentation/products/search_products_page.dart';
import '../../notifications/presentation/notifications_cubit.dart';
import '../../notifications/presentation/notifications_page.dart';

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
            const _HomeAppBar(),
            const Expanded(child: _HomeBody()),
          ],
        ),
      ),
    );
  }
}
