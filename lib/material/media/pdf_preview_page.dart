import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

import '../../core/core.dart';
import '../app_fail_widget.dart';
import '../spin_kit_loading_widget.dart';

class PdfPreviewPage extends StatefulWidget {
  final String path;

  const PdfPreviewPage({super.key, required this.path});

  static const String routeName = '/pdf_preview_page';

  static void open(String path) async {
    final context = appNavigatorKey.currentContext;

    if (context == null || context.mounted == false) {
      return;
    }
    await Navigator.of(context, rootNavigator: true).push(
      FadeTransitionRoute(
        settings: const RouteSettings(name: routeName),
        child: (context) => PdfPreviewPage(path: path),
      ),
    );
  }

  @override
  State<PdfPreviewPage> createState() => _PdfPreviewPageState();
}

class _PdfPreviewPageState extends State<PdfPreviewPage> {
  late final IoFileUtils _ioFileUtilsObj;

  IoFileTypeEnum get _getFileType => _ioFileUtilsObj.getIoFileType;

  late PdfControllerPinch pdfControllerPinch;

  @override
  void initState() {
    _ioFileUtilsObj = IoFileUtils(widget.path);
    pdfControllerPinch = PdfControllerPinch(document: _getDocument);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PdfViewPinch(
        controller: pdfControllerPinch,
        builders: PdfViewPinchBuilders<DefaultBuilderOptions>(
          options: const DefaultBuilderOptions(
            loaderSwitchDuration: Duration(microseconds: 1),
            transitionBuilder: _PdfWidget.transitionBuilder,
          ),
          documentLoaderBuilder: (_) => _loadingWiget,
          pageLoaderBuilder: (_) => _loadingWiget,
          errorBuilder: (_, error) {
            return AppFailWidget(
              onRetry: () {
                pdfControllerPinch.loadDocument(_getDocument);
              },
            );
          },
          builder: _PdfWidget.builder,
        ),
      ),
    );
  }

  Future<PdfDocument> get _getDocument async {
    switch (_getFileType) {
      case IoFileTypeEnum.asset:
        return PdfDocument.openAsset(widget.path);
      case IoFileTypeEnum.file:
        return PdfDocument.openFile(widget.path);
      case IoFileTypeEnum.network:
        final response = await Dio().get(widget.path, options: Options(responseType: ResponseType.bytes));
        final uint8ListData = Uint8List.fromList(response.data);
        return PdfDocument.openData(uint8ListData);
    }
  }

  Widget get _loadingWiget {
    return const SpinKitLoadingWidget.medium();
  }
}

class _PdfWidget {
  static Widget builder(
    BuildContext context,
    PdfViewPinchBuilders builders,
    PdfLoadingState state,
    WidgetBuilder loadedBuilder,
    PdfDocument? document,
    Exception? loadingError,
  ) {
    final Widget content = () {
      switch (state) {
        case PdfLoadingState.loading:
          return KeyedSubtree(
            key: const Key('pdfx.root.loading'),
            child: builders.documentLoaderBuilder?.call(context) ?? const SizedBox(),
          );
        case PdfLoadingState.error:
          return KeyedSubtree(
            key: const Key('pdfx.root.error'),
            child: builders.errorBuilder?.call(context, loadingError!) ?? Center(child: Text(loadingError.toString())),
          );
        case PdfLoadingState.success:
          return KeyedSubtree(key: Key('pdfx.root.success.${document!.id}'), child: loadedBuilder(context));
      }
    }();

    final defaultBuilder = builders as PdfViewPinchBuilders<DefaultBuilderOptions>;
    final options = defaultBuilder.options;

    return AnimatedSwitcher(duration: options.loaderSwitchDuration, transitionBuilder: options.transitionBuilder, child: content);
  }

  static Widget transitionBuilder(Widget child, Animation<double> animation) => FadeTransition(opacity: animation, child: child);
}
