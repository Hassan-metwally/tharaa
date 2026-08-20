part of 'popular_sites_utils.dart';

enum PopularLinksSitesEnum {
  facebook,
  messenger,
  x,
  youtube,
  youtubeMusic,
  instagram,
  tikTok,
  soundCloud,
  amazonMusic,
  appleMusic,
  spotify,
  pandora,
  amazon,
  clubhouse,
  discord,
  gitHup,
  gmail,
  googleDrive,
  google,
  googleMeet,
  googlePlay,
  microsoft,
  microsoftTeams,
  microsoftOneDrive,
  microsoftSkype,
  microsoftOutlook,
  microsoftOneNote,
  microsoftExcel,
  microsoftWord,
  microsoftPowerPoint,
  linkedIn,
  pinterest,
  reddit,
  snapChat,
  telegram,
  threads,
  utorrent,
  whatsApp,
  zoom,
  apple,
  unKnown,
}

extension PopularLinksSitesEnumExtension on PopularLinksSitesEnum {
  String get svgPath {
    switch (this) {
      case PopularLinksSitesEnum.facebook:
        return _PopularLinksSitesSvgPaths.facebook;
      case PopularLinksSitesEnum.x:
        return _PopularLinksSitesSvgPaths.x;
      case PopularLinksSitesEnum.youtube:
        return _PopularLinksSitesSvgPaths.youtube;
      case PopularLinksSitesEnum.youtubeMusic:
        return _PopularLinksSitesSvgPaths.youtubeMusic;
      case PopularLinksSitesEnum.instagram:
        return _PopularLinksSitesSvgPaths.instagram;
      case PopularLinksSitesEnum.tikTok:
        return _PopularLinksSitesSvgPaths.tikTok;
      case PopularLinksSitesEnum.soundCloud:
        return _PopularLinksSitesSvgPaths.soundCloud;
      case PopularLinksSitesEnum.amazonMusic:
        return _PopularLinksSitesSvgPaths.amazonMusic;
      case PopularLinksSitesEnum.appleMusic:
        return _PopularLinksSitesSvgPaths.appleMusic;
      case PopularLinksSitesEnum.spotify:
        return _PopularLinksSitesSvgPaths.spotify;
      case PopularLinksSitesEnum.pandora:
        return _PopularLinksSitesSvgPaths.pandora;
      case PopularLinksSitesEnum.amazon:
        return _PopularLinksSitesSvgPaths.amazon;
      case PopularLinksSitesEnum.clubhouse:
        return _PopularLinksSitesSvgPaths.clubhouse;
      case PopularLinksSitesEnum.discord:
        return _PopularLinksSitesSvgPaths.discord;
      case PopularLinksSitesEnum.gitHup:
        return _PopularLinksSitesSvgPaths.gitHup;
      case PopularLinksSitesEnum.gmail:
        return _PopularLinksSitesSvgPaths.gmail;
      case PopularLinksSitesEnum.googleDrive:
        return _PopularLinksSitesSvgPaths.googleDrive;
      case PopularLinksSitesEnum.google:
        return _PopularLinksSitesSvgPaths.google;
      case PopularLinksSitesEnum.microsoft:
        return _PopularLinksSitesSvgPaths.microsoft;
      case PopularLinksSitesEnum.googleMeet:
        return _PopularLinksSitesSvgPaths.googleMeet;
      case PopularLinksSitesEnum.googlePlay:
        return _PopularLinksSitesSvgPaths.googlePlay;
      case PopularLinksSitesEnum.microsoftTeams:
        return _PopularLinksSitesSvgPaths.microsoftTeams;
      case PopularLinksSitesEnum.linkedIn:
        return _PopularLinksSitesSvgPaths.linkedIn;
      case PopularLinksSitesEnum.microsoftOneDrive:
        return _PopularLinksSitesSvgPaths.oneDrive;
      case PopularLinksSitesEnum.pinterest:
        return _PopularLinksSitesSvgPaths.pinterest;
      case PopularLinksSitesEnum.reddit:
        return _PopularLinksSitesSvgPaths.reddit;
      case PopularLinksSitesEnum.microsoftSkype:
        return _PopularLinksSitesSvgPaths.skype;
      case PopularLinksSitesEnum.snapChat:
        return _PopularLinksSitesSvgPaths.snapShat;
      case PopularLinksSitesEnum.telegram:
        return _PopularLinksSitesSvgPaths.telegram;
      case PopularLinksSitesEnum.threads:
        return _PopularLinksSitesSvgPaths.threads;
      case PopularLinksSitesEnum.utorrent:
        return _PopularLinksSitesSvgPaths.utorrent;
      case PopularLinksSitesEnum.whatsApp:
        return _PopularLinksSitesSvgPaths.whatsApp;
      case PopularLinksSitesEnum.zoom:
        return _PopularLinksSitesSvgPaths.zoom;
      case PopularLinksSitesEnum.microsoftOutlook:
        return _PopularLinksSitesSvgPaths.outlook;
      case PopularLinksSitesEnum.microsoftOneNote:
        return _PopularLinksSitesSvgPaths.oneNote;
      case PopularLinksSitesEnum.microsoftExcel:
        return _PopularLinksSitesSvgPaths.excel;
      case PopularLinksSitesEnum.microsoftWord:
        return _PopularLinksSitesSvgPaths.word;
      case PopularLinksSitesEnum.microsoftPowerPoint:
        return _PopularLinksSitesSvgPaths.powerPoint;
      case PopularLinksSitesEnum.messenger:
        return _PopularLinksSitesSvgPaths.messenger;
      case PopularLinksSitesEnum.apple:
        return _PopularLinksSitesSvgPaths.apple;

      case PopularLinksSitesEnum.unKnown:
        return _PopularLinksSitesSvgPaths.unKnown;
    }
  }

  Widget iconWidget({double? size, Color? color}) {
    return AppSvgIcon(
      path: svgPath,
      size: size,
      color: color,
      placholder: const AppSvgIcon(path: _PopularLinksSitesSvgPaths.unKnown),
    );
  }
}
