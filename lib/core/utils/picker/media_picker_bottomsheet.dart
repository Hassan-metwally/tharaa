import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../material/media/svg_icon.dart';
import '../../../material/overlay/show_modal_bottom_sheet.dart';
import '../../core.dart';
import 'media_picker_utils.dart';

const Color _kOptionsBackground = Color(0xFFF7F8FA);
const Color _kSheetScrim = Color(0x4D000000);

class MediaPickerBottomSheet extends StatelessWidget {
  const MediaPickerBottomSheet({
    super.key,
    this.title,
    required this.canPickImage,
    required this.canPickVideo,
    required this.canPickMultiImages,
    required this.onMediaPicked,
    required this.onMultiMediaPicked,
    required this.canPickPdf,
    required this.canPickGif,
    this.canDeleteImage = false,
  });

  final String? title;
  final bool canPickImage;
  final bool canPickVideo;
  final bool canPickMultiImages;
  final bool canPickPdf;
  final bool canPickGif;
  final bool canDeleteImage;

  final void Function(AttachmentEntity media)? onMediaPicked;
  final void Function(List<AttachmentEntity> media)? onMultiMediaPicked;

  static Future<void> show(
    BuildContext context, {
    final String? title,
    final bool canPickImage = true,
    final bool canPickVideo = false,
    final bool canPickMultiImages = false,
    final bool canPickPdf = false,
    final bool canPickGif = false,
    final bool canDeleteImage = false,
    void Function(AttachmentEntity media)? onMediaPicked,
    void Function(List<AttachmentEntity> media)? onMultiMediaPicked,
  }) async {
    return await showAppModalBottomSheet<void>(
      context: context,
      routeSettings: const RouteSettings(name: "MediaPickerBottomSheet"),
      hasTopInductor: false,
      backgroundColor: Colors.transparent,
      barrierColor: _kSheetScrim,
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: MediaPickerBottomSheet(
        title: title,
        canPickImage: canPickImage,
        canPickVideo: canPickVideo,
        canPickMultiImages: canPickMultiImages,
        onMediaPicked: onMediaPicked,
        onMultiMediaPicked: onMultiMediaPicked,
        canPickPdf: canPickPdf,
        canPickGif: canPickGif,
        canDeleteImage: canDeleteImage,
      ),
    );
  }

  bool get _hasTitle => title != null && title!.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final List<Widget> options = _buildOptions(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_hasTitle) ...[
            Text(
              title!,
              textAlign: TextAlign.center,
              style: TextStyles.semiBold18.copyWith(color: AppColors.black900, height: 1, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
          ],
          _OptionsCard(children: options),
        ],
      ),
    );
  }

  List<Widget> _buildOptions(BuildContext context) {
    return [
      if (canPickImage)
        _PickerOptionTile(
          text: appLocalizer.pickImageFromCamera,
          svgIcon: AppIcons.camera,
          onTap: () async {
            final attachment = await MediaPickerUtils.pickImage(ImageSource.camera);
            if (attachment != null) {
              _onPickMedia(attachment);
            }
            if (!context.mounted) return;
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      if (canPickImage)
        _PickerOptionTile(
          text: appLocalizer.pickImageFromGallery,
          svgIcon: AppIcons.gallery,
          onTap: () async {
            if (!canPickMultiImages) {
              final attachment = await MediaPickerUtils.pickImage(ImageSource.gallery);
              _onPickMedia(attachment);
            } else {
              final attachments = await MediaPickerUtils.pickMultiImage();
              _onPickMultiMedia(attachments);
            }
            if (!context.mounted) return;
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      if (canPickVideo)
        _PickerOptionTile(
          text: appLocalizer.pickVideoFromGallery,
          icon: Icons.videocam_rounded,
          onTap: () async {
            await MediaPickerUtils.pickVideo(pickedMediaCallback: _onPickMedia, source: ImageSource.gallery);
            if (!context.mounted) return;
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      if (canPickPdf)
        _PickerOptionTile(
          text: "Pdf",
          icon: Icons.file_present_outlined,
          onTap: () async {
            final attachment = await MediaPickerUtils.pickPdfFile();
            if (attachment != null) {
              _onPickMedia(attachment);
            }
            if (!context.mounted) return;
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      if (canPickGif)
        _PickerOptionTile(
          text: "GIF",
          icon: Icons.gif,
          onTap: () async {
            final attachment = await MediaPickerUtils.pickGif();
            if (attachment != null) {
              _onPickMedia(attachment);
            }
            if (!context.mounted) return;
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      if (canDeleteImage)
        _PickerOptionTile(
          text: appLocalizer.deleteImage,
          svgIcon: AppIcons.trash,
          onTap: () {
            _onPickMedia(const AttachmentEntity.empty());
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
    ];
  }

  void _onPickMedia(AttachmentEntity? attachment) {
    if (onMediaPicked != null && attachment != null) {
      onMediaPicked!(attachment);
    }
  }

  void _onPickMultiMedia(List<AttachmentEntity>? attachments) {
    if (onMultiMediaPicked != null && attachments != null) {
      onMultiMediaPicked!(attachments);
    }
  }
}

class _OptionsCard extends StatelessWidget {
  const _OptionsCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: _kOptionsBackground, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          for (int index = 0; index < children.length; index++) ...[
            children[index],
            if (index != children.length - 1) const _OptionsDivider(),
          ],
        ],
      ),
    );
  }
}

class _PickerOptionTile extends StatelessWidget {
  const _PickerOptionTile({required this.text, this.onTap, this.icon, this.svgIcon});

  final String text;
  final IconData? icon;
  final String? svgIcon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
            width: 18,
            height: 18,
            child: svgIcon != null
                ? AppSvgIcon(path: svgIcon!, width: 18, height: 18)
                : Icon(icon ?? Icons.image_outlined, size: 18, color: AppColors.mutedText),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              text,
              style: TextStyles.medium14.copyWith(color: AppColors.black900, height: 1, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class _OptionsDivider extends StatelessWidget {
  const _OptionsDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 12, bottom: 16),
      child: Divider(height: 1, thickness: 1, color: Colors.white),
    );
  }
}
