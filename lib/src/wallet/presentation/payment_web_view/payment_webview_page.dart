import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../../core/core.dart';
import '../../../../material/app_fail_widget.dart';
import '../../../../material/app_loading_widget.dart';
import '../../../../material/spin_kit_loading_widget.dart';
import 'payment_webview_cubit.dart';

String get _kSuccessInvoiceUrl => "paymob/callback";

class PaymentWebViewPage extends StatelessWidget {
  const PaymentWebViewPage({super.key, required this.paymentUrl, this.onSuccess, this.onFail});
  final String paymentUrl;
  final void Function()? onSuccess;
  final void Function()? onFail;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymanentWebViewCubit(),
      child: _PaymentWebViewPageBody(paymentUrl: paymentUrl, onFail: onFail, onSuccess: onSuccess),
    );
  }
}

class _PaymentWebViewPageBody extends StatefulWidget {
  const _PaymentWebViewPageBody({required this.paymentUrl, this.onSuccess, this.onFail});
  final String paymentUrl;
  final void Function()? onSuccess;
  final void Function()? onFail;

  @override
  State<_PaymentWebViewPageBody> createState() => _PaymentWebViewPageState();
}

class _PaymentWebViewPageState extends State<_PaymentWebViewPageBody> {
  bool _isLoading = true;
  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymanentWebViewCubit, PaymanentWebViewState>(
      listener: (context, state) {
        if (state.isLoading) {
          AppFailWidget.removeOverlay();
          AppLoadingWidget.overlay();
        } else if (state.isSuccess) {
          AppLoadingWidget.removeOverlay();
          AppFailWidget.removeOverlay();
          final bool isPaid = state.data ?? false;
          Navigator.pop(context);
          if (isPaid) {
            widget.onSuccess?.call();
          } else {
            widget.onFail?.call();
          }
          // widget.onSuccess?.call();
        } else if (state.isFailure) {
          widget.onFail?.call();
          AppLoadingWidget.removeOverlay();
          // AppFailWidget.overlay(context.read<PaymanentWebViewCubit>().getPaymentStatus);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(appLocalizer.payment)),
        body: Center(
          child: AnimatedCrossFade(
            duration: Durations.medium1,
            crossFadeState: _isLoading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            firstChild: const Center(child: SpinKitLoadingWidget.medium()),
            secondChild: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri(widget.paymentUrl)),
                onLoadStop: (controller, url) {
                  setState(() {
                    _isLoading = false;
                  });
                },
                onLoadStart: (controller, url) {
                  setState(() {
                    _isLoading = true;
                  });
                },
                initialSettings: InAppWebViewSettings(
                  underPageBackgroundColor: AppColors.backgroundColor,
                  useShouldOverrideUrlLoading: true,
                  mediaPlaybackRequiresUserGesture: false,
                  allowsInlineMediaPlayback: true,
                  allowsAirPlayForMediaPlayback: false,
                  cacheEnabled: false,
                ),
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  final String url = navigationAction.request.url.toString();
                  final bool isPaymentFinished = url.contains(_kSuccessInvoiceUrl);
                  final uri = Uri.tryParse(url);
                  if (isPaymentFinished && uri != null) {
                    context.read<PaymanentWebViewCubit>().getPaymentStatus(url: url);
                    return NavigationActionPolicy.CANCEL;
                  }
                  debugPrint("Payment URL =====>> :::  $url  :::");
                  return NavigationActionPolicy.ALLOW;
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
