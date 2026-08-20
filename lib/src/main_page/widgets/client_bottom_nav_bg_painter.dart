// // ignore_for_file: unused_element_parameter

// part of '../client_main_page.dart';

// class _ResponsiveSVGBottomNavPainter extends CustomPainter {
//   final Color color;
//   final double curveWidth;
//   final double curveDepth;
//   final double cornerRadius;
//   final double curveStartPosition; // 0.0 to 1.0 (percentage of width)

//   const _ResponsiveSVGBottomNavPainter({
//     this.color = Colors.white,
//     this.curveWidth = 130.0, // Default width of the curve section (250-126=124)
//     this.curveDepth = 36.0, // Default depth of the curve
//     this.cornerRadius = 26.0,
//     this.curveStartPosition = 0.322, // Default: 126/375 = 0.336
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = color
//       ..style = PaintingStyle.fill
//       ..isAntiAlias = true;

//     final path = Path();

//     // Calculate responsive positions
//     final curveStartX = size.width * curveStartPosition;
//     final curveEndX = curveStartX + curveWidth;

//     // Scale corner radius based on height
//     final responsiveCornerRadius = cornerRadius * (size.height / 80);

//     // Calculate control points based on curve width and depth
//     final curve1ControlX1 = curveStartX + (curveWidth * 0.314); // Proportional to original
//     final curve1ControlY1 = curveDepth * 0.219; // 7/32
//     final curve1ControlX2 = curveStartX + (curveWidth * 0.304); // 163.781 relative position
//     final curve1ControlY2 = curveDepth;
//     final curve1EndX = curveStartX + (curveWidth * 0.5); // Center of curve
//     final curve1EndY = curveDepth;

//     final curve2ControlX1 = curveStartX + (curveWidth * 0.719); // 215.125 relative position
//     final curve2ControlY1 = curveDepth;
//     final curve2ControlX2 = curveStartX + (curveWidth * 0.665); // 208.5 relative position
//     final curve2ControlY2 = curveDepth * 0.25; // 8/32

//     // Start from top-right corner start
//     path.moveTo(size.width - responsiveCornerRadius, 0);

//     // Top-right rounded corner
//     path.cubicTo(
//       size.width - responsiveCornerRadius * 0.448,
//       0,
//       size.width,
//       responsiveCornerRadius * 0.448,
//       size.width,
//       responsiveCornerRadius,
//     );

//     // Right edge down
//     path.lineTo(size.width, size.height);

//     // Bottom edge
//     path.lineTo(0, size.height);

//     // Left edge up
//     path.lineTo(0, responsiveCornerRadius);

//     // Top-left rounded corner
//     path.cubicTo(0, responsiveCornerRadius * 0.448, responsiveCornerRadius * 0.448, 0, responsiveCornerRadius, 0);

//     // Top edge to start of curve
//     path.lineTo(curveStartX, 0);

//     // First curve (down into the dip)
//     path.cubicTo(curve1ControlX1, curve1ControlY1, curve1ControlX2, curve1ControlY2, curve1EndX, curve1EndY);

//     // Second curve (back up from the dip)
//     path.cubicTo(curve2ControlX1, curve2ControlY1, curve2ControlX2, curve2ControlY2, curveEndX, 0);

//     // Continue top edge to connect back
//     path.lineTo(size.width - responsiveCornerRadius, 0);

//     final shadowPath = path.transform(Matrix4.translationValues(0, -5, 0).storage);

//     canvas.drawShadow(shadowPath, color, 15, true);
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return oldDelegate != this;
//   }

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is _ResponsiveSVGBottomNavPainter &&
//           runtimeType == other.runtimeType &&
//           color == other.color &&
//           curveWidth == other.curveWidth &&
//           curveDepth == other.curveDepth &&
//           cornerRadius == other.cornerRadius &&
//           curveStartPosition == other.curveStartPosition;

//   @override
//   int get hashCode => color.hashCode ^ curveWidth.hashCode ^ curveDepth.hashCode ^ cornerRadius.hashCode ^ curveStartPosition.hashCode;
// }
