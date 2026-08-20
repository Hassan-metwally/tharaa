import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../material/media/svg_icon.dart';
import '../../../material/overlay/show_modal_bottom_sheet.dart';
import '../../core.dart';
import 'media_picker_utils.dart';

class MediaPickerBottomSheet extends StatelessWidget {
  const MediaPickerBottomSheet({
    super.key,
    required this.canPickImage,
    required this.canPickVideo,
    required this.canPickMultiImages,
    required this.onMediaPicked,
    required this.onMultiMediaPicked,
    required this.canPickPdf,
    required this.canPickGif,
  });

  final bool canPickImage;
  final bool canPickVideo;
  final bool canPickMultiImages;
  final bool canPickPdf;
  final bool canPickGif;

  final void Function(AttachmentEntity media)? onMediaPicked;
  final void Function(List<AttachmentEntity> media)? onMultiMediaPicked;

  static Future<void> show(
    BuildContext context, {
    final bool canPickImage = true,
    final bool canPickVideo = false,
    final bool canPickMultiImages = false,
    final bool canPickPdf = false,
    final bool canPickGif = false,
    void Function(AttachmentEntity media)? onMediaPicked,
    void Function(List<AttachmentEntity> media)? onMultiMediaPicked,
  }) async {
    return await showAppModalBottomSheet<void>(
      context: context,
      routeSettings: const RouteSettings(name: "MediaPickerBottomSheet"),
      child: MediaPickerBottomSheet(
        canPickImage: canPickImage,
        canPickVideo: canPickVideo,
        canPickMultiImages: canPickMultiImages,
        onMediaPicked: onMediaPicked,
        onMultiMediaPicked: onMultiMediaPicked,
        canPickPdf: canPickPdf,
        canPickGif: canPickGif,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          if (canPickImage)
            _TileWidget(
              text: appLocalizer.pickImageFromGallery,
              icon: Icons.image,
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
          if (canPickImage) const _DividerWidget(),
          if (canPickImage)
            _TileWidget(
              text: appLocalizer.pickImageFromCamera,
              icon: Icons.camera_alt,
              onTap: () async {
                final attachment = await MediaPickerUtils.pickImage(ImageSource.camera);
                if (attachment != null) {
                  _onPickMedia(attachment);
                }
                if (!context.mounted) return;
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          if (canPickVideo) const _DividerWidget(),
          if (canPickVideo)
            _TileWidget(
              text: appLocalizer.pickVideoFromGallery,
              icon: Icons.videocam_rounded,
              onTap: () async {
                await MediaPickerUtils.pickVideo(pickedMediaCallback: _onPickMedia, source: ImageSource.gallery);
                if (!context.mounted) return;

                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          if (canPickPdf) const _DividerWidget(),
          if (canPickPdf)
            _TileWidget(
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
          if (canPickGif) const _DividerWidget(),
          if (canPickGif)
            _TileWidget(
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
          const SizedBox(height: 24),
        ],
      ),
    );
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

class _TileWidget extends StatelessWidget {
  const _TileWidget({
    required this.text,
    this.onTap,
    required this.icon,
    // ignore: unused_element_parameter
    this.svgIcon,
  });
  final String text;
  final IconData icon;
  final String? svgIcon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            if (svgIcon != null) AppSvgIcon(path: svgIcon ?? '', size: 20) else Icon(icon, size: 20, color: AppColors.blue),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                // style: TextStyles.medium14.copyWith(color: AppColors.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DividerWidget extends StatelessWidget {
  const _DividerWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Divider(color: AppColors.dividerColor, thickness: .5),
    );
  }
}
