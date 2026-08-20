import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/core.dart';
import '../../../../../../core/di/di.dart';
import '../../../../../../material/buttons/app_button.dart';
import '../../../../../../material/inputs/app_text_form_field.dart';
import '../../../../../../material/media/svg_icon.dart';
import '../../../../../../material/overlay/show_modal_bottom_sheet.dart';
import '../../../../../../material/rating_bar/app_rating_bar.dart';
import '../../../../../../material/toast/app_toast.dart';
import '../../domain/usecases/add_rate_usecase.dart';
import 'add_rate_cubit.dart';

class AddRateBottomSheet extends StatefulWidget {
  final int itemId;
  const AddRateBottomSheet({super.key, required this.itemId});

  static Future<void> show(BuildContext context, int orderId) {
    return showAppModalBottomSheet(
      context: context,
      child: BlocProvider(
        create: (context) => injector<AddRateCubit>(),
        child: AddRateBottomSheet(itemId: orderId),
      ),
    );
  }

  @override
  State<AddRateBottomSheet> createState() => _AddRateBottomSheetState();
}

class _AddRateBottomSheetState extends State<AddRateBottomSheet> {
  final commentController = TextEditingController();
  double rate = 0;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddRateCubit, AddRateState>(
      listener: (context, state) {
        if (state.addRateState.isFailure) {
          AppToasts.error(context, message: state.addRateState.errorMessage ?? '');
        } else if (state.addRateState.isSuccess && state.addRateState.data != null) {
          AppToasts.success(context, message: state.addRateState.data ?? appLocalizer.successfullyRated);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppSvgIcon(path: '', size: 40),
              const SizedBox(height: 12),
              Text('', style: TextStyles.bold16),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: AppRatingBar(
                      onRatingUpdate: (value) {
                        setState(() {
                          rate = value;
                        });
                      },
                      itemSize: 35,
                      initialRating: rate,
                    ),
                  ),
                  const SizedBox(height: 12),
                  AppTextFormField(
                    label: "appLocalizer.addComment",
                    hint: appLocalizer.writeHere,
                    minLines: 4,
                    maxLines: 4,
                    maxLength: 500,
                    validator: (text) => Validator(text).defaultValidator,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors.enabledBorderColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors.primary),
                    ),

                    controller: commentController,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: appLocalizer.addRate,
                      isLoading: state.addRateState.isLoading,
                      onPressed: () {
                        if (!(_formKey.currentState?.validate() ?? false)) return;
                        final params = UpsertRateParams(rateItemId: widget.itemId, rating: rate.toInt(), comment: commentController.text);
                        context.read<AddRateCubit>().addRate(params);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => AppRouter.pop(context: context),
                      child: AppButton(
                        text: appLocalizer.cancel,
                        textStyle: TextStyles.regular16.copyWith(color: AppColors.black),
                        buttonColor: AppColors.black50,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
