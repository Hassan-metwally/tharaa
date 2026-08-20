import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../../core/utils/picker/media_picker_bottomsheet.dart';
import '../media/app_image.dart';
import '../media/svg_icon.dart';
import 'validator_field/validator_field.dart';

class ProfileAvatarWidget extends StatelessWidget {
  final String? validationMessage;
  const ProfileAvatarWidget({super.key, required this.controller, this.validationMessage});

  final ValidatorFieldController<AttachmentEntity?> controller;

  @override
  Widget build(BuildContext context) {
    return ValidatorField<AttachmentEntity?>(
      controller: controller,
      validator: (value) {
        if (value == null || value.path == '') {
          return validationMessage ?? appLocalizer.profileImageValidation;
        }
        return null;
      },
      build: (context, errorMessage, hasError, value) {
        final errorBorderColor = Theme.of(context).inputDecorationTheme.errorBorder?.borderSide.color;
        final themeBorderColor = Theme.of(context).inputDecorationTheme.enabledBorder?.borderSide.color;
        final Color borderColor = (hasError ? errorBorderColor : themeBorderColor) ?? AppColors.enabledBorderColor;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                await MediaPickerBottomSheet.show(
                  context,
                  onMediaPicked: (media) {
                    controller.setValue(media);

                    controller.validate();
                  },
                );
              },
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    clipBehavior: Clip.antiAlias,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.cardColor,
                      border: Border.all(color: borderColor),
                    ),
                    child: Builder(
                      builder: (context) {
                        if (value != null && value.path.isNotEmpty) {
                          return AppImage.circle(path: value.path, fit: BoxFit.cover, dimension: double.infinity);
                        } else {
                          return AppSvgIcon(path: "");
                        }
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.backgroundColor),
                    child: AppSvgIcon(path: ""),
                  ),
                ],
              ),
            ),
            if (errorMessage?.isNotEmpty == true)
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(errorMessage ?? '', style: Theme.of(context).inputDecorationTheme.errorStyle),
              ),
          ],
        );
      },
    );
  }
}
