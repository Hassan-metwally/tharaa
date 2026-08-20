part of core;

extension ColorExt on Color {
  /// Apply opacity using percentage (0–100)
  Color withOpacityPercent(int percent) {
    assert(percent >= 0 && percent <= 100, 'Percent must be between 0 and 100');
    final alpha = (percent * 255 / 100).round();
    return withAlpha(alpha);
  }
}
