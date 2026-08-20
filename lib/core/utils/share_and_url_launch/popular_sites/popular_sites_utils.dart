import 'package:flutter/material.dart';

import '../../../../material/media/svg_icon.dart';
import '../../../core.dart';

part 'assets_paths.dart';
part 'popular_sites_enum.dart';

typedef PopularSitesLinksUtilsBuilderType = Widget Function(String url, VoidCallback launchFun, Widget siteWidget);

class PopularSitesLinksUtils {
  final String url;
  late final Uri? urlUri;

  PopularSitesLinksUtils(this.url) {
    urlUri = Uri.tryParse(url);
  }

  Widget build(BuildContext context, {double? size, bool canLaunchUrl = true, Color? color}) {
    return GestureDetector(
      onTap: () {
        if (canLaunchUrl) {
          LaunchUrlUtils.openUrl(url: url);
        }
      },
      child: getSiteType.iconWidget(size: size, color: color),
    );
  }

  Widget builder(BuildContext context, PopularSitesLinksUtilsBuilderType buildFunction, {double? iconSize, Color? color}) {
    return buildFunction(url, () => LaunchUrlUtils.openUrl(url: url), getSiteType.iconWidget(size: iconSize, color: color));
  }

  // final _pattern = r'^(http|https):\/\/([\w.]+)+(:[0-9]{1,5})?(\/.*)?$';
  // late final _regExp = RegExp(_pattern);
  bool get isValidLink => urlUri?.hasAbsolutePath ?? false;

  /// [Facebook]
  /// [PopularLinksSitesEnum.facebook]
  /// [PopularLinksSitesEnum.messenger]
  ///
  ///
  bool get isFacebookLink {
    final RegExp facebookRegex = RegExp(r'^https?://(www\.)?facebook\.com/');
    return facebookRegex.hasMatch(url) || url.contains("facebook.com");
  }

  bool get isMessengerLink {
    return url.contains('m.me') || url.contains('messenger.com') || url.startsWith("https://www.messenger.com/");
  }

  /// [isFacebookVideoLink] Detect If [url] is for facebook video not post or story or else
  bool get isFacebookVideoLink {
    if (isFacebookLink && (url.contains('/videos/') || url.contains('/watch/'))) {
      return true;
    }
    return false;
  }

  /// [Twitter] OR [X]
  /// [PopularLinksSitesEnum.x]
  ///
  ///
  bool get isXLink {
    final RegExp twitterRegex = RegExp(r'^https?://(www\.)?twitter\.com/');
    return twitterRegex.hasMatch(url) || url.contains('https://x.com') || url.contains('x.com') || url.contains('twitter.com');
  }

  /// [YouTube]
  /// [PopularLinksSitesEnum.youtube]
  ///
  ///
  /// [isYouTubeLink] Detect any [url] if is YouTube link
  bool get isYouTubeLink {
    final RegExp youtubeRegex = RegExp(r'^https?://(www\.)?youtube\.com/');
    return youtubeRegex.hasMatch(url) || url.contains('https://youtu.be') || url.contains('youtube.com');
  }

  /// [isYouTubeVideoLink] Detect Only YouTube video [url] not page or channel or story
  bool get isYouTubeVideoLink {
    return getYouTubeVideoID != null;
  }

  /// Converts fully qualified YouTube Url to video id.
  /// If videoId is null mean [url] not for [youtube] video
  String? get getYouTubeVideoID {
    if (!url.contains("http") && (url.length == 11)) return url;
    final trimmedUrl = url.trim();

    for (var regex in [
      r'^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$',
      r'^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$',
      r'^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$',
    ]) {
      final Match? match = RegExp(regex).firstMatch(trimmedUrl);
      if (match != null && match.groupCount >= 1) return match.group(1);
    }
    return null;
  }

  /// [isYouTubeMusicLink] Detect if [url] is [YouTube] Music Link
  bool get isYouTubeMusicLink {
    return url.startsWith('https://music.youtube.com');
  }

  /// [Instagram]
  /// [PopularLinksSitesEnum.instagram]
  ///
  ///
  bool get isInstagramLink {
    final RegExp instagramRegex = RegExp(r'^https?://(www\.)?instagram\.com/');
    return instagramRegex.hasMatch(url) || url.contains("instagram.com");
  }

  /// [TikTok]
  /// [PopularLinksSitesEnum.tikTok]
  ///
  ///
  bool get isTikTokLink {
    final RegExp tiktokRegex = RegExp(r'^https?://(www\.)?tiktok\.com/');
    return tiktokRegex.hasMatch(url) || url.contains("tiktok.com");
  }

  /// [SoundCloud]
  /// [PopularLinksSitesEnum.soundCloud]
  ///
  ///
  bool get isSoundCloudLink {
    return url.startsWith("https://soundcloud.com/");
  }

  /// [Amazon]
  /// [PopularLinksSitesEnum.amazon]
  /// [PopularLinksSitesEnum.amazonMusic]
  ///
  ///
  bool get isAmazonLink {
    return url.startsWith("https://www.amazon.com");
  }

  bool get isAmazonMusicLink {
    return url.startsWith("https://music.amazon.com/albums/") || url.startsWith("https://music.amazon.com");
  }

  /// [Apple]
  /// [PopularLinksSitesEnum.apple]
  /// [PopularLinksSitesEnum.appleMusic]
  ///
  ///
  bool get isAppleLink {
    return url.contains('apps.apple.com') ||
        url.contains('itunes.apple.com') ||
        url.contains('https://www.apple.com/') ||
        url.contains('appprovider');
  }

  bool get isAppleMusicLink {
    return url.startsWith("https://music.apple.com/");
  }

  /// [Spotify]
  /// [PopularLinksSitesEnum.spotify]
  ///
  ///
  bool get isSpotifyLink {
    return url.contains("https://open.spotify.com/");
  }

  /// Get [Spotify] Song Uri to play
  /// return null if cant play as song like being Podcast , Search links
  String? get getSpotifyUriFromUrl {
    final uri = Uri.tryParse(url);
    final parts = uri?.pathSegments ?? [];
    final type = parts.firstOrNull;
    final id = parts.elementAtOrNull(1);
    if (type != null && id != null && parts.length >= 2) {
      return 'spotify:$type:$id';
    }
    return null;
  }

  /// [Pandora]
  /// [PopularLinksSitesEnum.pandora]
  ///
  ///
  bool get isPandoraMusicLink {
    return url.startsWith("https://www.pandora.com");
  }

  /// [ClubHouse]
  /// [PopularLinksSitesEnum.clubhouse]
  ///
  ///
  bool get isClubHouseLink {
    return url.startsWith("https://www.pandora.com");
  }

  /// [Discord]
  /// [PopularLinksSitesEnum.discord]
  ///
  ///
  bool get isDiscordLink {
    return url.startsWith("https://www.discord.com") || url.startsWith("https://discord.com");
  }

  /// [GitHub]
  /// [PopularLinksSitesEnum.gitHup]
  ///
  ///
  bool get isGitHubLink {
    return url.startsWith("https://www.github.com") ||
        url.startsWith("https://github.com") ||
        url.startsWith("https://www.github.dev") ||
        url.startsWith("https://github.dev");
  }

  /// [Google] Services Sites
  /// [PopularLinksSitesEnum.google]
  /// [PopularLinksSitesEnum.gmail]
  /// [PopularLinksSitesEnum.googleDrive]
  /// [PopularLinksSitesEnum.googleMeet]
  /// [PopularLinksSitesEnum.googlePlay]
  ///
  ///
  bool get isGoogleLink {
    return url.startsWith("https://www.google.com");
  }

  bool get isGmailLink {
    return url.contains("https://mail.google.com/");
  }

  bool get isGoogleDriveLink {
    return url.contains("https://drive.google.com");
  }

  bool get isGoogleMeetLink {
    return url.startsWith("https://www.meet.google.com");
  }

  bool get isGooglePlayLink {
    return url.startsWith("https://play.google.com");
  }

  /// [Microsoft] Services Sites
  /// [PopularLinksSitesEnum.microsoft]
  /// [PopularLinksSitesEnum.microsoftTeams]
  /// [PopularLinksSitesEnum.microsoftOneDrive]
  /// [PopularLinksSitesEnum.microsoftSkype]
  /// [PopularLinksSitesEnum.microsoftOutlook]
  /// [PopularLinksSitesEnum.microsoftOneNote]
  /// [PopularLinksSitesEnum.microsoftExcel]
  /// [PopularLinksSitesEnum.microsoftPowerPoint]
  /// [PopularLinksSitesEnum.microsoftWord]
  ///
  ///
  bool get isMicrosoftLink {
    return url.startsWith("https://www.microsoft.com");
  }

  bool get isMicrosoftTeamsLink {
    return url.contains('teams.microsoft.com') ||
        url.contains('teams.live.com') ||
        url.contains('teamsweb') ||
        url.contains('join.microsoft.com') ||
        url.contains('meetupcall');
  }

  bool get isMicrosoftOneDriveLink {
    return url.contains('1drv.ms') || url.contains('1drv.ws') || url.contains('onedrive.live.com') || url.contains('sharepoint.com/sites/');
  }

  bool get isOutlookLink {
    return url.contains('outlook.com') || url.contains('office.com') || url.contains('outlook.live.com');
  }

  bool get isOneNoteLink {
    return url.startsWith("https://www.onenote.com");
  }

  bool get isSkypeLink {
    return url.startsWith("https://www.skype.com");
  }

  bool get isExelLink {
    return url.contains('excel.office.com');
  }

  bool get isWordLink {
    return url.contains('word.office.com');
  }

  bool get isPowerPointLink {
    return url.contains('powerpoint.office.com') || url.contains('sharepoint.com/sites/');
  }

  /// [LinkedIn]
  /// [PopularLinksSitesEnum.linkedIn]
  ///
  ///
  bool get isLinkedInLink {
    return url.startsWith("https://www.linkedin.com");
  }

  /// [Pinterest]
  /// [PopularLinksSitesEnum.pinterest]
  ///
  ///
  bool get isPinterestLink {
    return url.startsWith("https://www.pinterest.com");
  }

  /// [Reddit]
  /// [PopularLinksSitesEnum.reddit]
  ///
  ///
  bool get isRedditLink {
    return url.startsWith("https://www.reddit.com");
  }

  /// [Snapchat]
  /// [PopularLinksSitesEnum.snapChat]
  ///
  ///
  bool get isSnapchatLink {
    return url.startsWith("https://www.snapchat.com");
  }

  /// [Telegram]
  /// [PopularLinksSitesEnum.telegram]
  ///
  ///
  bool get isTelegramLink {
    return url.startsWith("https://web.telegram.org") || url.startsWith("https://t.me");
  }

  /// [Threads]
  /// [PopularLinksSitesEnum.threads]
  ///
  ///
  bool get isThreadsLink {
    return url.startsWith("https://www.threads.net");
  }

  /// [Utorrent]
  /// [PopularLinksSitesEnum.utorrent]
  ///
  ///
  bool get isUtorrentLink {
    return url.startsWith("https://www.utorrent.com");
  }

  /// [WhatsApp]
  /// [PopularLinksSitesEnum.whatsApp]
  ///
  ///
  bool get isWhatsAppLink {
    return url.startsWith("https://www.whatsapp.com");
  }

  /// [Zoom]
  /// [PopularLinksSitesEnum.zoom]
  ///
  ///
  bool get isZoomLink {
    return url.startsWith("https://zoom");
  }

  PopularLinksSitesEnum get getSiteType {
    if (isFacebookLink) {
      return PopularLinksSitesEnum.facebook;
    } else if (isMessengerLink) {
      return PopularLinksSitesEnum.messenger;
    } else if (isXLink) {
      return PopularLinksSitesEnum.x;
    } else if (isYouTubeLink) {
      return PopularLinksSitesEnum.youtube;
    } else if (isYouTubeMusicLink) {
      return PopularLinksSitesEnum.youtubeMusic;
    } else if (isInstagramLink) {
      return PopularLinksSitesEnum.instagram;
    } else if (isTikTokLink) {
      return PopularLinksSitesEnum.tikTok;
    } else if (isSoundCloudLink) {
      return PopularLinksSitesEnum.soundCloud;
    } else if (isAmazonMusicLink) {
      return PopularLinksSitesEnum.amazonMusic;
    } else if (isAppleMusicLink) {
      return PopularLinksSitesEnum.appleMusic;
    } else if (isSpotifyLink) {
      return PopularLinksSitesEnum.spotify;
    } else if (isPandoraMusicLink) {
      return PopularLinksSitesEnum.pandora;
    } else if (isAmazonLink) {
      return PopularLinksSitesEnum.amazon;
    } else if (isClubHouseLink) {
      return PopularLinksSitesEnum.clubhouse;
    } else if (isGitHubLink) {
      return PopularLinksSitesEnum.gitHup;
    } else if (isGoogleLink) {
      return PopularLinksSitesEnum.google;
    } else if (isGmailLink) {
      return PopularLinksSitesEnum.gmail;
    } else if (isGoogleDriveLink) {
      return PopularLinksSitesEnum.googleDrive;
    } else if (isGoogleMeetLink) {
      return PopularLinksSitesEnum.googleMeet;
    } else if (isGooglePlayLink) {
      return PopularLinksSitesEnum.googlePlay;
    } else if (isAppleLink) {
      return PopularLinksSitesEnum.apple;
    } else if (isMicrosoftTeamsLink) {
      return PopularLinksSitesEnum.microsoftTeams;
    } else if (isMicrosoftOneDriveLink) {
      return PopularLinksSitesEnum.microsoftOneDrive;
    } else if (isOutlookLink) {
      return PopularLinksSitesEnum.microsoftOutlook;
    } else if (isOneNoteLink) {
      return PopularLinksSitesEnum.microsoftOneNote;
    } else if (isSkypeLink) {
      return PopularLinksSitesEnum.microsoftSkype;
    } else if (isExelLink) {
      return PopularLinksSitesEnum.microsoftExcel;
    } else if (isWordLink) {
      return PopularLinksSitesEnum.microsoftWord;
    } else if (isPowerPointLink) {
      return PopularLinksSitesEnum.microsoftPowerPoint;
    } else if (isMicrosoftLink) {
      return PopularLinksSitesEnum.microsoft;
    } else if (isLinkedInLink) {
      return PopularLinksSitesEnum.linkedIn;
    } else if (isPinterestLink) {
      return PopularLinksSitesEnum.pinterest;
    } else if (isRedditLink) {
      return PopularLinksSitesEnum.reddit;
    } else if (isSnapchatLink) {
      return PopularLinksSitesEnum.snapChat;
    } else if (isTelegramLink) {
      return PopularLinksSitesEnum.telegram;
    } else if (isThreadsLink) {
      return PopularLinksSitesEnum.threads;
    } else if (isUtorrentLink) {
      return PopularLinksSitesEnum.utorrent;
    } else if (isWhatsAppLink) {
      return PopularLinksSitesEnum.whatsApp;
    } else if (isZoomLink) {
      return PopularLinksSitesEnum.zoom;
    } else {
      return PopularLinksSitesEnum.unKnown;
    }
  }
}
