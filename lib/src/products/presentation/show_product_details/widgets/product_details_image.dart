part of '../show_product_details_page.dart';

class _ProductDetailsImage extends StatelessWidget {
  const _ProductDetailsImage({required this.product});

  final ProductDetailsEntity product;

  bool get _hasOffer {
    final num? offerPrice = product.offerPrice;
    return offerPrice != null && offerPrice < product.price;
  }

  bool get _showOfferTimer {
    final DateTime? endDate = product.offerEndDate;
    return _hasOffer && endDate != null && endDate.isAfter(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _kImageHeight,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: AppImage.rounded(
              path: product.image.path,
              height: _kImageHeight,
              width: double.infinity,
              radius: Dimensions.r16,
              fit: BoxFit.cover,
              bgColor: AppColors.white,
            ),
          ),
          if (_showOfferTimer)
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.p12),
                child: _OfferCountdownBadge(endDate: product.offerEndDate!),
              ),
            ),
        ],
      ),
    );
  }
}

class _OfferCountdownBadge extends StatefulWidget {
  const _OfferCountdownBadge({required this.endDate});

  final DateTime endDate;

  @override
  State<_OfferCountdownBadge> createState() => _OfferCountdownBadgeState();
}

class _OfferCountdownBadgeState extends State<_OfferCountdownBadge> {
  Timer? _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _tick();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _tick() {
    final Duration remaining = widget.endDate.difference(DateTime.now());
    if (!mounted) return;
    setState(() => _remaining = remaining.isNegative ? Duration.zero : remaining);
    if (remaining.isNegative || remaining == Duration.zero) {
      _timer?.cancel();
    }
  }

  String get _formattedRemaining {
    final int days = _remaining.inDays;
    final int hours = _remaining.inHours.remainder(24);
    final int minutes = _remaining.inMinutes.remainder(60);
    final int seconds = _remaining.inSeconds.remainder(60);
    String two(int value) => value.toString().padLeft(2, '0');
    return '${two(days)}:${two(hours)}:${two(minutes)}:${two(seconds)}';
  }

  @override
  Widget build(BuildContext context) {
    if (_remaining == Duration.zero) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(Dimensions.p4),
      decoration: BoxDecoration(color: AppColors.warning50, borderRadius: BorderRadius.circular(Dimensions.r8)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppSvgIcon(path: AppIcons.timer, width: _kOfferTimerIconSize, height: _kOfferTimerIconSize),
          const SizedBox(width: 2),
          Text(appLocalizer.offerEndsIn, style: TextStyles.regular12.copyWith(color: AppColors.warning500, height: 1)),
          const SizedBox(width: 2),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              _formattedRemaining,
              style: TextStyles.semiBold12.copyWith(color: AppColors.warning500, height: 1, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
