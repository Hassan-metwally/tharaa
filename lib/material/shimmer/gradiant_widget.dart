import 'package:flutter/material.dart';

import '../../core/core.dart';

class GradiantWidget extends StatelessWidget {
  const GradiantWidget({super.key, this.gradint, required this.child});

  final Gradient? gradint;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final gradint = this.gradint ?? AppColors.primaryGradiant;
    return ShaderMask(
      shaderCallback: (bounds) {
        return gradint.createShader(bounds);
      },
      blendMode: BlendMode.srcIn,
      child: child,
    );
  }
}
