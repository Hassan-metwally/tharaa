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

  static const double _avatarSize = 72;

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
        final Color errorBorderColor =
            Theme.of(context).inputDecorationTheme.errorBorder?.borderSide.color ?? AppColors.error;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                await MediaPickerBottomSheet.show(
                  context,
                  title: appLocalizer.editProfilePicture,
                  canDeleteImage: true,
                  onMediaPicked: (media) {
                    controller.setValue(media);
                    controller.validate();
                  },
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: _avatarSize,
                    width: _avatarSize,
                    clipBehavior: Clip.antiAlias,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFF7F8FA),
                      border: hasError ? Border.all(color: errorBorderColor) : null,
                    ),
                    child: Builder(
                      builder: (context) {
                        if (value != null && value.path.isNotEmpty) {
                          return AppImage.circle(path: value.path, fit: BoxFit.cover, dimension: _avatarSize);
                        }
                        return AppSvgIcon(path: AppIcons.profile, width: 32, height: 32);
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    appLocalizer.editPhoto,
                    textAlign: TextAlign.center,
                    style: TextStyles.semiBold12.copyWith(color: AppColors.primary, height: 1, fontWeight: FontWeight.w600),
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
