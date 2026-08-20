// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../core/core.dart';

class WidgetRipple extends StatefulWidget {
  final Widget child;
  final Color? rippleColor, backgroundColor;
  final Function? onClick;
  final EdgeInsetsGeometry contentPadding, margin;
  final double? radius;
  final double rippleOpacity;

  const WidgetRipple({
    super.key,
    this.rippleOpacity = 0.4,
    this.radius,
    this.backgroundColor,
    this.contentPadding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    required this.onClick,
    required this.child,
    this.rippleColor,
  });

  @override
  WidgetRippleState createState() => WidgetRippleState();
}

class WidgetRippleState extends State<WidgetRipple> {
  late bool _rippleInProgress;

  @override
  void initState() {
    super.initState();
    _rippleInProgress = false;
  }

  void startRippleAnimation() {
    setState(() {
      _rippleInProgress = true;
    });
  }

  void stopRippleAnimation() {
    setState(() {
      _rippleInProgress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.radius ?? 10),
        child: Material(
          color: widget.backgroundColor ?? Colors.transparent,
          child: InkWell(
            onTapDown: (_) {
              startRippleAnimation();
            },
            onTapUp: (_) {
              stopRippleAnimation();
            },
            onTap: widget.onClick != null
                ? () {
                    widget.onClick!();
                  }
                : null,
            highlightColor: (widget.rippleColor ?? AppColors.primary950).withOpacity(0.2),
            splashColor: _rippleInProgress
                ? (widget.rippleColor ?? AppColors.primary950).withOpacity(widget.rippleOpacity)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(widget.radius ?? 10),
            child: Padding(padding: widget.contentPadding, child: widget.child),
          ),
        ),
      ),
    );
  }
}
