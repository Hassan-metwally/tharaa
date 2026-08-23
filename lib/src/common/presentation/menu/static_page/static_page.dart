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
        elevation: 0,
        scrolledUnderElevation: 0,
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
    final double bottomInset = MediaQuery.paddingOf(context).bottom;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(Dimensions.p16, Dimensions.p24, Dimensions.p16, bottomInset > 0 ? bottomInset : Dimensions.p24),
      child: Html(data: data, style: _htmlStyles),
    );
  }

  Map<String, Style> get _htmlStyles {
    final Style bodyStyle = Style(
      color: AppColors.mutedText,
      fontSize: FontSize(12),
      fontWeight: FontWeight.w400,
      fontFamily: AppFonts.mainFont,
      lineHeight: LineHeight.number(1.6),
      textAlign: TextAlign.start,
      margin: Margins.zero,
      padding: HtmlPaddings.zero,
    );

    final Style headingStyle = Style(
      color: AppColors.black900,
      fontSize: FontSize(14),
      fontWeight: FontWeight.w500,
      fontFamily: AppFonts.mainFont,
      lineHeight: LineHeight.number(1.4),
      textAlign: TextAlign.start,
      margin: Margins.only(top: 16, bottom: 8),
      padding: HtmlPaddings.zero,
    );

    return {
      'html': bodyStyle,
      'body': bodyStyle,
      'div': bodyStyle,
      'span': bodyStyle,
      'li': bodyStyle,
      'p': bodyStyle.copyWith(margin: Margins.only(bottom: 12)),
      'h1': headingStyle,
      'h2': headingStyle,
      'h3': headingStyle,
      'h4': headingStyle,
      'h5': headingStyle,
      'h6': headingStyle,
      'strong': headingStyle.copyWith(display: Display.inline, margin: Margins.zero),
      'b': headingStyle.copyWith(display: Display.inline, margin: Margins.zero),
    };
  }
}
