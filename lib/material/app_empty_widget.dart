import 'package:flutter/material.dart';

import '../core/core.dart';
import 'buttons/app_button.dart';
import 'media/app_image.dart';

class AppEmptyWidget extends StatelessWidget {
  final String? text;
  final String? subText;
  final String? imagePath;
  final BoxFit? imageFit;
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final double heightPercentage;
  final ScrollPhysics physics;
  final EdgeInsetsGeometry? padding;
  final Widget? actionButton;
  final VoidCallback? onActionPressed;
  final String? actionText;
  final bool enableAnimation;
  final double imageSize;
  final double spacing;
  final MainAxisAlignment mainAxisAlignment;

  const AppEmptyWidget({
    super.key,
    this.text,
    this.subText,
    this.imagePath,
    this.imageFit = BoxFit.cover,
    this.icon,
    this.iconSize,
    this.iconColor,
    this.physics = const AlwaysScrollableScrollPhysics(),
    this.heightPercentage = 0.7,
    this.padding,
    this.actionButton,
    this.onActionPressed,
    this.actionText,
    this.enableAnimation = true,
    this.imageSize = 350,
    this.spacing = 30,
    this.mainAxisAlignment = MainAxisAlignment.center,
  }) : assert(imagePath == null || icon == null, 'Cannot provide both imagePath and icon');

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final effectiveImageSize = imageSize * heightPercentage;
    final effectiveSpacing = spacing * heightPercentage;

    Widget content = SingleChildScrollView(
      physics: physics,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: screenHeight * heightPercentage),
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: Center(
            child: Column(
              mainAxisAlignment: mainAxisAlignment,
              children: [
                _buildImageOrIcon(context, effectiveImageSize),
                SizedBox(height: effectiveSpacing),
                _buildText(context),
                if (subText != null) ...[SizedBox(height: 8 * heightPercentage), _buildSubText(context)],
                if (actionButton != null || onActionPressed != null) ...[
                  SizedBox(height: effectiveSpacing * 0.8),
                  _buildActionButton(context),
                ],
              ],
            ),
          ),
        ),
      ),
    );

    if (enableAnimation) {
      content = _AnimatedEmptyWidget(child: content);
    }

    return Semantics(label: text ?? appLocalizer.noResultFound, hint: subText, child: content);
  }

  Widget _buildImageOrIcon(BuildContext context, double size) {
    if (icon != null) {
      return Icon(icon, size: iconSize ?? size * 0.6, color: iconColor ?? AppColors.black300);
    }

    return AppImage(path: imagePath ?? AppImages.empty, height: size, width: size, fit: imageFit);
  }

  Widget _buildText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Text(
        text ?? appLocalizer.noResultFound,
        style: TextStyles.medium16.copyWith(color: AppColors.black500),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSubText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Text(
        subText!,
        style: TextStyles.regular14.copyWith(color: AppColors.black300),
        textAlign: TextAlign.center,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    if (actionButton != null) {
      return actionButton!;
    }

    if (onActionPressed != null && actionText != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: AppButton(text: actionText!, onPressed: onActionPressed),
      );
    }

    return const SizedBox.shrink();
  }
}

class _AnimatedEmptyWidget extends StatefulWidget {
  final Widget child;

  const _AnimatedEmptyWidget({required this.child});

  @override
  State<_AnimatedEmptyWidget> createState() => _AnimatedEmptyWidgetState();
}

class _AnimatedEmptyWidgetState extends State<_AnimatedEmptyWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(position: _slideAnimation, child: widget.child),
    );
  }
}

// class AppEmptyWidget extends StatelessWidget {
//   final String? text;
//   final String? subText;
//   final String? imagePath;
//   final double heightPercentage;
//   final ScrollPhysics physics;
//   const AppEmptyWidget({
//     super.key,
//     this.text,
//     this.subText,
//     this.imagePath,
//     this.physics = const AlwaysScrollableScrollPhysics(),
//     this.heightPercentage = 0.7,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       physics: physics,
//       child: SizedBox(
//         height: MediaQuery.sizeOf(context).height * heightPercentage,
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               AppImage(path: imagePath ?? AppImages.empty, height: 350 * heightPercentage, width: 350 * heightPercentage),
//               SizedBox(height: 30 * heightPercentage),
//               Text(
//                 text ?? appLocalizer.noResultFound,
//                 style: TextStyles.medium16.copyWith(color: AppColors.black500),
//                 textAlign: TextAlign.center,
//               ),
//               if (subText != null) ...[
//                 SizedBox(height: 8 * heightPercentage),
//                 Text(
//                   subText!,
//                   style: TextStyles.regular14.copyWith(color: AppColors.black300),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
