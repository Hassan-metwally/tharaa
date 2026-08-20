part of 'provider_statistics_widget.dart';

class _StatisticsCard extends StatelessWidget {
  final String title;
  final int value;
  final String icon;
  final Color color;
  final Color backgroundColor;

  const _StatisticsCard({required this.title, required this.value, required this.icon, required this.color, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    value.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.bold16.copyWith(color: color),
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.regular12.copyWith(color: AppColors.black600),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 26),
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(color: color.withOpacityPercent(10), borderRadius: BorderRadius.circular(10)),
            child: AppSvgIcon(path: icon, color: color),
          ),
        ],
      ),
    );
  }
}
