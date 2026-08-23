import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../media/svg_icon.dart';

const Duration _toastLongDuration = Duration(milliseconds: 3500);
const Duration _showToastDuration = Duration(milliseconds: 1500);
const Duration _reverseToastDuration = Duration(milliseconds: 440);

const double _toastMinHeight = 74;
const double _toastRadius = 14;
const double _toastHorizontalPadding = 16;
const double _toastIconBoxSize = 24;
const double _toastProgressHeight = 5;
const Color _toastBackgroundColor = Color(0xFFFFFFFF);
const Color _toastTextColor = Color(0xFF1A1A1A);

class AppToasts {
  AppToasts._();
  static OverlayEntry? _overlayEntry;

  static void error(BuildContext context, {required String message, Duration? duration}) {
    if (message.isEmpty) {
      message = appLocalizer.unexpectedError;
    }
    _show(context, message: message, type: _ToastType.error, duration: duration);
  }

  static void success(BuildContext context, {required String message, Duration? duration}) {
    _show(context, message: message, type: _ToastType.success, duration: duration);
  }

  static void hint(BuildContext context, {required String message, Duration? duration, Widget? suffixWidget}) {
    _show(context, message: message, type: _ToastType.warning, duration: duration, suffixWidget: suffixWidget);
  }

  static void info(BuildContext context, {required String message, Duration? duration}) {
    _show(context, message: message, type: _ToastType.info, duration: duration);
  }

  static void dismissToast() {
    if (_overlayEntry?.mounted ?? false) {
      _overlayEntry?.remove();
    }
    _overlayEntry = null;
  }

  static void _show(
    BuildContext context, {
    required String message,
    required _ToastType type,
    Duration? duration,
    Widget? suffixWidget,
  }) {
    if (_overlayEntry?.mounted ?? false) {
      _overlayEntry?.remove();
    }

    duration ??= _calculateDuration(message);

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => _Toast(
        title: message,
        type: type,
        duration: duration,
        suffixWidget: suffixWidget,
        onDismiss: dismissToast,
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
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

enum _ToastType {
  success,
  error,
  warning,
  info;

  Color get accentColor {
    switch (this) {
      case _ToastType.success:
        return const Color(0xFF0F9D58);
      case _ToastType.error:
        return const Color(0xFFB3251E);
      case _ToastType.warning:
        return const Color(0xFFF9A825);
      case _ToastType.info:
        return const Color(0xFF5296D5);
    }
  }

  String get iconPath {
    switch (this) {
      case _ToastType.success:
        return AppIcons.checkCircleSolid;
      case _ToastType.error:
        return AppIcons.exclamationCircleSolid;
      case _ToastType.warning:
        return AppIcons.exclamationTriangleSolid;
      case _ToastType.info:
        return AppIcons.infoCircleSolid;
    }
  }

  Size get iconSize {
    switch (this) {
      case _ToastType.warning:
        return const Size(21.11, 18.77);
      case _ToastType.success:
      case _ToastType.error:
      case _ToastType.info:
        return const Size(20, 20);
    }
  }
}

class _Toast extends StatefulWidget {
  final VoidCallback onDismiss;
  final _ToastType type;
  final String title;
  final Widget? suffixWidget;
  final Duration? duration;

  const _Toast({
    required this.onDismiss,
    required this.type,
    required this.title,
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: _toastHorizontalPadding, vertical: 8),
        child: Align(
          alignment: Alignment.topCenter,
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
                child: _ToastCard(
                  title: widget.title,
                  type: widget.type,
                  suffixWidget: widget.suffixWidget,
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

class _ToastCard extends StatelessWidget {
  const _ToastCard({
    required this.title,
    required this.type,
    this.suffixWidget,
  });

  final String title;
  final _ToastType type;
  final Widget? suffixWidget;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 120, minHeight: _toastMinHeight),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _toastBackgroundColor,
          borderRadius: BorderRadius.circular(_toastRadius),
          boxShadow: [BoxShadow(color: Colors.black.withOpacityPercent(8), blurRadius: 16, offset: const Offset(0, 4))],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_toastRadius),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: _toastHorizontalPadding, vertical: 16),
                child: Row(
                  children: [
                    _ToastStatusIcon(type: type),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 8,
                        textAlign: TextAlign.start,
                        style: TextStyles.semiBold14.copyWith(
                          color: _toastTextColor,
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (suffixWidget != null) ...[const SizedBox(width: 8), suffixWidget!],
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: ColoredBox(
                  color: type.accentColor,
                  child: const SizedBox(height: _toastProgressHeight, width: double.infinity),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ToastStatusIcon extends StatelessWidget {
  const _ToastStatusIcon({required this.type});

  final _ToastType type;

  @override
  Widget build(BuildContext context) {
    final Size iconSize = type.iconSize;
    return SizedBox(
      width: _toastIconBoxSize,
      height: _toastIconBoxSize,
      child: Center(
        child: AppSvgIcon(
          path: type.iconPath,
          width: iconSize.width,
          height: iconSize.height,
        ),
      ),
    );
  }
}
