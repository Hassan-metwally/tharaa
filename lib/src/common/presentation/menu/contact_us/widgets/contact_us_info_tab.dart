part of '../contact_us_page.dart';

class _ContactUsInfoTab extends StatelessWidget {
  const _ContactUsInfoTab({required this.data});

  final ContactUsEntity data;

  @override
  Widget build(BuildContext context) {
    final List<_DirectContactItem> directContacts = _directContacts;
    final List<_SocialContactItem> socialContacts = _socialContacts;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(Dimensions.p16, 0, Dimensions.p16, Dimensions.p32),
      child: Column(
        children: [
          if (directContacts.isNotEmpty) ...[
            _ContactUsSection(
              title: appLocalizer.contactNumbers,
              child: Column(
                children: [
                  for (int i = 0; i < directContacts.length; i++) ...[
                    if (i > 0) const SizedBox(height: Dimensions.p8),
                    _DirectContactCard(item: directContacts[i]),
                  ],
                ],
              ),
            ),
          ],
          if (directContacts.isNotEmpty && socialContacts.isNotEmpty) const SizedBox(height: Dimensions.p24),
          if (socialContacts.isNotEmpty)
            _ContactUsSection(
              title: appLocalizer.contactWays,
              child: _SocialContactsGrid(items: socialContacts),
            ),
        ],
      ),
    );
  }

  List<_DirectContactItem> get _directContacts {
    return [
      ...data.mobiles.where((number) => number.isNotEmpty).map(
        (number) => _DirectContactItem(
          value: number,
          label: appLocalizer.contactNumber,
          iconPath: AppIcons.callCalling,
          actionLabel: appLocalizer.callNow,
          onTap: () => LaunchUrlUtils.openPhoneNumber(number),
        ),
      ),
      if (data.email.isNotEmpty)
        _DirectContactItem(
          value: data.email,
          label: appLocalizer.emailAddress,
          iconPath: AppIcons.sms,
          actionLabel: appLocalizer.emailNow,
          onTap: () => LaunchUrlUtils.openEmailAddress(data.email),
        ),
    ];
  }

  List<_SocialContactItem> get _socialContacts {
    final items = <_SocialContactItem>[];

    void addLink(String url, PopularLinksSitesEnum type) {
      if (url.isEmpty) return;
      items.add(
        _SocialContactItem(
          name: _socialName(type),
          handle: _socialHandle(url, type),
          icon: type.iconWidget(size: 26),
          onTap: () => LaunchUrlUtils.openUrl(url: url),
        ),
      );
    }

    addLink(data.facebook, PopularLinksSitesEnum.facebook);
    addLink(data.instagram, PopularLinksSitesEnum.instagram);
    addLink(data.x, PopularLinksSitesEnum.x);
    addLink(data.snapchat, PopularLinksSitesEnum.snapChat);
    addLink(data.tiktok, PopularLinksSitesEnum.tikTok);
    for (final number in data.whatsapp) {
      if (number.isEmpty) continue;
      items.add(
        _SocialContactItem(
          name: appLocalizer.socialWhatsApp,
          handle: number,
          icon: PopularLinksSitesEnum.whatsApp.iconWidget(size: 26),
          onTap: () => LaunchUrlUtils.openInWhatsApp(number),
        ),
      );
    }
    addLink(data.youtube, PopularLinksSitesEnum.youtube);
    addLink(data.playProvider, PopularLinksSitesEnum.googlePlay);
    addLink(data.appProvider, PopularLinksSitesEnum.apple);
    return items;
  }
}

class _ContactUsSection extends StatelessWidget {
  const _ContactUsSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Dimensions.p16),
      decoration: BoxDecoration(
        color: _kContactUsFill,
        borderRadius: BorderRadius.circular(Dimensions.r16),
        boxShadow: const [BoxShadow(color: _kSectionShadow, offset: Offset(0, 4), blurRadius: 10)],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 28,
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(title, style: TextStyles.semiBold16.copyWith(color: AppColors.black900, height: 1)),
            ),
          ),
          const SizedBox(height: Dimensions.p12),
          child,
        ],
      ),
    );
  }
}

class _DirectContactItem {
  const _DirectContactItem({
    required this.value,
    required this.label,
    required this.iconPath,
    required this.actionLabel,
    required this.onTap,
  });

  final String value;
  final String label;
  final String iconPath;
  final String actionLabel;
  final VoidCallback onTap;
}

class _DirectContactCard extends StatelessWidget {
  const _DirectContactCard({required this.item});

  final _DirectContactItem item;

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onTap: item.onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(Dimensions.p12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(Dimensions.r16)),
        child: Row(
          children: [
            SizedBox(
              width: Dimensions.ic24,
              height: Dimensions.ic24,
              child: AppSvgIcon(path: item.iconPath, width: Dimensions.ic24, height: Dimensions.ic24),
            ),
            const SizedBox(width: Dimensions.p8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.label, style: TextStyles.medium12.copyWith(color: AppColors.mutedText, height: 1)),
                  const SizedBox(height: 2),
                  Text(item.value, style: TextStyles.semiBold16.copyWith(color: AppColors.black900, height: 1)),
                ],
              ),
            ),
            const SizedBox(width: Dimensions.p8),
            IgnorePointer(child: _ContactActionButton(label: item.actionLabel)),
          ],
        ),
      ),
    );
  }
}

class _ContactActionButton extends StatelessWidget {
  const _ContactActionButton({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.p8, vertical: Dimensions.p8),
      decoration: BoxDecoration(color: _kCallNow, borderRadius: BorderRadius.circular(Dimensions.r16)),
      child: Text(label, style: TextStyles.semiBold14.copyWith(color: Colors.white, height: 1)),
    );
  }
}

class _SocialContactItem {
  const _SocialContactItem({required this.name, required this.handle, required this.icon, required this.onTap});

  final String name;
  final String handle;
  final Widget icon;
  final VoidCallback onTap;
}

class _SocialContactsGrid extends StatelessWidget {
  const _SocialContactsGrid({required this.items});

  final List<_SocialContactItem> items;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (int i = 0; i < items.length; i += 3) {
      final rowItems = items.sublist(i, i + 3 > items.length ? items.length : i + 3);
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int j = 0; j < 3; j++) ...[
              if (j > 0) const SizedBox(width: Dimensions.p12),
              Expanded(child: j < rowItems.length ? _SocialContactCard(item: rowItems[j]) : const SizedBox()),
            ],
          ],
        ),
      );
    }

    return Column(spacing: Dimensions.p8, children: rows);
  }
}

class _SocialContactCard extends StatelessWidget {
  const _SocialContactCard({required this.item});

  final _SocialContactItem item;

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onTap: item.onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(Dimensions.p12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(Dimensions.r16)),
        child: Column(
          children: [
            SizedBox(width: 26, height: 26, child: item.icon),
            const SizedBox(height: Dimensions.p4),
            Text(
              item.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.regular12.copyWith(color: AppColors.mutedText, height: 1),
            ),
            const SizedBox(height: 2),
            Text(
              item.handle,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.semiBold14.copyWith(color: AppColors.black900, height: 1),
            ),
          ],
        ),
      ),
    );
  }
}

String _socialName(PopularLinksSitesEnum type) {
  switch (type) {
    case PopularLinksSitesEnum.x:
      return appLocalizer.socialX;
    case PopularLinksSitesEnum.instagram:
      return appLocalizer.socialInstagram;
    case PopularLinksSitesEnum.facebook:
      return appLocalizer.socialFacebook;
    case PopularLinksSitesEnum.whatsApp:
      return appLocalizer.socialWhatsApp;
    case PopularLinksSitesEnum.tikTok:
      return appLocalizer.socialTikTok;
    case PopularLinksSitesEnum.snapChat:
      return appLocalizer.socialSnapchat;
    case PopularLinksSitesEnum.youtube:
    case PopularLinksSitesEnum.youtubeMusic:
      return appLocalizer.socialYoutube;
    case PopularLinksSitesEnum.googlePlay:
      return appLocalizer.socialGooglePlay;
    case PopularLinksSitesEnum.apple:
      return appLocalizer.socialAppStore;
    default:
      return type.name;
  }
}

String _socialHandle(String url, PopularLinksSitesEnum type) {
  final bool usesAt =
      type == PopularLinksSitesEnum.x ||
      type == PopularLinksSitesEnum.instagram ||
      type == PopularLinksSitesEnum.tikTok ||
      type == PopularLinksSitesEnum.snapChat;

  final uri = Uri.tryParse(url);
  String raw;
  if (uri == null || !uri.hasScheme) {
    raw = url.trim();
  } else {
    const ignored = {'add', 'in', 'user', 'c', 'channel', 'pages', 'watch'};
    final segments = uri.pathSegments.where((segment) => segment.isNotEmpty && !ignored.contains(segment.toLowerCase())).toList();
    raw = segments.isNotEmpty ? segments.last : url.trim();
  }

  if (raw.startsWith('@')) {
    return usesAt ? raw : raw.substring(1);
  }
  return usesAt ? '@$raw' : raw;
}
