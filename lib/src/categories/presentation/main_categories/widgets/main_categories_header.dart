part of '../main_categories_page.dart';

const double _kHeaderTopPadding = 20;
const double _kHeaderBottomPadding = 24;
const double _kBackButtonSize = 48;
const double _kBackIconSize = 24;

class _MainCategoriesHeader extends StatelessWidget {
  const _MainCategoriesHeader();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.white,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(Dimensions.p16, _kHeaderTopPadding, Dimensions.p16, _kHeaderBottomPadding),
          child: SizedBox(
            height: _kBackButtonSize,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: _kBackButtonSize),
                  child: Text(
                    appLocalizer.mainCategories,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyles.semiBold20.copyWith(
                      color: AppColors.black900,
                      height: 1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: _MainCategoriesBackButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MainCategoriesBackButton extends StatelessWidget {
  const _MainCategoriesBackButton();

  @override
  Widget build(BuildContext context) {
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).maybePop(),
      child: Container(
        width: _kBackButtonSize,
        height: _kBackButtonSize,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: _kCategoryCardFill,
          shape: BoxShape.circle,
        ),
        child: Transform.flip(
          flipX: isRtl,
          child: AppSvgIcon(
            path: AppIcons.arrowBack,
            width: _kBackIconSize,
            height: _kBackIconSize,
          ),
        ),
      ),
    );
  }
}
