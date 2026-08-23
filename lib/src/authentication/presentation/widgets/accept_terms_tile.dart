import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../material/inputs/validator_field/validator_field.dart';
import '../../../common/domain/entity/menu/static_page_type_enum.dart';
import '../../../common/presentation/menu/static_page/static_page_sheet.dart';

const Color _kUnchecked = Color(0xFF8B9BB2);

class AcceptTermsAndConditionsWidget extends StatelessWidget {
  const AcceptTermsAndConditionsWidget({super.key, required this.controller, this.canOpenTermsSheet = true});
  final ValidatorFieldController<bool> controller;
  final bool canOpenTermsSheet;

  @override
  Widget build(BuildContext context) {
    return ValidatorField<bool>(
      controller: controller,
      validator: (value) {
        if (value == false) {
          return appLocalizer.youMustAgreeTermsAndConditionsFirst;
        }
        return null;
      },
      build: (context, errorMessage, hasError, value) {
        return Container(
          padding: hasError ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8) : EdgeInsets.zero,
          decoration: BoxDecoration(color: hasError ? AppColors.red50 : Colors.transparent, borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: FittedBox(
                      child: Checkbox(
                        value: value,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                        side: const BorderSide(color: _kUnchecked, width: 1.6),
                        fillColor: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            return AppColors.primary500;
                          }
                          return Colors.transparent;
                        }),
                        onChanged: (value) {
                          controller.setValue(value ?? false);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: '${appLocalizer.agreeFor} ',
                        style: TextStyles.medium14.copyWith(color: _kUnchecked, height: 1.4),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                if (canOpenTermsSheet == false) return;
                                StaticPageSheet.show(
                                  context,
                                  isAccepted: value ?? false,
                                  pageType: StaticPageTypeEnum.termsAndConditions,
                                ).then((value) {
                                  if (value is bool) {
                                    controller.setValue(value);
                                  }
                                });
                              },
                            text: appLocalizer.termsAndConditions,
                            style: TextStyles.semiBold14.copyWith(color: AppColors.primary500, height: 1.4),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              if (errorMessage?.isNotEmpty == true)
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(errorMessage ?? '', style: Theme.of(context).inputDecorationTheme.errorStyle),
                ),
            ],
          ),
        );
      },
    );
  }
}
