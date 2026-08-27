import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../../../material/inputs/app_text_form_field.dart';
import '../../../../../material/media/svg_icon.dart';

const Color _kSearchFill = Color(0xFFF7F8FA);
const Color _kSearchHint = Color(0xFF8B9BB2);

class ProductsSearchField extends StatelessWidget {
  const ProductsSearchField({super.key, required this.controller, required this.onChanged, this.focusNode});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final FocusNode? focusNode;

  static final OutlineInputBorder _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.r16),
    borderSide: BorderSide.none,
  );

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      hint: appLocalizer.searchProductByName,
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
      prefixIcon:  (bool isFocused) => AppSvgIcon(path: AppIcons.searchStatus, width: Dimensions.ic18, height: Dimensions.ic18, color: _kSearchHint),
    );
  }
}
