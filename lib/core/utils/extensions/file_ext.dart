part of core;

extension FileExt on File {
  double get sizeInMB {
    if (existsSync() == false) return 0;
    final int fileLength = lengthSync();
    final double fileSizeInMB = (fileLength / (1024 * 1024));
    final double? formattedSize = double.tryParse(fileSizeInMB.toStringAsFixed(2));
    return formattedSize ?? 0;
  }
}
