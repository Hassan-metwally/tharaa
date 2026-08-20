part of core;

class AttachmentEntity extends Equatable {
  final int id;
  final String path;
  final String? tumbnail;
  final IoFileTypeEnum fileType;
  final AttachmentTypeEnum type;
  final double? size;

  const AttachmentEntity.empty() : this(fileType: IoFileTypeEnum.network, path: '', type: AttachmentTypeEnum.unKnown);

  const AttachmentEntity({this.id = 0, required this.path, this.tumbnail, required this.fileType, required this.type, this.size});

  factory AttachmentEntity.fromPath({required String path, int? id}) {
    final IoFileUtils ioFileObj = IoFileUtils(path);
    return AttachmentEntity(fileType: ioFileObj.getIoFileType, path: path, type: ioFileObj.getAttachmentType);
  }

  factory AttachmentEntity.fromNetwork({int id = 0, required String url, double? size}) {
    final IoFileUtils ioFileObj = IoFileUtils(url);
    return AttachmentEntity(id: id, path: url, fileType: IoFileTypeEnum.network, type: ioFileObj.getAttachmentType, size: size);
  }

  factory AttachmentEntity.fromFile(File file) {
    final IoFileUtils ioFileObj = IoFileUtils(file.path);
    return AttachmentEntity(path: file.path, fileType: IoFileTypeEnum.file, type: ioFileObj.getAttachmentType);
  }

  String get name {
    return (path.split('/').lastOrNull ?? '').split(".").firstOrNull ?? '';
  }

  String get extension {
    return path.split('.').lastOrNull ?? '';
  }

  @override
  List<Object?> get props => [path, fileType, type, tumbnail, size];
}

enum AttachmentTypeEnum {
  document,
  video,
  photo,
  audio,
  gif,
  unKnown;

  IconData get icon {
    switch (this) {
      case AttachmentTypeEnum.audio:
        return Icons.audio_file_rounded;
      case AttachmentTypeEnum.photo:
        return Icons.image;
      case AttachmentTypeEnum.video:
        return Icons.slow_motion_video_sharp;
      case AttachmentTypeEnum.document:
        return Icons.picture_as_pdf;
      case AttachmentTypeEnum.unKnown:
        return Icons.file_present_outlined;
      case AttachmentTypeEnum.gif:
        return Icons.gif;
    }
  }
}
