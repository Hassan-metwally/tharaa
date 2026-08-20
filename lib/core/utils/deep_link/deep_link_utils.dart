import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';

import 'factory/deeplink_visitor.dart';
import 'factory/deeplink_visitor_impl.dart';
import 'states/i_deeplink_visitor_state.dart';

class DeepLinksUtils {
  DeepLinksUtils._();

  static DeepLinksUtils? _instance;

  static DeepLinksUtils get instance => _instance ??= DeepLinksUtils._();

  bool _isDisposed = false;

  final AppLinks appLinks = AppLinks();

  void _init() async {
    debugPrint(
      '[Deep Links Utils Init Start] ::: _isDisposed => $_isDisposed ::: _isDeepLinkAlreadyGetInitialAppLink => $_isDeepLinkAlreadyGetInitialAppLink',
    );
    _isDisposed = false;
    final Uri? initialLink = await appLinks.getInitialLink();
    if (initialLink != null) {
      if (_isDeepLinkAlreadyGetInitialAppLink == false) {
        _handleDeepLinks(initialLink);
      }
    }
    appLinks.uriLinkStream.listen((Uri uri) {
      _handleDeepLinks(uri);
    });
    _debugFun('Init End ::: _isDisposed => $_isDisposed ::: _isDeepLinkAlreadyGetInitialAppLink => $_isDeepLinkAlreadyGetInitialAppLink');
    _setAsDeepLinkAlreadyGetInitialAppLink();
  }

  static void intit() => instance._init();

  void _setAsDeepLinkAlreadyGetInitialAppLink() {
    instance._isDeepLinkAlreadyGetInitialAppLink = true;
  }

  bool _isDeepLinkAlreadyGetInitialAppLink = false;

  void _handleDeepLinks(Uri link) {
    try {
      debugPrint('Handle Deep Links ::: Start :::');
      if (_isDisposed) return;
      final String linkText = link.toString().toLowerCase();
      if (!linkText.contains(_seqment)) return;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _debugFun('On Receive Deep Link ${link.path}');
        _onReceiveDeepLinks(link);
      });
    } catch (_) {
      _debugFun('Handle Deep Links ::: Error :::');
    }
  }

  void dispose() {
    _isDisposed = true;
    debugPrint(
      'Deep Links Dispose Function Called ::: _isDisposed => $_isDisposed ::: _isFirstTimeGetInitialAppLink => $_isDeepLinkAlreadyGetInitialAppLink',
    );
  }

  /// Manage On Receive Deep Links
  ///
  void _onReceiveDeepLinks(Uri uri) async {
    try {
      final IDeepLinkVisitor visitor = DeepLinkVisitorImp();
      final IDeepLinkVisitorState visitorState = IDeepLinkVisitorState.fromUri(uri);
      visitorState.accept(visitor);
    } catch (_) {
      _debugFun("Failed to Handle Recived Deep Action");
    }
  }

  /// Manage Generate Shared Links
  ///
  // static const String _domain = "remotly.moltaqadev.com";
  static const String _seqment = "deeplink";
  // static String get _getShareLink => "$_domain/$_seqment";

  /// [Group Lecture]
  ///
  // static const String groupLectureDeeplinkSeqment = "group-lecture";
  // static String _getGroupLectureShareLink(int id) {
  //   return "https://$_getShareLink/$groupLectureDeeplinkSeqment/$id";
  // }

  // static void shareGroupLecture(IOnlineLectureEntity lecture) async {
  //   try {
  //     // Clipboard.setData(
  //     //     ClipboardData(text: _getGroupLectureShareLink(lecture.id)));

  //     SharePlus.instance.share(
  //       ShareParams(
  //         title:
  //             "${appLocalizer.groupLecture}\n${appLocalizer.lectureDate}: ${lecture.date.EDMMMHMMA}",
  //         text: _getGroupLectureShareLink(lecture.id),
  //       ),
  //     );
  //   } catch (_) {
  //     _debugFun("Share Group Lecture Failed");
  //   }
  // }

  static void _debugFun(String text) {
    debugPrint('[Deep Link Utils] ::: $text');
  }
}
