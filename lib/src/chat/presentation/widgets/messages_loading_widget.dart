import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../material/shimmer/shimmer_effect_widget.dart';
import '../../utils/chat_decoration_constants.dart';

class MessagesLoadingWidget extends StatefulWidget {
  const MessagesLoadingWidget({super.key});

  @override
  State<MessagesLoadingWidget> createState() => _MessagesLoadingWidgetState();
}

class _MessagesLoadingWidgetState extends State<MessagesLoadingWidget> {
  @override
  Widget build(BuildContext context) {
    const double itemHeight = 40.0;
    final items = _generateRandomNumbersWithConstraints(12, 15);
    return Align(
      alignment: AlignmentDirectional.bottomCenter,
      child: ShimmerWidget(
        child: ListView.separated(
          reverse: true,
          padding: const EdgeInsets.all(20),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final number = items[index];
            final bool isOdd = number.isOdd;
            bool isPreviousOdd = false;
            try {
              final int? previousNumber = index == 0 ? null : items.elementAtOrNull(index - 1);
              isPreviousOdd = previousNumber?.isOdd ?? false;
            } catch (e) {
              isPreviousOdd = false;
              if (index == 0) {
                if (!isOdd) {
                  isPreviousOdd = true;
                }
              }
            }
            final bool isSameAsPrevious = isPreviousOdd && isOdd;
            final MainAxisAlignment crossAxisAlignment;
            if (!isOdd) {
              crossAxisAlignment = MainAxisAlignment.start;
            } else {
              crossAxisAlignment = MainAxisAlignment.end;
            }
            return Padding(
              padding: EdgeInsets.only(bottom: !isSameAsPrevious ? 8.0 : 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: crossAxisAlignment,
                children: [
                  Container(
                    height: itemHeight,
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width * .75,
                      maxWidth: MediaQuery.of(context).size.width * .75,
                    ),
                    decoration: !isOdd ? ChatDecorationConstants.ownerCellDecoration : ChatDecorationConstants.otherCellDecoration,
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 8);
          },
          itemCount: items.length.clamp(0, 8),
        ),
      ),
    );
  }

  List<int> _generateRandomNumbersWithConstraints(int minLength, int maxLength) {
    final Random random = Random();
    final List<int> numbers = [];
    final int length = minLength + random.nextInt(maxLength - minLength + 1); // Generate a random length between minLength and maxLength
    int consecutiveOddCount = 0;
    int consecutiveEvenCount = 0;

    for (int i = 0; i < length; i++) {
      int randomNumber;

      // If the last two generated numbers are odd, or last two generated numbers are even, generate the other type
      if ((consecutiveOddCount >= 2 && numbers.last.isOdd) || (consecutiveEvenCount >= 2 && numbers.last.isEven)) {
        // Generate the opposite type of number
        randomNumber = (numbers.last.isOdd) ? random.nextInt(500) * 2 + 2 : random.nextInt(500) * 2 + 1;
        consecutiveOddCount = 0;
        consecutiveEvenCount = 0;
      } else {
        // Generate a random number
        randomNumber = random.nextInt(1000) + 1;
        if (randomNumber.isOdd) {
          consecutiveOddCount++;
          consecutiveEvenCount = 0;
        } else {
          consecutiveEvenCount++;
          consecutiveOddCount = 0;
        }
      }

      numbers.add(randomNumber);
    }

    return numbers;
  }
}
