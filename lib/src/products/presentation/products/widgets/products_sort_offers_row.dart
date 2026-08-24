import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../../../material/media/svg_icon.dart';
import 'products_page_mode.dart';

const Color _kSwitchOff = Color(0xFF9EABBF);
const Color _kMenuHighlight = Color(0xFFF0F4FA);

class ProductsSortOffersRow extends StatefulWidget {
  const ProductsSortOffersRow({
    super.key,
    required this.mode,
    required this.sortOption,
    required this.offersOnly,
    required this.onSortChanged,
    required this.onOffersOnlyChanged,
  });

  final ProductsPageMode mode;
  final ProductsSortOption sortOption;
  final bool offersOnly;
  final ValueChanged<ProductsSortOption> onSortChanged;
  final ValueChanged<bool> onOffersOnlyChanged;

  @override
  State<ProductsSortOffersRow> createState() => _ProductsSortOffersRowState();
}

class _ProductsSortOffersRowState extends State<ProductsSortOffersRow> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  List<ProductsSortOption> get _options {
    if (widget.mode == ProductsPageMode.mostRequested) {
      return const [ProductsSortOption.priceHighToLow, ProductsSortOption.priceLowToHigh];
    }
    return const [
      ProductsSortOption.mostRequested,
      ProductsSortOption.priceHighToLow,
      ProductsSortOption.priceLowToHigh,
    ];
  }

  String _sortLabel() {
    if (widget.mode == ProductsPageMode.mostRequested) {
      final String value = widget.sortOption == ProductsSortOption.priceLowToHigh
          ? appLocalizer.fromLowToHigh
          : appLocalizer.fromHighToLow;
      return '${appLocalizer.sort}: $value';
    }
    switch (widget.sortOption) {
      case ProductsSortOption.mostRequested:
        return '${appLocalizer.sort}: ${appLocalizer.mostRequested}';
      case ProductsSortOption.priceHighToLow:
        return '${appLocalizer.sort}: ${appLocalizer.priceHighToLow}';
      case ProductsSortOption.priceLowToHigh:
        return '${appLocalizer.sort}: ${appLocalizer.priceLowToHigh}';
    }
  }

  String _optionLabel(ProductsSortOption option) {
    if (widget.mode == ProductsPageMode.mostRequested) {
      return option == ProductsSortOption.priceLowToHigh ? appLocalizer.fromLowToHigh : appLocalizer.fromHighToLow;
    }
    switch (option) {
      case ProductsSortOption.mostRequested:
        return appLocalizer.mostRequested;
      case ProductsSortOption.priceHighToLow:
        return appLocalizer.priceHighToLow;
      case ProductsSortOption.priceLowToHigh:
        return appLocalizer.priceLowToHigh;
    }
  }

  void _toggleMenu() {
    if (_overlayEntry != null) {
      _removeMenu();
      return;
    }
    _overlayEntry = OverlayEntry(
      builder: (context) {
        final bool isRtl = Directionality.of(context) == TextDirection.rtl;
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _removeMenu,
                child: const SizedBox.expand(),
              ),
            ),
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              targetAnchor: isRtl ? Alignment.bottomRight : Alignment.bottomLeft,
              followerAnchor: isRtl ? Alignment.topRight : Alignment.topLeft,
              offset: const Offset(0, 8),
              child: Material(
                color: Colors.transparent,
                child: _SortMenu(
                  options: _options,
                  selected: widget.sortOption,
                  labelOf: _optionLabel,
                  onSelected: (option) {
                    widget.onSortChanged(option);
                    _removeMenu();
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
    Overlay.of(context).insert(_overlayEntry!);
    setState(() {});
  }

  void _removeMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      child: Row(
        children: [
          CompositedTransformTarget(
            link: _layerLink,
            child: GestureDetector(
              onTap: _toggleMenu,
              behavior: HitTestBehavior.opaque,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppSvgIcon(path: AppIcons.arrowDown, width: Dimensions.ic24, height: Dimensions.ic24),
                  Text(
                    _sortLabel(),
                    style: TextStyles.semiBold16.copyWith(color: AppColors.black900, height: 1, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => widget.onOffersOnlyChanged(!widget.offersOnly),
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(appLocalizer.offersOnly, style: TextStyles.medium14.copyWith(color: AppColors.mutedText, height: 1)),
                const SizedBox(width: Dimensions.p4),
                _OffersSwitch(value: widget.offersOnly),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OffersSwitch extends StatelessWidget {
  const _OffersSwitch({required this.value});

  final bool value;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 40,
      height: 20,
      padding: const EdgeInsets.all(2),
      alignment: value ? AlignmentDirectional.centerStart : AlignmentDirectional.centerEnd,
      decoration: BoxDecoration(
        color: value ? AppColors.primary : _kSwitchOff,
        borderRadius: BorderRadius.circular(41),
      ),
      child: Container(
        width: 16,
        height: 16,
        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      ),
    );
  }
}

class _SortMenu extends StatelessWidget {
  const _SortMenu({required this.options, required this.selected, required this.labelOf, required this.onSelected});

  final List<ProductsSortOption> options;
  final ProductsSortOption selected;
  final String Function(ProductsSortOption option) labelOf;
  final ValueChanged<ProductsSortOption> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 180),
      padding: const EdgeInsets.all(Dimensions.p8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(Dimensions.r12),
        boxShadow: [BoxShadow(color: AppColors.black.withOpacityPercent(10), blurRadius: 16, offset: const Offset(0, 4))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final option in options)
            GestureDetector(
              onTap: () => onSelected(option),
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.p8, vertical: Dimensions.p8),
                decoration: BoxDecoration(
                  color: option == selected ? _kMenuHighlight : Colors.transparent,
                  borderRadius: BorderRadius.circular(Dimensions.r8),
                ),
                child: Text(
                  labelOf(option),
                  style: TextStyles.medium14.copyWith(color: AppColors.mutedText, height: 1),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
