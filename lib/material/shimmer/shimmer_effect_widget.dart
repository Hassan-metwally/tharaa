import 'package:flutter/material.dart';

class ShimmerWidget extends StatefulWidget {
  final Widget child;
  final bool startAnim;
  final Color startColor;
  final Color endColor;

  ShimmerWidget({
    Key? key,
    required this.child,
    this.startAnim = true,
    this.startColor = const Color(0xDCFFFFFF),
    this.endColor = const Color(0xFFC5C5C5),
  }) : super(key: key ?? UniqueKey());

  @override
  State<ShimmerWidget> createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<ShimmerWidget> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<Color?> colorTween;
  late final Animation<Color?> colorTweenReverse;

  Color get startColor => widget.startColor;

  Color get endColor => widget.endColor;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    colorTween = ColorTween(begin: startColor, end: endColor).animate(animationController);
    colorTweenReverse = ColorTween(begin: endColor, end: startColor).animate(animationController);

    if (widget.startAnim) {
      animationController.forward();
    }

    animationController.addListener(() {
      if (widget.startAnim) {
        if (animationController.isCompleted) {
          animationController.reverse();
        } else if (animationController.isDismissed) {
          animationController.forward();
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.startAnim,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          if (!widget.startAnim) {
            return child!;
          }
          return ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) {
              return LinearGradient(colors: [colorTween.value!, colorTweenReverse.value!]).createShader(bounds);
            },
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}
