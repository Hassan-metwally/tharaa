import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../../core/core.dart';
import '../../../../../material/app_fail_widget.dart';
import '../../../../../material/buttons/app_button.dart';
import '../../../../../material/inputs/validator_field/validator_field.dart';
import '../../../../../material/overlay/show_modal_bottom_sheet.dart';
import '../../../../../material/spin_kit_loading_widget.dart';
import '../../../domain/entity/menu/static_page_type_enum.dart';
import 'static_page_cubit.dart';

class StaticPageSheet extends StatefulWidget {
  const StaticPageSheet._({required this.isAccepted, required this.type});
  final bool isAccepted;
  final StaticPageTypeEnum type;

  @override
  State<StaticPageSheet> createState() => _StaticPageSheetState();

  static Future<bool?> show(BuildContext context, {required final StaticPageTypeEnum pageType, required final bool isAccepted}) async =>
      await showAppModalBottomSheet<bool?>(
        context: context,
        child: BlocProvider(
          create: (context) => StaticPageCubit(type: pageType)..getData(),
          child: StaticPageSheet._(type: pageType, isAccepted: isAccepted),
        ),
      );
}

class _StaticPageSheetState extends State<StaticPageSheet> {
  late final ValidatorFieldController<bool> termsController = ValidatorFieldController(initialValue: widget.isAccepted);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.type.title, style: TextStyles.regular20),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: AppColors.secondary50, borderRadius: BorderRadius.circular(16)),
          constraints: const BoxConstraints(minHeight: 200),
          child: BlocBuilder<StaticPageCubit, Async<String>>(
            builder: (context, state) {
              if (state.isSuccess) {
                return _StaticPageBody(data: state.data ?? '');
              } else if (state.isLoading) {
                return SpinKitLoadingWidget(color: AppColors.primary);
              } else if (state.isFailure) {
                return AppFailWidget(
                  onRetry: () {
                    StaticPageCubit.of(context).getData();
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ),
        BlocBuilder<StaticPageCubit, Async<String>>(
          builder: (context, state) {
            if (state.isSuccess) {
              return Padding(
                padding: const EdgeInsets.only(top: 56.0),
                child: AppButton(
                  text: appLocalizer.done,
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}

class _StaticPageBody extends StatelessWidget {
  const _StaticPageBody({required this.data});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Html(
      data: data,
      style: {
        "body": Style(color: AppColors.primary600, fontSize: FontSize(14), fontWeight: FontWeight.w300, fontFamily: AppFonts.mainFont),
      },
    );
  }
}
