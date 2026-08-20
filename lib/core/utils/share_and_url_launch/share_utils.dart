part of core;

abstract base class ShareUtils {
  ShareUtils._();
  static Future<void> shareText({required String text, String? subject}) async {
    await SharePlus.instance.share(ShareParams(text: text, subject: subject));
  }

  static Future<void> shareFile({required String filePath, String? text, String? subject}) async {
    try {
      final IoFileUtils ioFileUtilsObj = IoFileUtils(filePath);
      final fileType = ioFileUtilsObj.getIoFileType;
      if (fileType == IoFileTypeEnum.file) {
        await SharePlus.instance.share(ShareParams(files: [XFile(filePath)], text: text, subject: subject));
      } else if (fileType == IoFileTypeEnum.asset) {
        final file = await ioFileUtilsObj.convertAssetToFile(filePath);
        final xFile = XFile(file.path);
        await SharePlus.instance.share(ShareParams(files: [xFile], text: text, subject: subject));
      } else {
        await shareUri(filePath);
      }
    } catch (e) {
      log("[ShareUtils]", error: e.toString());
    }
  }

  static Future<void> shareFiles({required List<String> filePaths, String? text, String? subject}) async {
    try {
      final List<XFile> files = [];
      for (String filePath in filePaths) {
        final IoFileUtils ioFileUtilsObj = IoFileUtils(filePath);
        if (filePath.contains('asset')) {
          final assetFile = await ioFileUtilsObj.convertAssetToFile(filePath);
          files.add(XFile(assetFile.path));
        } else {
          final file = File(filePath);
          if (await file.exists()) {
            files.add(XFile(file.path));
          }
        }
      }
      await SharePlus.instance.share(ShareParams(files: files, text: text, subject: subject));
    } catch (e) {
      log("[ShareUtils]", error: e.toString());
    }
  }

  static Future<void> shareUri(String link) async {
    try {
      final linkUri = Uri.tryParse(link);
      if (linkUri != null) {
        await SharePlus.instance.share(ShareParams(uri: linkUri));
      } else {
        throw "Share Invalid Link";
      }
    } catch (e) {
      log("[ShareUtils]", error: e);
    }
  }

  static Future<void> shareApp() async {
    const assetAppLogo = 'assets/launcher_icon/app_launcher_icon.png';
    const text = 'Welcome to sahet eltahadi';
    final subject =
        'Enjoy with your friends'
        '\nYou can download our app via ${AppConstants.getAppProductionUrl}\n';
    await ShareUtils.shareFiles(filePaths: [assetAppLogo], text: '$text\n$subject');
  }
}
