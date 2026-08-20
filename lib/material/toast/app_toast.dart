// ignore_for_file: unused_element, unused_element_parameter

import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../media/svg_icon.dart';

const Duration _toastLongDuration = Duration(milliseconds: 3500);
const Duration _showToastDuration = Duration(milliseconds: 1500);
const Duration _reverseToastDuration = Duration(milliseconds: 440);

final Widget _successPrifixWidget = AppSvgIcon(path: "");
final Widget _errorPrifixWidget = AppSvgIcon(path: "");

class AppToasts {
  AppToasts._();
  static OverlayEntry? _overlayEntry;

  static void error(BuildContext context, {required String message, Duration? duration}) {
    if (_overlayEntry?.mounted ?? false) {
      _overlayEntry?.remove();
    }

    if (message.isEmpty) {
      message = appLocalizer.unexpectedError;
    }

    duration ??= _calculateDuration(message);

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => _Toast(
        title: message,
        onDismiss: () {
          dismissToast();
        },
        color: AppColors.red50,
        textStyle: TextStyles.regular12.copyWith(color: AppColors.error),
        duration: duration,
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  static void success(BuildContext context, {required String message, Duration? duration}) {
    if (_overlayEntry?.mounted ?? false) {
      _overlayEntry?.remove();
    }
    duration ??= _calculateDuration(message);

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => _Toast(
        title: message,
        onDismiss: () {
          dismissToast();
        },
        textStyle: TextStyles.regular12.copyWith(color: AppColors.success900),
        color: AppColors.success50,
        // prefixWidget: AppSvgIcon(path: AppIcons.checkCircleIc),
        duration: duration,
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  static void hint(BuildContext context, {required String message, Duration? duration, Widget? suffixWidget}) {
    if (_overlayEntry?.mounted ?? false) {
      _overlayEntry?.remove();
    }
    duration ??= _calculateDuration(message);

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => _Toast(
        title: message,
        onDismiss: () {
          dismissToast();
        },
        textStyle: TextStyles.medium14.copyWith(color: AppColors.warning700),
        color: AppColors.warning100,
        duration: duration,
        suffixWidget: suffixWidget,
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  static void dismissToast() {
    if (_overlayEntry?.mounted ?? false) {
      _overlayEntry?.remove();
    }
    _overlayEntry = null;
  }

  static Duration _calculateDuration(String text) {
    // the average reading speed in letters per second
    const int averageReadingSpeed = 14;

    // Calculate the number of letters in the text
    final letterCount = text.replaceAll(' ', '').length;

    // Estimate the reading time in milliseconds
    int readingTimeInSeconds = (letterCount / averageReadingSpeed).ceil();

    //set min duration to 2 seconds
    if (readingTimeInSeconds < 3) {
      readingTimeInSeconds = 3;
    }

    return Duration(seconds: readingTimeInSeconds);
  }
}

class _Toast extends StatefulWidget {
  final VoidCallback onDismiss;
  final Color? color;
  final Color? borderColor;
  final TextStyle? textStyle;
  final String title;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final Duration? duration;

  const _Toast({
    required this.onDismiss,
    this.color,
    this.borderColor,
    this.textStyle,
    required this.title,
    this.prefixWidget,
    this.duration,
    this.suffixWidget,
  });

  @override
  State<_Toast> createState() => _ToastState();
}

class _ToastState extends State<_Toast> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late CurvedAnimation _sizeAnimation;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: _showToastDuration, reverseDuration: _reverseToastDuration);

    _sizeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastLinearToSlowEaseIn,
      reverseCurve: Curves.fastEaseInToSlowEaseOut,
    );

    _animationController.forward();
    _dismissToastAfterDuration();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _sizeAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Align(
        alignment: const Alignment(0, -.7),
        child: Material(
          color: Colors.transparent,
          child: GestureDetector(
            onVerticalDragEnd: (_) {
              _onDismiss();
            },
            onHorizontalDragEnd: (_) {
              _onDismiss();
            },
            child: AnimatedBuilder(
              animation: _sizeAnimation,
              builder: (context, child) {
                return Transform.scale(scale: _sizeAnimation.value, child: child);
              },
              child: Container(
                constraints: const BoxConstraints(minWidth: 120),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: widget.color,
                  // border: Border.all(
                  // color:
                  // widget.borderColor ?? AppColors.canvasBackgroundColor,
                  // width: .7,
                  // ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: AnimatedBuilder(
                  animation: _sizeAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _sizeAnimation.value,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (widget.prefixWidget != null) ...[widget.prefixWidget!, const SizedBox(width: 4)],
                          Flexible(
                            child: Text(
                              widget.title,
                              maxLines: 8,
                              textAlign: TextAlign.center,
                              style: (widget.textStyle ?? TextStyles.medium14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (widget.suffixWidget != null) ...[const SizedBox(width: 4), widget.suffixWidget!],
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _dismissToastAfterDuration() {
    Timer(widget.duration ?? _toastLongDuration, () {
      // use mounted here to prevent do dismiss animation if controller disposed
      if (mounted) {
        _onDismiss();
      }
    });
  }

  void _onDismiss() {
    _animationController.reverse().then((value) {
      widget.onDismiss();
    });
  }
}
