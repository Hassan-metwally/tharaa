// ignore_for_file: unused_element_parameter

import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../core/core.dart';

class SpinKitLoadingWidget extends StatelessWidget {
  final Color? color;
  final double size;
  final int count;

  const SpinKitLoadingWidget({super.key, this.color, this.size = 24, this.count = 3});

  const SpinKitLoadingWidget.medium({super.key, this.color, this.size = 14, this.count = 3});

  const SpinKitLoadingWidget.small({super.key, this.color, this.size = 10, this.count = 3});

  @override
  Widget build(BuildContext context) {
    return _SpinKitThreeBounce(color: color ?? AppColors.primary, size: size, count: count);
  }
}

class _SpinKitThreeBounce extends StatefulWidget {
  const _SpinKitThreeBounce({
    // super.key,
    this.color,
    this.size = 50.0,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 1400),
    this.controller,
    this.count = 3,
  }) : assert(
         !(itemBuilder is IndexedWidgetBuilder && color is Color) && !(itemBuilder == null && color == null),
         'You should specify either a itemBuilder or a color',
       );

  final Color? color;
  final double size;
  final IndexedWidgetBuilder? itemBuilder;
  final Duration duration;
  final AnimationController? controller;
  final int count;

  @override
  State<_SpinKitThreeBounce> createState() => _SpinKitThreeBounceState();
}

class _SpinKitThreeBounceState extends State<_SpinKitThreeBounce> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ?? AnimationController(vsync: this, duration: widget.duration))..repeat();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.fromSize(
        size: Size(widget.size * 2, widget.size),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: List.generate(widget.count, (int i) {
            return ScaleTransition(
              scale: _DelayTween(begin: 0.0, end: 1.0, delay: i * .2).animate(_controller),
              child: SizedBox.fromSize(size: Size.square(widget.size * 0.5), child: _itemBuilder(i)),
            );
          }),
        ),
      ),
    );
  }

  Widget _itemBuilder(int index) => widget.itemBuilder != null
      ? widget.itemBuilder!(context, index)
      : DecoratedBox(
          decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle),
        );
}

class _DelayTween extends Tween<double> {
  _DelayTween({super.begin, super.end, required this.delay});

  final double delay;

  @override
  double lerp(double t) => super.lerp((math.sin((t - delay) * 2 * math.pi) + 1) / 2);

  @override
  double evaluate(Animation<double> animation) => lerp(animation.value);
}
