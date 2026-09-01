part of '../coupons_page.dart';

const Color _kCouponBodyFill = Color(0xFFF7F8FA);
const Color _kUnusedBadgeFill = Color(0xFFE9F3FD);
const Color _kUnusedBadgeText = Color(0xFF3B82F6);
const Color _kMutedCopy = Color(0xFF9EABBF);
const double _kBannerWidth = 54;
const double _kCopyIconSize = 14;

const List<(Color, Color)> _kCouponAccents = [
  (Color(0xFFD094DA), Color(0xFF93C4FC)),
  (Color(0xFFFFBB98), Color(0xFFFF7F95)),
  (Color(0xFF46A2F7), Color(0xFF56F1CD)),
  (Color(0xFF64D49C), Color(0xFFE3B266)),
];

class _CouponCard extends StatefulWidget {
  const _CouponCard({required this.entity, required this.index});

  final CouponEntity entity;
  final int index;

  @override
  State<_CouponCard> createState() => _CouponCardState();
}

class _CouponCardState extends State<_CouponCard> {
  bool _copied = false;
  Timer? _copiedTimer;

  CouponEntity get _entity => widget.entity;

  (Color, Color) get _accent => _kCouponAccents[widget.index % _kCouponAccents.length];

  bool get _isAccentCopy => _copied || _entity.status == CouponStatus.unused;

  @override
  void dispose() {
    _copiedTimer?.cancel();
    super.dispose();
  }

  Future<void> _copyCode() async {
    final String value = _entity.code.isNotEmpty ? _entity.code : _entity.name;
    if (value.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: value));
    if (!mounted) return;
    setState(() => _copied = true);
    _copiedTimer?.cancel();
    _copiedTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _copied = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // AppRouter.pushNamed('', arguments: ShowCouponDetailsPage(id: entity.id));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimensions.r16),
        child: ColoredBox(
          color: _kCouponBodyFill,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _CouponBanner(label: appLocalizer.discountCouponBanner, start: _accent.$1, end: _accent.$2),
                Expanded(child: _buildBody()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.p12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _entity.name ,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.medium12.copyWith(color: AppColors.primary, height: 1),
                ),
              ),
              const SizedBox(width: Dimensions.p8),
              _CouponStatusBadge(status: _entity.status),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            _entity.discountLabel,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.semiBold24.copyWith(color: AppColors.black900, fontSize: 26, height: 1, fontWeight: FontWeight.w600),
          ),
          if (_entity.validFrom != null && _entity.validTo != null) ...[
            const SizedBox(height: 2),
            Text(
              appLocalizer.couponValidFromTo(_entity.validFrom!.DDMMYYYY_EN, _entity.validTo!.DDMMYYYY_EN),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.medium12.copyWith(color: AppColors.mutedText.withOpacityPercent(90), height: 1),
            ),
          ],
          const SizedBox(height: 2),
          Row(
            children: [
              Expanded(
                child: Text(
                  appLocalizer.couponMinOrder,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.medium12.copyWith(color: AppColors.mutedText.withOpacityPercent(90), height: 1),
                ),
              ),
              const SizedBox(width: 10),
              _MinOrderPrice(amount: _entity.minOrderAmount),
            ],
          ),
          const SizedBox(height: Dimensions.p12),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: _CopyCodeButton(
              label: _copied ? appLocalizer.couponCopied : (_entity.code.isNotEmpty ? _entity.code : _entity.name),
              accent: _isAccentCopy,
              gradient: LinearGradient(colors: [_accent.$1, _accent.$2]),
              onTap: _copyCode,
            ),
          ),
        ],
      ),
    );
  }
}

class _CouponBanner extends StatelessWidget {
  const _CouponBanner({required this.label, required this.start, required this.end});

  final String label;
  final Color start;
  final Color end;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _kBannerWidth,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [start, end]),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.p12, horizontal: 4),
              child: RotatedBox(
                quarterTurns: 1,
                child: Center(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    style: TextStyles.semiBold18.copyWith(color: AppColors.white, height: 1, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            const Align(
              alignment: AlignmentDirectional.centerEnd,
              child: CustomPaint(painter: _DashedLinePainter(), child: SizedBox(width: 1, height: double.infinity)),
            ),
          ],
        ),
      ),
    );
  }
}

class _CouponStatusBadge extends StatelessWidget {
  const _CouponStatusBadge({required this.status});

  final CouponStatus status;

  @override
  Widget build(BuildContext context) {
    final Color background;
    final Color foreground;
    final String label;
    switch (status) {
      case CouponStatus.unused:
        background = _kUnusedBadgeFill;
        foreground = _kUnusedBadgeText;
        label = appLocalizer.couponUnused;
      case CouponStatus.used:
        background = AppColors.success50;
        foreground = AppColors.success500;
        label = appLocalizer.couponUsed;
      case CouponStatus.expired:
        background = AppColors.white;
        foreground = AppColors.mutedText;
        label = appLocalizer.couponExpired;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.p8, vertical: Dimensions.p4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(80),
        border: Border.all(color: AppColors.white),
      ),
      child: Text(label, style: TextStyles.medium12.copyWith(color: foreground, height: 1)),
    );
  }
}

class _MinOrderPrice extends StatelessWidget {
  const _MinOrderPrice({required this.amount});

  final num amount;

  String get _amountLabel => amount % 1 == 0 ? amount.toInt().toString() : amount.toString();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(_amountLabel, style: TextStyles.medium18.copyWith(color: AppColors.primary, height: 1)),
        const SizedBox(width: 2),
        Icon(saudiRiyalSymbolIconData, size: Dimensions.ic16, color: AppColors.primary),
      ],
    );
  }
}

class _CopyCodeButton extends StatelessWidget {
  const _CopyCodeButton({required this.label, required this.accent, required this.gradient, required this.onTap});

  final String label;
  final bool accent;
  final Gradient gradient;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color contentColor = accent ? AppColors.white : _kMutedCopy;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.p12, vertical: Dimensions.p4),
        decoration: BoxDecoration(
          color: accent ? null : AppColors.white,
          gradient: accent ? gradient : null,
          borderRadius: BorderRadius.circular(80),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: TextStyles.medium14.copyWith(color: contentColor, height: 1)),
            const SizedBox(width: 2),
            AppSvgIcon(path: AppIcons.copy, width: _kCopyIconSize, height: _kCopyIconSize, color: contentColor),
          ],
        ),
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  const _DashedLinePainter();

  @override
  void paint(Canvas canvas, Size size) {
    const double dash = 4;
    const double gap = 3;
    final Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    double y = 0;
    final double x = size.width / 2;
    while (y < size.height) {
      final double endY = (y + dash).clamp(0, size.height);
      canvas.drawLine(Offset(x, y), Offset(x, endY), paint);
      y += dash + gap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
