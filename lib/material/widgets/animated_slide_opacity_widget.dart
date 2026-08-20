import 'package:flutter/material.dart';

import '../../core/core.dart';

class AnimatedSlideWithOpacityWidget extends StatefulWidget {
  const AnimatedSlideWithOpacityWidget({
    super.key,
    required this.child,
    this.slideDirection = Alignment.topCenter,
    this.index,
    this.duration = const Duration(milliseconds: 800),
    this.intervaslDuration = const Duration(milliseconds: 200),
    this.resetAtIndex = false,
  });
  final Widget child;
  final AlignmentGeometry slideDirection;
  final Duration duration;
  final Duration intervaslDuration;
  final bool resetAtIndex;
  final int? index;

  @override
  State<AnimatedSlideWithOpacityWidget> createState() => __AnimatedTopSlideWithOpacityWidgetState();
}

class __AnimatedTopSlideWithOpacityWidgetState extends State<AnimatedSlideWithOpacityWidget>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: _getActualDuration, vsync: this);

    _slideAnimation = Tween<Offset>(
      begin: _getBeingOffset,
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _toggleCard();
  }

  void _toggleCard() {
    setState(() {
      _isVisible = !_isVisible;
      if (_isVisible) {
        _animationController.forward(); // Slide down
      } else {
        _animationController.reverse(); // Slide up
      }
    });
  }

  AlignmentGeometry get _getSlideDirection => widget.slideDirection;
  TextDirection get appDirectionality {
    final context = appNavigatorKey.currentContext;
    if (context != null && context.mounted) {
      return Directionality.of(context);
    }
    return TextDirection.ltr;
  }

  bool get isLTR => appDirectionality == TextDirection.ltr;

  Offset get _getBeingOffset {
    if (_getSlideDirection == Alignment.topCenter || _getSlideDirection == AlignmentDirectional.topCenter) {
      return const Offset(0, -1);
    } else if (_getSlideDirection == Alignment.topRight) {
      return const Offset(1, -1);
    } else if (_getSlideDirection == Alignment.topLeft) {
      return const Offset(-1, -1);
    } else if (_getSlideDirection == Alignment.centerLeft) {
      return const Offset(-1, 0);
    } else if (_getSlideDirection == Alignment.centerRight) {
      return const Offset(1, 0);
    } else if (_getSlideDirection == Alignment.bottomCenter || _getSlideDirection == AlignmentDirectional.bottomCenter) {
      return const Offset(0, 1);
    } else if (_getSlideDirection == Alignment.bottomLeft) {
      return const Offset(-1, 1);
    } else if (_getSlideDirection == Alignment.bottomRight) {
      return const Offset(1, 1);
    } else if (_getSlideDirection == AlignmentDirectional.centerEnd) {
      if (isLTR) {
        return const Offset(-1, 0);
      } else {
        return const Offset(1, 0);
      }
    } else if (_getSlideDirection == AlignmentDirectional.centerStart) {
      if (!isLTR) {
        return const Offset(-1, 0);
      } else {
        return const Offset(1, 0);
      }
    }
    return const Offset(0, -1);
  }

  Duration get _getActualDuration {
    final intervalDuration = widget.intervaslDuration.inMilliseconds * getItemIndex;
    return Duration(milliseconds: widget.duration.inMilliseconds + intervalDuration);
  }

  int get getItemIndex {
    final int currentIndex = widget.index ?? 0;
    if (widget.resetAtIndex) {
      return currentIndex % 8;
    }

    return currentIndex;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return SlideTransition(
          position: _slideAnimation,
          child: AnimatedOpacity(opacity: _isVisible ? 1.0 : 0.0, duration: _getActualDuration, child: child),
        );
      },
      child: widget.child,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
