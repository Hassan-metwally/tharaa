part of core;

abstract class LaunchUrlUtils {
  LaunchUrlUtils._();

  // static Future<void> openGoogleMapsApp(
  //     {required double latitude,
  //     required double longitude,
  //     LaunchMode linkLaunchMode = LaunchMode.externalApplication}) async {
  //   String googleUrl =
  //       AppGoogleMapsConstants.getMapsAppDynamicLink(latitude, longitude);
  //   if (await canLaunchUrl(Uri.parse(googleUrl))) {
  //     try {
  //       await launchUrl(Uri.parse(googleUrl), mode: linkLaunchMode);
  //     } catch (e) {
  //       await launchUrl(Uri.parse(googleUrl), mode: LaunchMode.platformDefault);
  //     }
  //   } else {
  //     throw 'Could not open the map.';
  //   }
  // }

  static Future<void> openUrl({required String url, LaunchMode linkLaunchMode = LaunchMode.externalApplication}) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      try {
        await launchUrl(Uri.parse(url), mode: linkLaunchMode);
      } catch (e) {
        await launchUrl(Uri.parse(url));
      }
    } else {
      Fluttertoast.showToast(
        msg: appLocalizer.cantOpenLink,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 14.0,
      );
    }
  }

  static Future<void> openPhoneNumber(String phoneNumber) async {
    try {
      await launchUrl(Uri.parse("tel:$phoneNumber"));
    } catch (e) {
      Fluttertoast.showToast(
        msg: appLocalizer.cantOpenLink,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 14.0,
      );
    }
  }

  static Future<void> openInWhatsApp(String phoneNumber) async {
    try {
      if (Platform.isAndroid) {
        launchUrl(Uri.parse('https://wa.me/$phoneNumber'));
      } else {
        launchUrl(Uri.parse('https://api.whatsapp.com/send?phone=$phoneNumber'));
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: appLocalizer.cantOpenLink,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 14.0,
      );
    }
  }

  static Future<void> openEmailAddress(String email) async {
    try {
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: email,
        query: _encodeQueryParameters(<String, String>{'subject': 'Hi there , From Remotly App'}),
      );
      launchUrl(emailLaunchUri);
    } catch (e) {
      Fluttertoast.showToast(
        msg: appLocalizer.cantOpenLink,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 14.0,
      );
    }
  }

  static String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries.map((MapEntry<String, String> e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
  }
}
