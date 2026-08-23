part of '../otp_page.dart';

class _OtpTimerRow extends StatelessWidget {
  const _OtpTimerRow({required this.timerValue});

  final ResendOtpNotifierValue timerValue;

  @override
  Widget build(BuildContext context) {
    final bool isEnded = timerValue.isEnded;
    final Color timerColor = isEnded ? _kDescription : AppColors.black900;
    final double progress = isEnded ? 0 : (timerValue.timeRemainingInSeconds / 60).clamp(0.0, 1.0);

    return Row(
      children: [
        Expanded(
          child: Text(
            appLocalizer.resendCodeMessage,
            textAlign: TextAlign.start,
            style: TextStyles.regular14.copyWith(color: _kDescription, height: 1),
          ),
        ),
        const SizedBox(width: 12),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 12,
                height: 12,
                child: CircularProgressIndicator(
                  value: isEnded ? 0 : progress,
                  strokeWidth: 1.2,
                  color: AppColors.primary500,
                  backgroundColor: isEnded ? _kDescription : _kLightGray,
                  strokeCap: StrokeCap.round,
                ),
              ),
              const SizedBox(width: 8),
              Text(timerValue.timerText, style: TextStyles.regular14.copyWith(color: timerColor, height: 1)),
            ],
          ),
        ),
      ],
    );
  }
}

class _ResendCodeButton extends StatelessWidget {
  const _ResendCodeButton({required this.isEnabled, required this.isLoading, required this.onPressed});

  final bool isEnabled;
  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    const double radius = 16;
    final bool canTap = isEnabled && !isLoading;
    final Color background = canTap ? _kTonalFill : _kLightGray;
    final Color foreground = canTap ? AppColors.primary500 : _kDisabledTonal;

    return Material(
      color: background,
      shadowColor: Colors.transparent,
      borderRadius: BorderRadius.circular(radius),
      child: InkWell(
        onTap: canTap ? onPressed : null,
        borderRadius: BorderRadius.circular(radius),
        child: SizedBox(
          height: 52,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                SpinKitLoadingWidget(size: 14, color: foreground)
              else
                SizedBox(
                  width: 18,
                  height: 18,
                  child: AppSvgIcon(path: AppIcons.rotateRight, color: foreground, width: 18, height: 18),
                ),
              const SizedBox(width: 4),
              Text(
                appLocalizer.resendVersionCodeOtp,
                style: TextStyles.semiBold18.copyWith(color: foreground, height: 1, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
