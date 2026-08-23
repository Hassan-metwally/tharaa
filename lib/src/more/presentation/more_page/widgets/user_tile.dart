part of '../more_page.dart';

class _MoreSection extends StatelessWidget {
  const _MoreSection({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 28,
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(title, style: TextStyles.semiBold16.copyWith(color: AppColors.black900, height: 1)),
          ),
        ),
        const SizedBox(height: Dimensions.p12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(Dimensions.p16),
          decoration: BoxDecoration(color: _kMoreSectionFill, borderRadius: BorderRadius.circular(Dimensions.r16)),
          child: Column(spacing: Dimensions.p16, children: children),
        ),
      ],
    );
  }
}

class _MoreTile extends StatelessWidget {
  const _MoreTile({required this.icon, required this.text, required this.onTap, this.trailingText, this.showDivider = true});

  final String icon;
  final String text;
  final String? trailingText;
  final VoidCallback onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(bottom: showDivider ? Dimensions.p12 : 0),
        decoration: showDivider
            ? const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white)),
              )
            : null,
        child: Row(
          children: [
            AppSvgIcon(path: icon, size: Dimensions.ic24),
            const SizedBox(width: Dimensions.p4),
            Expanded(
              child: Text(text, style: TextStyles.medium14.copyWith(color: AppColors.black900, height: 1)),
            ),
            if (trailingText != null) ...[
              const SizedBox(width: Dimensions.p4),
              Text(trailingText!, style: TextStyles.regular12.copyWith(color: AppColors.mutedText, height: 1)),
            ],
            const SizedBox(width: Dimensions.p4),
            const _TileArrowButton(),
          ],
        ),
      ),
    );
  }
}

class _TileArrowButton extends StatelessWidget {
  const _TileArrowButton();

  @override
  Widget build(BuildContext context) {
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: Transform.rotate(
        angle: isRtl ? 34.84 * math.pi / 180 : math.pi - (34.84 * math.pi / 180),
        child: AppSvgIcon(path: AppIcons.arrowUpRight, width: Dimensions.ic16, height: Dimensions.ic16),
      ),
    );
  }
}
