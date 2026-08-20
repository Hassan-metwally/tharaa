import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../../../core/utils/picker/media_picker_utils.dart';
import '../../../../../material/media/app_image.dart';
import '../../../../../material/media/image_preview_page.dart';
import '../../../../../material/media/pdf_preview_page.dart';
import '../../../../../material/media/svg_icon.dart';
import '../../../../../material/media/video_preview_page.dart';
import '../../../domain/entities/chat_message_entity.dart';
import '../chat_message_handler.dart';

class MediaMessageCell extends StatelessWidget {
  final ChatMessageEntity message;
  final ChatMessageCallback? onLongPressed;
  final ChatMessageCallback? onPress;

  const MediaMessageCell({super.key, required this.message, required this.onLongPressed, required this.onPress});

  TextStyle get _textStyle {
    return TextStyles.regular14;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        if (onLongPressed != null) {
          onLongPressed!(message);
        }
      },
      onTap: () {
        if (onPress != null) {
          onPress!(message);
        }
      },
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: _kSingleImageSize),
        child: Column(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: !message.isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (message.attachments.isNotEmpty) _ImagesPreview(imageUrls: message.attachments),
            if (message.messageText.trim().isNotEmpty) Text(message.messageText, style: _textStyle),
          ],
        ),
      ),
    );
  }
}

const double _kSingleImageSize = 200;
const double _kSpaceBetweenImages = 8;
const double _kDoubleImageSize = (_kSingleImageSize * .5) - (_kSpaceBetweenImages * .5);
const double _kImageRadius = 12;
final Color _kImageBackgroundColor = AppColors.cardColor;

class _ImagesPreview extends StatelessWidget {
  final List<String> imageUrls;

  const _ImagesPreview({required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    final count = imageUrls.length;

    if (count == 1) {
      return _ImageWidget(url: imageUrls[0], height: _kSingleImageSize, width: _kSingleImageSize);
    } else if (count == 2) {
      // Two Images Side by Side
      return Row(
        spacing: _kSpaceBetweenImages,
        mainAxisSize: MainAxisSize.min,
        children: imageUrls.take(2).map((url) => _ImageWidget(url: url, height: _kDoubleImageSize, width: _kDoubleImageSize)).toList(),
      );
    } else if (count == 3) {
      // One large + two small below
      return Column(
        mainAxisSize: MainAxisSize.min,
        spacing: _kSpaceBetweenImages,
        children: [
          _ImageWidget(url: imageUrls[0], width: _kSingleImageSize, height: _kDoubleImageSize),
          Row(
            spacing: _kSpaceBetweenImages,
            mainAxisSize: MainAxisSize.min,
            children: imageUrls
                .skip(1)
                .take(2)
                .map((url) => _ImageWidget(url: url, width: _kDoubleImageSize, height: _kDoubleImageSize))
                .toList(),
          ),
        ],
      );
    } else if (count == 4) {
      return SizedBox(
        width: _kSingleImageSize,
        child: GridView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: imageUrls.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: _kSpaceBetweenImages * .5,
            mainAxisSpacing: _kSpaceBetweenImages * .5,
          ),
          itemBuilder: (context, index) {
            return _ImageWidget(url: imageUrls[index], width: double.infinity, height: double.infinity);
          },
        ),
      );
    } else {
      final gridImages = imageUrls.take(4).toList();
      return SizedBox(
        width: _kSingleImageSize,
        child: GridView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: gridImages.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: _kSpaceBetweenImages * .5,
            mainAxisSpacing: _kSpaceBetweenImages * .5,
          ),
          itemBuilder: (context, index) {
            if (index == 3 && count > 4) {
              // Last image with overlay if more than 4
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  _MoreMediaPreviewPage.open(gridImages);
                },
                child: Stack(
                  children: [
                    IgnorePointer(
                      child: _ImageWidget(url: gridImages[index], width: double.infinity, height: double.infinity),
                    ),
                    Container(
                      decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text('+${count - 4}', style: TextStyles.medium24.copyWith(color: AppColors.blue50)),
                      ),
                    ),
                  ],
                ),
              );
            }
            return _ImageWidget(url: gridImages[index], width: double.infinity, height: double.infinity);
          },
        ),
      );
    }
  }
}

class _ImageWidget extends StatelessWidget {
  const _ImageWidget({required this.url, required this.height, required this.width, this.fit = BoxFit.cover});

  final String url;
  final double? height;
  final double width;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final IoFileUtils ioFileUtils = IoFileUtils(url);
    final type = ioFileUtils.getAttachmentType;
    switch (type) {
      case AttachmentTypeEnum.photo:
      case AttachmentTypeEnum.gif:
        return GestureDetector(
          onTap: () {
            ImagePreviewPage.open(url);
          },
          behavior: HitTestBehavior.opaque,
          child: AppImage.rounded(
            path: url,
            fit: fit,
            radius: _kImageRadius,
            bgColor: _kImageBackgroundColor,
            height: height,
            width: width,
          ),
        );
      case AttachmentTypeEnum.video:
        return GestureDetector(
          onTap: () {
            FullVideoPlayerPage.navigate(context, input: NetworkVideoSourceInput(url));
          },
          behavior: HitTestBehavior.opaque,
          child: FutureBuilder<String?>(
            future: GetVideoThumbnail.getVideoThumbnail(videoPath: url),
            builder: (context, snapshot) {
              final String thumbnailPath = snapshot.data?.trim() ?? '';
              if (thumbnailPath.isNotEmpty) {
                return Stack(
                  children: [
                    AppImage.rounded(
                      path: thumbnailPath,
                      fit: fit,
                      radius: _kImageRadius,
                      bgColor: _kImageBackgroundColor,
                      height: height,
                      width: width,
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Icon(Icons.slow_motion_video_sharp, color: Colors.blueGrey.shade100, size: 50),
                    ),
                  ],
                );
              }
              return Container(
                width: width,
                height: height,
                decoration: BoxDecoration(color: _kImageBackgroundColor, borderRadius: BorderRadius.circular(_kImageRadius)),
                child: Icon(AttachmentTypeEnum.video.icon, color: AppColors.primary, size: 28),
              );
            },
          ),
        );
      case AttachmentTypeEnum.document:
        return GestureDetector(
          onTap: () {
            PdfPreviewPage.open(url);
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            decoration: BoxDecoration(color: _kImageBackgroundColor, borderRadius: BorderRadius.circular(_kImageRadius)),
            width: width,
            height: height,
            padding: const EdgeInsets.all(32),
            child: Center(
              child: AppSvgIcon(path: "", color: AppColors.blue.withAlpha(35), size: (height ?? width) * .4),
            ),
          ),
        );

      case AttachmentTypeEnum.audio:
      case AttachmentTypeEnum.unKnown:
        return GestureDetector(
          onTap: () {
            PdfPreviewPage.open(url);
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            decoration: BoxDecoration(color: _kImageBackgroundColor, borderRadius: BorderRadius.circular(_kImageRadius)),
            width: width,
            height: height,
            padding: const EdgeInsets.all(32),
            child: Center(
              child: AppSvgIcon(path: "", color: AppColors.blue.withAlpha(35), size: (height ?? width) * .4),
            ),
          ),
        );
    }
  }
}

class _MoreMediaPreviewPage extends StatelessWidget {
  final List<String> imageUrls;

  const _MoreMediaPreviewPage({required this.imageUrls});

  static const String routeName = '/MoreMediaPreviewPage';

  static void open(List<String> paths) async {
    final context = appNavigatorKey.currentContext;

    if (context == null || context.mounted == false) {
      return;
    }
    await Navigator.of(context, rootNavigator: true).push(
      FadeTransitionRoute(
        settings: const RouteSettings(name: routeName),
        child: (context) => _MoreMediaPreviewPage(imageUrls: paths),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              itemBuilder: (context, index) {
                final media = imageUrls[index];
                return _ImageWidget(url: media, width: double.infinity, height: null, fit: BoxFit.fitWidth);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemCount: imageUrls.length,
            ),
          ),
          PositionedDirectional(
            top: 10,
            start: 20,
            child: SafeArea(
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(color: AppColors.black50.withOpacityPercent(90), shape: BoxShape.circle),
                child: BackButton(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
