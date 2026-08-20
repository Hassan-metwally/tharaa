import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../../core/core.dart';
import '../../../../../material/app_fail_widget.dart';
import '../../../../../material/spin_kit_loading_widget.dart';
import '../../../domain/entity/menu/static_page_type_enum.dart';
import 'static_page_cubit.dart';

class StaticPage extends StatelessWidget {
  const StaticPage({super.key, required this.pageType});

  final StaticPageTypeEnum pageType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(pageType.title),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: AppColors.appbarBorderColor, // border color
            height: 1.0,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => StaticPageCubit(type: pageType)..getData(),
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
    );
  }
}

class _StaticPageBody extends StatelessWidget {
  const _StaticPageBody({required this.data});
  final String data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacityPercent(2), blurRadius: 8)],
        ),
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(minWidth: double.infinity, minHeight: 300),
        child: Html(
          data: data,
          style: {
            "body": Style(color: AppColors.primary700, fontSize: FontSize(14), fontWeight: FontWeight.w300, fontFamily: AppFonts.mainFont),
          },
        ),
      ),
    );
  }
}
