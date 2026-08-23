part of '../more_page.dart';

String _formatSaudiMobile(String mobile) {
  final local = mobile.startsWith('0') ? mobile.substring(1) : mobile;
  return '+966$local';
}

class _UseCard extends StatelessWidget {
  const _UseCard();

  @override
  Widget build(BuildContext context) {
    return LoggedUserCheckerWidget(
      loggedBuilder: (user) => _LoggedClientCard(user: user),
      guestWidget: const _GuestCard(),
    );
  }
}

class _LoggedClientCard extends StatelessWidget {
  const _LoggedClientCard({required this.user});

  final CachedUser user;

  @override
  Widget build(BuildContext context) {
    return AnimatedSlideWithOpacityWidget(
      child: _MoreUserCardShell(
        child: Column(
          children: [
            _UserCardIdentity(name: user.name, mobile: _formatSaudiMobile(user.mobile), avatar: user.avatar),
            const SizedBox(height: Dimensions.p4),
            const _UserCardStatistics(),
          ],
        ),
      ),
    );
  }
}

class _GuestCard extends StatelessWidget {
  const _GuestCard();

  @override
  Widget build(BuildContext context) {
    return AnimatedSlideWithOpacityWidget(
      child: Bounce(
        onTap: () {
          AppAuthenticationBloc.of(context).add(const LoggedOutEvent());
        },
        child: _MoreUserCardShell(
          child: _UserCardIdentity(name: appLocalizer.userName, mobile: appLocalizer.phoneNumber, avatar: ''),
        ),
      ),
    );
  }
}

class _MoreUserCardShell extends StatelessWidget {
  const _MoreUserCardShell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimensions.r16),
      child: ColoredBox(
        color: AppColors.black900,
        child: Stack(
          children: [
            Positioned.fill(
              child: IgnorePointer(
                child: Opacity(
                  opacity: 0.05,
                  child: Transform.rotate(
                    angle: math.pi,
                    child: Center(
                      child: AppSvgIcon(path: AppImages.moreUserCardPattern, fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.all(Dimensions.p16), child: child),
          ],
        ),
      ),
    );
  }
}

class _UserCardIdentity extends StatelessWidget {
  const _UserCardIdentity({required this.name, required this.mobile, required this.avatar});

  final String name;
  final String mobile;
  final String avatar;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (avatar.isNotEmpty)
          AppImage.circle(
            path: avatar,
            dimension: 68,
            bgColor: Colors.white.withOpacityPercent(10),
            placholderWidget: AppSvgIcon(path: AppIcons.userOutline, size: 32, color: Colors.white),
          )
        else
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacityPercent(10),
              border: Border.all(color: Colors.white.withOpacityPercent(20)),
            ),
            alignment: Alignment.center,
            child: AppSvgIcon(path: AppIcons.userOutline, size: 32, color: Colors.white),
          ),
        const SizedBox(height: Dimensions.p4),
        Text(
          name,
          style: TextStyles.semiBold14.copyWith(color: Colors.white, height: 1),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                mobile,
                textDirection: TextDirection.ltr,
                style: TextStyles.regular12.copyWith(color: Colors.white.withOpacityPercent(80), height: 1),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 2),
            AppSvgIcon(path: AppIcons.mobile, size: Dimensions.ic16, color: Colors.white.withOpacityPercent(80)),
          ],
        ),
      ],
    );
  }
}

class _UserCardStatistics extends StatelessWidget {
  const _UserCardStatistics();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => injector<ProviderStatisticsCubit>()..getStatistics(), child: const _UserCardStatisticsBody());
  }
}

class _UserCardStatisticsBody extends StatefulWidget {
  const _UserCardStatisticsBody();

  @override
  State<_UserCardStatisticsBody> createState() => _UserCardStatisticsBodyState();
}

class _UserCardStatisticsBodyState extends State<_UserCardStatisticsBody> {
  final _statisticsSubscriptionObj = CompositeSubscription();
  late final ProviderStatisticsCubit _cubit;

  void _statisticsSubscriptionListener() {
    _statisticsSubscriptionObj.add(
      GetStatisticsSubscription.stream().listen((params) {
        _cubit.getStatistics();
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ProviderStatisticsCubit>();
    _statisticsSubscriptionListener();
  }

  @override
  void dispose() {
    _statisticsSubscriptionObj.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProviderStatisticsCubit, ProviderStatisticsState>(
      builder: (context, state) {
        if (state.getStatisticsState.isLoading) {
          return const SizedBox(
            height: 51,
            child: Center(child: SpinKitLoadingWidget.small(color: Colors.white)),
          );
        }

        if (state.getStatisticsState.isFailure) {
          return SizedBox(
            height: 51,
            child: Center(
              child: Bounce(
                onTap: () => context.read<ProviderStatisticsCubit>().getStatistics(),
                child: Text(appLocalizer.tryAnotherTime, style: TextStyles.regular12.copyWith(color: Colors.white.withOpacityPercent(80))),
              ),
            ),
          );
        }

        final data = state.getStatisticsState.data ?? const StatisticsEntity.initial();
        return SizedBox(
          height: 51,
          child: Row(
            children: [
              Expanded(
                child: _UserCardStatItem(value: data.newOrdersCount ?? 0, label: appLocalizer.newOrders),
              ),
              const _UserCardStatDivider(),
              Expanded(
                child: _UserCardStatItem(value: data.inProgressOrdersCount ?? 0, label: appLocalizer.ordersInProgress),
              ),
              const _UserCardStatDivider(),
              Expanded(
                child: _UserCardStatItem(
                  value: data.finishedOrdersCount ?? data.completedOrdersCount ?? 0,
                  label: appLocalizer.finishedOrders,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _UserCardStatItem extends StatelessWidget {
  const _UserCardStatItem({required this.value, required this.label});

  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.p8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$value', style: TextStyles.semiBold16.copyWith(color: Colors.white, height: 1)),
          const SizedBox(height: Dimensions.p6),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyles.regular12.copyWith(color: Colors.white.withOpacityPercent(80), height: 1),
          ),
        ],
      ),
    );
  }
}

class _UserCardStatDivider extends StatelessWidget {
  const _UserCardStatDivider();

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 32, color: Colors.white.withOpacityPercent(16));
  }
}
