import 'package:equatable/equatable.dart';

class ContactUsEntity extends Equatable {
  const ContactUsEntity({
    required this.x,
    required this.tiktok,
    required this.instagram,
    required this.facebook,
    required this.snapchat,
    required this.email,
    required this.youtube,
    required this.whatsapp,
    required this.mobiles,
    required this.appProvider,
    required this.playProvider,
  });

  final String x;
  final String tiktok;
  final String instagram;
  final String facebook;
  final String snapchat;
  final String youtube;
  final String appProvider;
  final String playProvider;
  final String email;
  final List<String> whatsapp;
  final List<String> mobiles;

  List<String> get getSocialLinks {
    return [
      if (x.isNotEmpty) x,
      if (tiktok.isNotEmpty) tiktok,
      if (instagram.isNotEmpty) instagram,
      if (facebook.isNotEmpty) facebook,
      if (snapchat.isNotEmpty) snapchat,
      if (youtube.isNotEmpty) youtube,
      if (appProvider.isNotEmpty) appProvider,
      if (playProvider.isNotEmpty) playProvider,
    ];
  }

  @override
  List<Object?> get props => [x, tiktok, instagram, facebook, snapchat, youtube, email, whatsapp, mobiles, playProvider, appProvider];

  factory ContactUsEntity.fromJson(Map<String, dynamic> json) {
    final whatsapp = json['whatsapp_number'];
    return ContactUsEntity(
      email: json['email'] ?? '',
      x: json['x_link'] ?? '',
      tiktok: json['tiktok_link'] ?? '',
      instagram: json['instagram_link'] ?? '',
      facebook: json['facebook_link'] ?? '',
      snapchat: json['snapchat_link'] ?? '',
      youtube: json['youtube_link'] ?? '',
      appProvider: json['app_provider'] ?? '',
      playProvider: json['play_provider'] ?? '',
      mobiles: json['contact_numbers'] != null ? List<String>.from(json['contact_numbers']) : [],
      whatsapp: whatsapp is List
          ? List<String>.from(json['whatsapp'])
          : whatsapp is String
          ? [whatsapp]
          : [],
    );
  }
}
