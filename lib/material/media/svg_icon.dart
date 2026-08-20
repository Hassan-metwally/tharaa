// import 'dart:io' if (dart.library.html) 'dart:html' as io;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/core.dart';

class AppSvgIcon extends StatelessWidget {
  const AppSvgIcon({
    super.key,
    required this.path,
    this.color,
    this.height,
    this.width,
    this.size,
    this.fit = BoxFit.contain,
    this.isReversed = false,
    this.placholder,
    this.alignment = Alignment.center,
  });
  final String path;
  final Color? color;
  final double? height;
  final double? width;
  final double? size;
  final BoxFit fit;
  final bool isReversed;
  final Widget? placholder;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    if (path.isEmpty) {
      return const SizedBox();
    }
    final IoFileUtils ioFileUtils = IoFileUtils(path);
    final Widget child;
    switch (ioFileUtils.getIoFileType) {
      case IoFileTypeEnum.asset:
        child = SvgPicture.asset(
          path,
          fit: fit,
          alignment: alignment,
          height: size ?? height,
          width: size ?? width,
          colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
          placeholderBuilder: (BuildContext context) => placholder ?? const _PlasholderWidget(),
        );
      case IoFileTypeEnum.network:
        child = SvgPicture.network(
          path,
          fit: fit,
          alignment: alignment,
          height: size ?? height,
          width: size ?? width,
          colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
          placeholderBuilder: (BuildContext context) => placholder ?? const _PlasholderWidget(),
        );
      case IoFileTypeEnum.file:
        child = const SizedBox();
      // if (kIsWeb) {
      // } else {
      //   child = SvgPicture.file(io.File(path),
      //       fit: fit,
      //       height: size ?? height,
      //       width: size ?? width,
      //       colorFilter: color != null
      //           ? ColorFilter.mode(color!, BlendMode.srcIn)
      //           : null,
      //       placeholderBuilder: (BuildContext context) =>
      //           placholder ?? const _PlasholderWidget());
      // }
    }
    return RotatedBox(quarterTurns: isReversed ? 90 : 0, child: child);
  }
}

class _PlasholderWidget extends StatelessWidget {
  const _PlasholderWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: const CircularProgressIndicator(
        strokeWidth: 3,
        // color: AppColors.secondary,
      ),
    );
  }
}
