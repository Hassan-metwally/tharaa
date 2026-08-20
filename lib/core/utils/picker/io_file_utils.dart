part of core;

enum IoFileTypeEnum { asset, network, file }

class IoFileUtils {
  final String filePath;

  final Uuid _uuid = const Uuid();

  IoFileUtils(this.filePath);

  IoFileTypeEnum get getIoFileType {
    if (filePath.trim().startsWith('http') || filePath.trim().startsWith('https')) {
      return IoFileTypeEnum.network;
    } else if (filePath.trim().startsWith('/')) {
      return IoFileTypeEnum.file;
    } else {
      return IoFileTypeEnum.asset;
    }
  }

  String get name {
    return filePath.split('/').lastOrNull ?? '';
  }

  String get nameOnly {
    return name.split(".").firstOrNull ?? '';
  }

  AttachmentTypeEnum get getAttachmentType {
    final ext = getExtension;
    if (getAllowedImagesExtensions.contains(ext)) {
      return AttachmentTypeEnum.photo;
    } else if (getAllowedVideosExtensions.contains(ext)) {
      return AttachmentTypeEnum.video;
    } else if (getAllowedAudioExtensions.contains(ext)) {
      return AttachmentTypeEnum.audio;
    } else if (getAllowedDocsExtensions.contains(ext)) {
      return AttachmentTypeEnum.document;
    }
    return AttachmentTypeEnum.unKnown;
  }

  List<String> getAllowedExtensions(AttachmentTypeEnum type) {
    switch (type) {
      case AttachmentTypeEnum.photo:
        return getAllowedImagesExtensions;
      case AttachmentTypeEnum.video:
        return getAllowedVideosExtensions;
      case AttachmentTypeEnum.document:
        return getAllowedDocsExtensions;
      case AttachmentTypeEnum.audio:
        return getAllowedAudioExtensions;
      case AttachmentTypeEnum.gif:
        return const ["gif", "GIF"];
      case AttachmentTypeEnum.unKnown:
        return const [];
    }
  }

  String get getExtension {
    String fileExt = '';
    if (filePath.contains('.')) {
      final splittedExt = filePath.split('.').lastOrNull;
      if (splittedExt != null) {
        fileExt = splittedExt;
      }
    } else {
      fileExt = filePath;
    }
    return fileExt.toLowerCase();
  }

  final List<_FileContentEntity> _imagesExtension = [
    _FileContentEntity(extension: 'png', mimeType: 'image/png', allowed: true),
    _FileContentEntity(extension: 'jpeg', mimeType: 'image/jpeg', allowed: true),
    _FileContentEntity(extension: 'wbmp', mimeType: 'image/wbmp', allowed: true),
    _FileContentEntity(extension: 'jpg', mimeType: 'image/jpeg', allowed: true),
    _FileContentEntity(extension: 'gif', mimeType: 'image/gif', allowed: true),
    _FileContentEntity(extension: 'webp', mimeType: 'image/webp'),
    _FileContentEntity(extension: 'jpe', mimeType: 'image/jpeg'),
    _FileContentEntity(extension: 'wdp', mimeType: 'image/wdp'),
    _FileContentEntity(extension: '3ds', mimeType: 'image/x-3ds'),
    _FileContentEntity(extension: 'avif', mimeType: 'image/avif'),
    _FileContentEntity(extension: 'bmp', mimeType: 'image/bmp'),
    _FileContentEntity(extension: 'btif', mimeType: 'image/prs.btif'),
    _FileContentEntity(extension: 'cgm', mimeType: 'image/cgm'),
    _FileContentEntity(extension: 'cmx', mimeType: 'image/x-cmx'),
    _FileContentEntity(extension: 'djv', mimeType: 'image/vnd.djvu'),
    _FileContentEntity(extension: 'djvu', mimeType: 'image/vnd.dwg'),
    _FileContentEntity(extension: 'dxf', mimeType: 'image/vnd.dxf'),
    _FileContentEntity(extension: 'fbs', mimeType: 'image/fbs'),
    _FileContentEntity(extension: 'fh', mimeType: 'image/x-freehand'),
    _FileContentEntity(extension: 'fh4', mimeType: 'image/x-freehand'),
    _FileContentEntity(extension: 'fh5', mimeType: 'image/x-freehand'),
    _FileContentEntity(extension: 'fh7', mimeType: 'image/x-freehand'),
    _FileContentEntity(extension: 'fhc', mimeType: 'image/x-freehand'),
    _FileContentEntity(extension: 'fpx', mimeType: 'image/vnd.fpx'),
    _FileContentEntity(extension: 'fst', mimeType: 'image/vnd.fst'),
    _FileContentEntity(extension: 'g3', mimeType: 'image/g3fax'),
    _FileContentEntity(extension: 'ico', mimeType: 'image/x-icon'),
    _FileContentEntity(extension: 'ico', mimeType: 'image/x-icon'),
    _FileContentEntity(extension: 'psd', mimeType: 'image/vnd.adobe.photoshop'),
  ];

  List<String> get getAllowedImagesExtensions => _imagesExtension.map((e) => e.extension).toList();

  final List<_FileContentEntity> _videosExtension = [
    ///✅ COMMONLY SUPPORTED & SAFE IN FLUTTER
    _FileContentEntity(extension: 'mp4', mimeType: 'video/mp4', allowed: true),
    _FileContentEntity(extension: 'm4v', mimeType: 'video/x-m4v', allowed: true),
    _FileContentEntity(extension: 'mp4v', mimeType: 'video/mp4', allowed: true),
    _FileContentEntity(extension: 'mpg4', mimeType: 'video/mp4', allowed: true),
    _FileContentEntity(extension: 'mov', mimeType: 'video/quicktime', allowed: true),
    _FileContentEntity(extension: 'webm', mimeType: 'video/webm', allowed: true),
    _FileContentEntity(extension: 'avi', mimeType: 'video/x-msvideo', allowed: true),
    _FileContentEntity(extension: 'wmv', mimeType: 'video/x-ms-wmv', allowed: true),
    _FileContentEntity(extension: 'mkv', mimeType: 'video/x-matroska', allowed: true),
    _FileContentEntity(extension: 'mpeg', mimeType: 'video/mpeg', allowed: true),

    ///⚠️ RARE / LEGACY / UNLIKELY SUPPORTED BY DEFAULT FLUTTER
    _FileContentEntity(extension: 'wm', mimeType: 'video/x-ms-wm'),
    _FileContentEntity(extension: 'viv', mimeType: 'video/vnd.vivo'),
    _FileContentEntity(extension: 'mpe', mimeType: 'video/mpeg'),
    _FileContentEntity(extension: 'm1v', mimeType: 'video/mpeg'),
    _FileContentEntity(extension: 'm2v', mimeType: 'video/mpeg'),
    _FileContentEntity(extension: 'm4u', mimeType: 'video/x-m4v'),
    _FileContentEntity(extension: 'asf', mimeType: 'video/x-ms-asf'),
    _FileContentEntity(extension: 'asx', mimeType: 'video/x-ms-asf'),
    _FileContentEntity(extension: 'flv', mimeType: 'video/x-flv'),
    _FileContentEntity(extension: 'fli', mimeType: 'video/x-fli'),
    _FileContentEntity(extension: 'qt', mimeType: 'video/quicktime'),
    _FileContentEntity(extension: 'qtff', mimeType: 'video/quicktime'),
    _FileContentEntity(extension: 'movie', mimeType: 'video/x-sgi-movie'),
  ];

  List<String> get getAllowedVideosExtensions => _videosExtension.takeWhile((e) => e.allowed).map((e) => e.extension).toList();

  final List<_FileContentEntity> _audioExtension = [
    _FileContentEntity(extension: 'aac', mimeType: 'audio/aac', allowed: true),
    _FileContentEntity(extension: 'mp3', mimeType: 'audio/mpeg', allowed: true),
    _FileContentEntity(extension: 'wav', mimeType: 'audio/x-wav', allowed: true),
    _FileContentEntity(extension: 'flac', mimeType: 'audio/x-flac', allowed: true),
    _FileContentEntity(extension: 'wax', mimeType: 'audio/x-ms-wax', allowed: true),
    _FileContentEntity(extension: 'au', mimeType: 'audio/basic', allowed: true),
    _FileContentEntity(extension: 'opus', mimeType: 'audio/basic', allowed: true),
    _FileContentEntity(extension: 'aif', mimeType: 'audio/x-aiff'),
    _FileContentEntity(extension: 'm2a', mimeType: 'audio/mpeg'),
    _FileContentEntity(extension: 'm3a', mimeType: 'audio/mpeg'),
    _FileContentEntity(extension: 'm3u', mimeType: 'audio/x-mpegurl'),
    _FileContentEntity(extension: 'm4a', mimeType: 'audio/mp4'),
    _FileContentEntity(extension: 'm4b', mimeType: 'audio/m4b'),
    _FileContentEntity(extension: 'mp2', mimeType: 'audio/mp2'),
    _FileContentEntity(extension: 'mp2a', mimeType: 'audio/mpeg'),
    _FileContentEntity(extension: 'mp4a', mimeType: 'audio/mp4'),
    _FileContentEntity(extension: 'mpga', mimeType: 'audio/mpga'),
    _FileContentEntity(extension: 'mid', mimeType: 'audio/midi'),
    _FileContentEntity(extension: 'midi', mimeType: 'audio/midi'),
    _FileContentEntity(extension: 'mka', mimeType: 'audio/x-matroska'),
    _FileContentEntity(extension: 'uva', mimeType: 'audio/vnd.dece.audio'),
    _FileContentEntity(extension: 'xm', mimeType: 'audio/xm'),
  ];

  List<String> get getAllowedAudioExtensions => _audioExtension.map((e) => e.extension).toList();

  final List<_FileContentEntity> _docsExtension = [
    _FileContentEntity(extension: 'def', mimeType: 'text/plain', allowed: true),
    _FileContentEntity(extension: 'in', mimeType: 'text/plain'),
    _FileContentEntity(extension: 'text', mimeType: 'text/plain', allowed: true),
    _FileContentEntity(extension: 'txt', mimeType: 'text/plain', allowed: true),
    _FileContentEntity(extension: 'doc', mimeType: 'application/msword', allowed: true),
    _FileContentEntity(extension: 'html', mimeType: 'text/html', allowed: true),
    _FileContentEntity(extension: 'htm', mimeType: 'text/html', allowed: true),
    _FileContentEntity(extension: 'odt', mimeType: 'application/vnd.oasis.opendocument.text', allowed: true),
    _FileContentEntity(extension: 'pdf', mimeType: 'application/pdf', allowed: true),
    _FileContentEntity(
      extension: 'docx',
      mimeType: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      allowed: true,
    ),
    _FileContentEntity(extension: 'dic', mimeType: 'text/x-c'),
    _FileContentEntity(extension: 'docm', mimeType: 'application/vnd.ms-word.document.macroenabled.12'),
    _FileContentEntity(extension: 'dot', mimeType: 'application/msword'),
    _FileContentEntity(extension: 'dotx', mimeType: 'application/vnd.openxmlformats-officedocument.wordprocessingml.template'),
    _FileContentEntity(extension: 'odb', mimeType: 'application/vnd.oasis.opendocument.database'),
    _FileContentEntity(extension: 'odc', mimeType: 'application/vnd.oasis.opendocument.chart'),
    _FileContentEntity(extension: 'odp', mimeType: 'application/vnd.oasis.opendocument.presentation'),
    _FileContentEntity(extension: 'ods', mimeType: 'application/vnd.oasis.opendocument.spreadsheet', allowed: true),
    _FileContentEntity(extension: 'potx', mimeType: 'application/vnd.openxmlformats-officedocument.presentationml.template'),
    _FileContentEntity(extension: 'ppsx', mimeType: 'application/vnd.openxmlformats-officedocument.presentationml.slideshow'),
    _FileContentEntity(extension: 'ppt', mimeType: 'application/vnd.ms-powerpoint'),
    _FileContentEntity(
      extension: 'pptx',
      mimeType: 'application/vnd.openxmlformats-officedocument.presentationml.presentation',
      allowed: true,
    ),
    _FileContentEntity(extension: 'sldx', mimeType: 'application/vnd.openxmlformats-officedocument.presentationml.slide'),
    _FileContentEntity(extension: 'sldm', mimeType: 'application/vnd.ms-powerpoint.slide.macroenabled.12'),
    _FileContentEntity(extension: 'xls', mimeType: 'application/vnd.ms-excel', allowed: true),
    _FileContentEntity(extension: 'xlsx', mimeType: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', allowed: true),
    _FileContentEntity(extension: 'xltx', mimeType: 'application/vnd.openxmlformats-officedocument.spreadsheetml.template'),
    _FileContentEntity(extension: 'pot', mimeType: 'application/vnd.ms-powerpoint'),
    _FileContentEntity(extension: 'potm', mimeType: 'application/vnd.ms-powerpoint.template.macroenabled.12'),
    _FileContentEntity(extension: 'ppam', mimeType: 'application/vnd.ms-powerpoint.addin.macroenabled.12'),
    _FileContentEntity(extension: 'pps', mimeType: 'application/vnd.ms-powerpoint'),
    _FileContentEntity(extension: 'ppsm', mimeType: 'application/vnd.ms-powerpoint.slideshow.macroenabled.12'),
    _FileContentEntity(extension: 'ppt', mimeType: 'application/vnd.ms-powerpoint', allowed: true),
    _FileContentEntity(extension: 'pptm', mimeType: 'application/vnd.ms-powerpoint.presentation.macroenabled.12'),
  ];

  List<String> get getAllowedDocsExtensions => _docsExtension.map((e) => e.extension).toList();

  Future<File> convertAssetToFile(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);
    final temporaryDirectory = await getTemporaryDirectory();
    final filePath = '${temporaryDirectory.path}/temp_files/${_uuid.v4()}_${assetPath.split('/').last}';
    final file = File(filePath);
    await file.create(recursive: true);
    await file.writeAsBytes(byteData.buffer.asUint8List());
    return file;
  }
}

class _FileContentEntity {
  final String extension;
  final String mimeType;
  final bool allowed;

  _FileContentEntity({required this.extension, required this.mimeType, this.allowed = false});
}
