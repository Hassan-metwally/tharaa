// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../../core/utils/picker/media_picker_bottomsheet.dart';
import '../media/app_image.dart';
import '../media/svg_icon.dart';
import '../widgets/widget_ripple.dart';
import 'validator_field/validator_field.dart';

class MediaFieldWidget extends StatelessWidget {
  final String label;
  final String? icon;
  final String hint;
  final String validationMessage;

  const MediaFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    this.icon,
    required this.hint,
    required this.validationMessage,
  });

  final ValidatorFieldController<AttachmentEntity?> controller;

  @override
  Widget build(BuildContext context) {
    return ValidatorField<AttachmentEntity?>(
      controller: controller,
      validator: (value) {
        if (value == null || value.path == '') {
          return validationMessage;
        }
        return null;
      },
      build: (context, errorMessage, hasError, value) {
        final errorBorderColor = Theme.of(context).inputDecorationTheme.errorBorder?.borderSide.color;
        final themeBorderColor = Theme.of(context).inputDecorationTheme.enabledBorder?.borderSide.color;
        final Color borderColor = (hasError ? errorBorderColor : themeBorderColor) ?? AppColors.enabledBorderColor;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(label, style: TextStyles.regular14.copyWith(color: AppColors.black900)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: borderColor),
                    ),
                    child: Builder(
                      builder: (context) {
                        if (value != null && value.path.isNotEmpty) {
                          return AppImage(path: value.path, width: double.infinity);
                        } else {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppSvgIcon(path: icon ?? ""),
                              const SizedBox(height: 8),
                              Text(hint, style: TextStyles.regular12.copyWith(color: AppColors.black400)),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ),
                if (errorMessage?.isNotEmpty == true)
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(errorMessage ?? '', style: Theme.of(context).inputDecorationTheme.errorStyle),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class MultiMediaField extends StatelessWidget {
  final String label;
  final String? bodyText;
  final String? bodySubText;
  final String? icon;
  final String? validationMessage;
  final bool hasRequiredSymbol;
  final bool canPickPdf;
  final bool canPickImage;
  final bool canPickVideo;
  final Widget? labelIcon;
  final double minHeight;
  final double? iconSize;
  final Color? iconColor;
  final Function(List<AttachmentEntity>?)? onSelect;
  final bool isRequired;

  const MultiMediaField({
    super.key,
    required this.controller,
    required this.label,
    this.bodyText,
    this.bodySubText,
    this.icon,
    this.validationMessage,
    this.hasRequiredSymbol = false,
    this.canPickPdf = false,
    this.canPickImage = true,
    this.canPickVideo = false,
    this.minHeight = 115,
    this.labelIcon,
    this.iconSize,
    this.iconColor,
    this.onSelect,
    this.isRequired = false,
  });
  final ValidatorFieldController<List<AttachmentEntity>?> controller;

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).inputDecorationTheme.labelStyle;
    return ValidatorField<List<AttachmentEntity>?>(
      controller: controller,
      validator: (value) {
        if (isRequired && (value == null || value.isEmpty)) {
          return appLocalizer.fieldRequired;
        }
        if (value != null && value.length > 5) {
          return appLocalizer.imageUploadConstraints;
        }
        return null;
      },
      build: (context, errorMessage, hasError, value) {
        void onTap() {
          MediaPickerBottomSheet.show(
            context,
            canPickPdf: canPickPdf,
            canPickImage: canPickImage,
            canPickVideo: canPickVideo,
            canPickMultiImages: true,
            onMultiMediaPicked: (media) {
              controller.setValue([...value ?? [], ...media]);
              controller.validate();
              onSelect?.call(value);
            },
            onMediaPicked: (media) {
              controller.setValue([...value ?? [], media]);
              controller.validate();
              onSelect?.call(value);
            },
          );
        }

        final errorBorderColor = Theme.of(context).inputDecorationTheme.errorBorder?.borderSide.color;
        final themeBorderColor = Theme.of(context).inputDecorationTheme.enabledBorder?.borderSide.color;
        final Color borderColor = (hasError ? errorBorderColor : themeBorderColor) ?? AppColors.enabledBorderColor;
        return AnimatedSize(
          duration: Durations.medium3,
          reverseDuration: Durations.medium3,
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (label.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    spacing: 4,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ?labelIcon,
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: label,
                            style: labelStyle,
                            children: [
                              if (hasRequiredSymbol)
                                TextSpan(
                                  text: "\t*",
                                  style: labelStyle?.copyWith(color: AppColors.error),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: AppColors.cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: borderColor),
                  ),
                  constraints: BoxConstraints(minHeight: minHeight, minWidth: MediaQuery.of(context).size.width),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // if (value != null && value.isNotEmpty)
                      //   Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(top: 10),
                      //     child: Text(label, style: TextStyles.medium14.copyWith(color: AppColors.black400)),
                      //   ),
                      Builder(
                        builder: (context) {
                          if (value != null && value.isNotEmpty) {
                            final List<Widget> widgets = [];
                            for (var file in value) {
                              final String icon;
                              final IoFileUtils fileUtils = IoFileUtils(file.path);
                              switch (fileUtils.getAttachmentType) {
                                case AttachmentTypeEnum.document:
                                // icon = AppIcons.fileIc;
                                case AttachmentTypeEnum.gif:
                                case AttachmentTypeEnum.audio:
                                case AttachmentTypeEnum.unKnown:
                                // icon = AppIcons.fileIc;
                                case AttachmentTypeEnum.video:
                                // icon = AppIcons.videoIc;
                                case AttachmentTypeEnum.photo:
                                  // icon = AppIcons.imageIc;
                                  icon = '';
                              }
                              widgets.add(
                                Stack(
                                  children: [
                                    AppImage.rounded(path: file.path, height: 70, width: 70, fit: BoxFit.cover, radius: 10),
                                    PositionedDirectional(
                                      top: 5,
                                      end: 5,
                                      child: WidgetRipple(
                                        onClick: () {
                                          // onChange(newMedia);
                                          controller.clearItem(file.name);
                                          controller.validate();
                                          onSelect?.call(value);
                                        },
                                        radius: 8,
                                        contentPadding: const EdgeInsets.all(3),
                                        backgroundColor: Colors.white.withOpacityPercent(20),
                                        child: Icon(Icons.delete, size: 18, color: AppColors.error),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10.0),
                              child: SizedBox(
                                height: 133,
                                child: GridView.builder(
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 4,
                                    crossAxisSpacing: 8,
                                  ),
                                  itemBuilder: (context, index) {
                                    if (index == widgets.length) {
                                      return GestureDetector(
                                        onTap: onTap,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(color: AppColors.enabledBorderColor),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: const Icon(Icons.add),
                                        ),
                                      );
                                    }
                                    return widgets[index];
                                  },
                                  itemCount: widgets.length + 1,
                                ),
                              ),
                            );
                          } else {
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: onTap,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 8),
                                    AppSvgIcon(path: icon ?? ""),
                                    const SizedBox(height: 10),
                                    Text(
                                      bodyText ?? appLocalizer.clickToUploadImages,
                                      style: TextStyles.regular12.copyWith(color: AppColors.black600),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      bodySubText ?? appLocalizer.imageUploadConstraints,
                                      style: TextStyles.regular10.copyWith(color: AppColors.black400),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              if (errorMessage?.isNotEmpty == true)
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 6.0, start: 10),
                  child: Text(errorMessage ?? '', style: Theme.of(context).inputDecorationTheme.errorStyle),
                ),
            ],
          ),
        );
      },
    );
  }
}
