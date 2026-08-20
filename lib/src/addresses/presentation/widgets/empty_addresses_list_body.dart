import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../material/media/svg_icon.dart';

class EmptyAddressesListBody extends StatelessWidget {
  const EmptyAddressesListBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.7,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppSvgIcon(path: "", height: 40, width: 40),
              const SizedBox(height: 20),
              Text(appLocalizer.noAddressesYet, style: TextStyles.medium16.copyWith(color: AppColors.black500)),
            ],
          ),
        ),
      ),
    );
  }
}
