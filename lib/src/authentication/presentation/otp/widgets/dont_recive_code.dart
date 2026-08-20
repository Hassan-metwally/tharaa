part of "../otp_page.dart";

class _DontReciveCodeWidget extends StatelessWidget {
  final bool isEnabled;
  final bool isLoading;
  final VoidCallback onResendPressed;
  const _DontReciveCodeWidget({
    required this.resendNotifier,
    required this.isEnabled,
    required this.isLoading,
    required this.onResendPressed,
  });

  final ResendOtpTimerNotifier resendNotifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      children: [
        GestureDetector(
          onTap: isEnabled && !isLoading ? onResendPressed : null,
          behavior: HitTestBehavior.opaque,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: appLocalizer.resendCodeMessage,
                        style: TextStyles.light12.copyWith(color: AppColors.black400),
                      ),
                      TextSpan(
                        text: "\t${appLocalizer.resendCode}",
                        style: isEnabled && !isLoading
                            ? TextStyles.medium12.copyWith(color: AppColors.primary)
                            : TextStyles.light12.copyWith(color: AppColors.black200),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              if (isLoading)
                Container(margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4), child: const SpinKitLoadingWidget(size: 10)),
            ],
          ),
        ),
        const SizedBox(height: 15),
        ValueListenableBuilder(
          valueListenable: resendNotifier,
          builder: (context, value, child) {
            if (value.isEnded) {
              return const SizedBox();
            }
            return Text(value.timerText, style: TextStyles.regular16.copyWith(color: AppColors.black));
          },
        ),
      ],
    );
  }
}
