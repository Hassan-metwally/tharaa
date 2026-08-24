part of '../orders_page.dart';

const Color _kSearchFill = Color(0xFFF7F8FA);
const Color _kSearchHint = Color(0xFF8B9BB2);
const double _kSearchRowHeight = 50;

class _OrdersSearchRow extends StatelessWidget {
  const _OrdersSearchRow({
    required this.controller,
    required this.onChanged,
    required this.isDateSelected,
    required this.onDateTap,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final bool isDateSelected;
  final VoidCallback onDateTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _OrdersSearchField(controller: controller, onChanged: onChanged),
        ),
        const SizedBox(width: Dimensions.p8),
        _OrdersCalendarFilterButton(isSelected: isDateSelected, onTap: onDateTap),
      ],
    );
  }
}

class _OrdersSearchField extends StatelessWidget {
  const _OrdersSearchField({required this.controller, required this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  static final OutlineInputBorder _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.r16),
    borderSide: BorderSide.none,
  );

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      controller: controller,
      onChanged: onChanged,
      hint: appLocalizer.searchByOrderNumber,
      hintTextStyle: TextStyles.regular14.copyWith(color: _kSearchHint, height: 1),
      inputTextStyle: TextStyles.regular14.copyWith(color: AppColors.black900, height: 1),
      filled: true,
      fillColor: _kSearchFill,
      margin: EdgeInsets.zero,
      contentPadding: const EdgeInsets.symmetric(horizontal: Dimensions.p16, vertical: Dimensions.p16),
      enabledBorder: _border,
      focusedBorder: _border,
      disabledBorder: _border,
      errorBorder: _border,
      focusedErrorBorder: _border,
      prefixIcon: (_) => AppSvgIcon(path: AppIcons.searchStatus, width: Dimensions.ic18, height: Dimensions.ic18, color: _kSearchHint),
    );
  }
}

class _OrdersCalendarFilterButton extends StatelessWidget {
  const _OrdersCalendarFilterButton({required this.isSelected, required this.onTap});

  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: _kSearchRowHeight,
        height: _kSearchRowHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(Dimensions.r16),
          border: isSelected ? Border.all(color: AppColors.black900, width: 1.5) : null,
        ),
        child: AppSvgIcon(path: AppIcons.calendar, width: Dimensions.ic24, height: Dimensions.ic24, color: AppColors.white),
      ),
    );
  }
}
