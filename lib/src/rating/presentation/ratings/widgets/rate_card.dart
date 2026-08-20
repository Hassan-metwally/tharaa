part of '../ratings_page.dart';

class _RateCard extends StatelessWidget {
  final RateEntity entity;
  const _RateCard({required this.entity});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // AppRouter.pushNamed('', arguments: ShowRateDetailsPage(id: entity.id));
      },
      child: Container(
        width: double.infinity,
        height: 64,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
          boxShadow: [BoxShadow(color: AppColors.black.withOpacityPercent(6), blurRadius: 2)],
        ),
        child: Row(
          children: [
            AppImage.circle(
              path: entity.user.avatar.path,
              dimension: 48,
              border: Border.all(color: AppColors.black100, width: 1.3),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(entity.user.name, style: TextStyles.regular14, overflow: TextOverflow.ellipsis, maxLines: 1),
                    ),
                    Expanded(
                      child: Text(entity.comment, style: TextStyles.regular12, overflow: TextOverflow.ellipsis, maxLines: 1),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}
