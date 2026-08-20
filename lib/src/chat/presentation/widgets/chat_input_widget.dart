// ignore_for_file: unused_element

import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/utils/picker/media_picker_bottomsheet.dart';
import '../../../../material/media/app_image.dart';
import '../../../../material/media/svg_icon.dart';
import '../../../../material/spin_kit_loading_widget.dart';
import '../../../../material/toast/app_toast.dart';
import '../chat_cubit.dart';

const _border = OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)), borderSide: BorderSide.none);

const _kMaxAllowedAttachments = 10;

class ChatInputWidget extends StatefulWidget {
  const ChatInputWidget({super.key});

  @override
  State<ChatInputWidget> createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends State<ChatInputWidget> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool showMediaPickerTile = false;
  final List<AttachmentEntity> attachments = [];

  bool get getCanSendAttachments => context.read<ChatCubit>().input.getCanSendAttachments;

  void toggleShowMediaPickerTile() {
    setState(() {
      showMediaPickerTile = !showMediaPickerTile;
    });
  }

  void _fieldFocusCallback() {
    setState(() {
      showMediaPickerTile = !_focusNode.hasFocus;
    });
  }

  void _onPickMedia(List<AttachmentEntity> media) {
    final newAttachments = List<AttachmentEntity>.from(media + attachments);
    if (newAttachments.length < _kMaxAllowedAttachments) {
      setState(() {
        attachments.clear();
        attachments.addAll(newAttachments);
      });
      toggleShowMediaPickerTile();
    } else {
      AppToasts.hint(context, message: appLocalizer.maxAllowedMediaCount);
    }
  }

  void _onSendMessageSuccess() {
    setState(() {
      _textController.clear();
      attachments.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_fieldFocusCallback);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      buildWhen: (previous, current) => previous.sendMessageState != current.sendMessageState,
      listenWhen: (previous, current) => previous.sendMessageState != current.sendMessageState,
      listener: (context, state) {
        if (state.sendMessageState.isSuccess) {
          _onSendMessageSuccess();
        } else if (state.sendMessageState.isFailure) {
          AppToasts.error(context, message: appLocalizer.failedToSendMessageTryAgain);
        }
      },
      builder: (context, state) {
        return Container(
          width: double.infinity,
          alignment: Alignment.center,
          constraints: BoxConstraints(minHeight: 70 + MediaQuery.paddingOf(context).bottom),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: SafeArea(
            top: false,
            child: AnimatedSize(
              alignment: Alignment.bottomCenter,
              duration: const Duration(milliseconds: 300),
              child: IgnorePointer(
                ignoring: state.sendMessageState.isLoading,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _PreviewPickedMedia(
                      attachments: attachments,
                      onRemove: (value) {
                        setState(() {
                          attachments.removeAt(value);
                        });
                      },
                    ),
                    Builder(
                      builder: (context) {
                        // if (showMediaPickerTile) {
                        //   return _MediaTile(onClose: toggleShowMediaPickerTile, onSelect: _onPickMedia);
                        // }
                        return Row(
                          spacing: 12,
                          children: [
                            Expanded(
                              child: Material(
                                borderRadius: _border.borderRadius,
                                child: TextField(
                                  focusNode: _focusNode,
                                  controller: _textController,
                                  ignorePointers: state.sendMessageState.isLoading,
                                  keyboardType: TextInputType.text,
                                  textAlignVertical: TextAlignVertical.center,
                                  maxLength: 500,
                                  maxLines: 6,
                                  minLines: 1,
                                  style: TextStyles.regular14,
                                  decoration: InputDecoration(
                                    // suffixIcon: getCanSendAttachments ? _PickMediaIc(onTap: toggleShowMediaPickerTile) : null,
                                    suffixIcon: () {
                                      return GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {
                                          MediaPickerBottomSheet.show(
                                            context,
                                            canPickMultiImages: true,
                                            canPickVideo: true,
                                            onMediaPicked: (media) {
                                              _onPickMedia([media]);
                                              toggleShowMediaPickerTile();
                                            },
                                            onMultiMediaPicked: (media) {
                                              _onPickMedia(media);
                                              toggleShowMediaPickerTile();
                                            },
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: AppSvgIcon(path: ""),
                                        ),
                                      );
                                    }(),
                                    fillColor: AppColors.black50,
                                    filled: true,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                    counter: const SizedBox(),
                                    helper: const SizedBox(),
                                    hintText: appLocalizer.writeAMessage,
                                    hintMaxLines: 1,
                                    constraints: const BoxConstraints(),
                                    border: _border,
                                    enabledBorder: _border,
                                    focusedBorder: _border,
                                    disabledBorder: _border,
                                    focusedErrorBorder: _border,
                                    errorBorder: _border,
                                    hintStyle: TextStyles.regular12.copyWith(color: AppColors.hintColor),
                                  ),
                                ),
                              ),
                            ),
                            ValueListenableBuilder(
                              valueListenable: _textController,
                              child: Container(
                                constraints: const BoxConstraints(minHeight: 40, minWidth: 40),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.white,
                                  boxShadow: [
                                    BoxShadow(color: AppColors.black.withOpacityPercent(12), blurRadius: 4, offset: Offset(0, 1)),
                                  ],
                                ),
                                child: state.sendMessageState.isLoading ? const SpinKitLoadingWidget.small() : AppSvgIcon(path: ""),
                              ),
                              builder: (context, value, child) {
                                final bool isEnable = value.text.isNotEmpty || attachments.isNotEmpty;
                                return Bounce(
                                  onTap: isEnable
                                      ? () {
                                          ChatCubit.of(context).sendMessage(messageText: value.text, media: attachments);
                                        }
                                      : null,
                                  child: child!,
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _focusNode.removeListener(_fieldFocusCallback);
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }
}

class _PickMediaIc extends StatelessWidget {
  const _PickMediaIc({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(end: 12.0),
        child: AppSvgIcon(path: ""),
      ),
    );
  }
}

class _MediaTile extends StatelessWidget {
  const _MediaTile({required this.onClose, required this.onSelect});
  final VoidCallback onClose;
  final ValueChanged<List<String>> onSelect;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: [
        // Expanded(child: Wrap(spacing: 10, runSpacing: 10)),
        _MediaCard(
          icon: "",
          onTap: () {
            MediaPickerBottomSheet.show(
              context,
              canPickMultiImages: true,
              onMediaPicked: (media) {
                onSelect([media.path]);
              },
              onMultiMediaPicked: (media) {
                onSelect(media.map((e) => e.path).toList());
              },
            );
          },
        ),
        _MediaCard(
          icon: "",
          onTap: () {
            MediaPickerBottomSheet.show(
              context,
              canPickVideo: true,
              onMediaPicked: (media) {
                onSelect([media.path]);
              },
            );
          },
        ),
        _MediaCard(
          icon: "",
          onTap: () {
            MediaPickerBottomSheet.show(
              context,
              canPickPdf: true,
              onMediaPicked: (media) {
                onSelect([media.path]);
              },
            );
          },
        ),
      ],
    );
  }
}

class _MediaCard extends StatelessWidget {
  const _MediaCard({required this.icon, required this.onTap});

  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: AppColors.primary.withAlpha(40), borderRadius: BorderRadius.circular(6)),
        child: AppSvgIcon(path: icon, size: 18, color: AppColors.primary),
      ),
    );
  }
}

class _PreviewPickedMedia extends StatelessWidget {
  const _PreviewPickedMedia({required this.attachments, required this.onRemove});
  final List<AttachmentEntity> attachments;
  final ValueChanged<int> onRemove;

  @override
  Widget build(BuildContext context) {
    if (attachments.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.only(bottom: 24.0),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Wrap(
        spacing: 6,
        runSpacing: 6,
        children: attachments.map((media) {
          final IoFileUtils ioFile = IoFileUtils(media.path);
          final type = ioFile.getAttachmentType;
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              onRemove(attachments.indexOf(media));
            },
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: AppColors.primary.withAlpha(30)),
              height: 50,
              width: 50,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Builder(
                    builder: (context) {
                      switch (type) {
                        case AttachmentTypeEnum.photo:
                        case AttachmentTypeEnum.gif:
                          return AppImage.rounded(
                            path: media.path,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            radius: 4,
                          );
                        case AttachmentTypeEnum.document:
                        // return AppSvgIcon(
                        //   path: AppIcons.document2Ic,
                        //   color: AppColors.primary,
                        //   size: 25,
                        // );
                        case AttachmentTypeEnum.video:
                          final String? thumb = media.tumbnail?.trim();
                          if (thumb != null && thumb.isNotEmpty) {
                            return AppImage.rounded(
                              path: thumb,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              radius: 4,
                            );
                          }
                          return Icon(AttachmentTypeEnum.video.icon, color: AppColors.primary, size: 28);
                        case AttachmentTypeEnum.audio:
                        case AttachmentTypeEnum.unKnown:
                          return const SizedBox();
                        // return AppSvgIcon(
                        //   path: AppIcons.fileIc,
                        //   color: AppColors.primary,
                        //   size: 25,
                        // );
                      }
                    },
                  ),
                  PositionedDirectional(end: 4, top: 4, child: Icon(Icons.remove_circle_outline, color: AppColors.red500, size: 18)),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
