import 'package:flutter/widgets.dart';

import '../../../../core/core.dart';
import '../../../../material/media/svg_icon.dart';
import '../../domain/entities/transaction_entity.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key, required this.transaction, required this.getDateFormatted, this.bgColor, this.hasShadow = true});

  final Color? bgColor;
  final TransactionEntity transaction;
  final bool hasShadow;
  final String Function(DateTime date) getDateFormatted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: bgColor ?? AppColors.white),
      child: Row(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.black50),
            child: AppSvgIcon(path: transaction.type.icon, size: 20, color: transaction.type.color),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(transaction.name, style: TextStyles.medium14.copyWith(color: AppColors.black)),
                if (transaction.notes?.isNotEmpty == true)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: Text(transaction.notes ?? '', style: TextStyles.regular10.copyWith(color: AppColors.black)),
                  ),
                Text(transaction.formattedDate, style: TextStyles.regular11.copyWith(color: AppColors.black600)),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 2,
            children: [
              Text(
                '${transaction.type.effect} ${transaction.amount}',
                style: TextStyles.medium18.copyWith(color: transaction.type.color, height: 1),
              ),
              AppSvgIcon(path: "AppIcons.sar1", size: 12, color: transaction.type.color),
            ],
          ),
        ],
      ),
    );
  }
}
