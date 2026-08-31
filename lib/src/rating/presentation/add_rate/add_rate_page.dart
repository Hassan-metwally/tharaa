import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/core.dart';
import '../../../../../../core/di/di.dart';
import '../../../../../../material/inputs/app_text_form_field.dart';
import '../../../../../../material/media/svg_icon.dart';
import '../../../../../../material/spin_kit_loading_widget.dart';
import '../../../../../../material/toast/app_toast.dart';
import '../../domain/usecases/add_rate_usecase.dart';
import 'add_rate_cubit.dart';

const Color _kStarSelectedFill = Color(0xFFFFF3EF);
const Color _kCommentHint = Color(0xFF8B9BB2);
const double _kIllustrationWidth = 136;
const double _kIllustrationHeight = 140;
const double _kStarCircleSize = 40;
const double _kStarIconSize = 24;
const double _kStarBorderWidth = 2;
const double _kBackButtonSize = 48;
const double _kBackIconSize = 24;
const double _kActionButtonHeight = 50;
const int _kStarCount = 5;

class AddRatePage extends StatelessWidget {
  final int itemId;
  const AddRatePage({super.key, required this.itemId});

  static Future<void> show(BuildContext context, int orderId) {
    return Navigator.of(context).push<void>(MaterialPageRoute(builder: (_) => AddRatePage(itemId: orderId)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<AddRateCubit>(),
      child: _AddRateView(itemId: itemId),
    );
  }
}

class _AddRateView extends StatefulWidget {
  final int itemId;
  const _AddRateView({required this.itemId});

  @override
  State<_AddRateView> createState() => _AddRateViewState();
}

class _AddRateViewState extends State<_AddRateView> {
  final commentController = TextEditingController();
  double rate = 0;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  void _submit(bool isLoading) {
    if (isLoading) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final params = UpsertRateParams(rateItemId: widget.itemId, rating: rate.toInt(), comment: commentController.text);
    context.read<AddRateCubit>().addRate(params);
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
        final bool isLoading = state.addRateState.isLoading;
        return Scaffold(
          backgroundColor: AppColors.white,
          resizeToAvoidBottomInset: true,
          body: Column(
            children: [
              const _AddRateHeader(),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(Dimensions.p16, Dimensions.p12, Dimensions.p16, Dimensions.p16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: AppSvgIcon(
                            path: AppIllustrations.rateOrderIllustration,
                            width: _kIllustrationWidth,
                            height: _kIllustrationHeight,
                          ),
                        ),
                        const SizedBox(height: Dimensions.p24),
                        Text(
                          appLocalizer.rateYourExperience,
                          textAlign: TextAlign.center,
                          style: TextStyles.semiBold20.copyWith(color: AppColors.black900, height: 1, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: Dimensions.p8),
                        _ExperienceStarRating(rating: rate, onRatingUpdate: (value) => setState(() => rate = value)),
                        const SizedBox(height: Dimensions.p24),
                        Text(
                          appLocalizer.addYourComment,
                          textAlign: TextAlign.center,
                          style: TextStyles.semiBold20.copyWith(color: AppColors.black900, height: 1, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: Dimensions.p8),
                        AppTextFormField(
                          label: appLocalizer.yourComment,
                          labelTextStyle: TextStyles.semiBold14.copyWith(color: AppColors.black900, height: 1, fontWeight: FontWeight.w600),
                          hint: appLocalizer.writeYourComment,
                          hintTextStyle: TextStyles.regular14.copyWith(color: _kCommentHint, height: 1),
                          inputTextStyle: TextStyles.regular14.copyWith(color: AppColors.black900, height: 1),
                          minLines: 5,
                          maxLines: 8,
                          maxLength: 500,
                          validator: (text) => Validator(text).defaultValidator,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimensions.r16),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimensions.r16),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: AppColors.productCardFill,
                          contentPadding: const EdgeInsets.all(Dimensions.p16),
                          margin: EdgeInsets.zero,
                          controller: commentController,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _AddRateBottomBar(isLoading: isLoading, onSubmit: () => _submit(isLoading)),
            ],
          ),
        );
      },
    );
  }
}

class _AddRateHeader extends StatelessWidget {
  const _AddRateHeader();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.white,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(Dimensions.p16, Dimensions.p20, Dimensions.p16, Dimensions.p24),
          child: SizedBox(
            height: _kBackButtonSize,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: _kBackButtonSize),
                  child: Text(
                    appLocalizer.rateOrder,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyles.semiBold20.copyWith(color: AppColors.black900, height: 1, fontWeight: FontWeight.w600),
                  ),
                ),
                const Align(alignment: AlignmentDirectional.centerStart, child: _AddRateBackButton()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AddRateBackButton extends StatelessWidget {
  const _AddRateBackButton();

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
        decoration: BoxDecoration(color: AppColors.productCardFill, shape: BoxShape.circle),
        child: Transform.flip(
          flipX: isRtl,
          child: AppSvgIcon(path: AppIcons.arrowBack, width: _kBackIconSize, height: _kBackIconSize),
        ),
      ),
    );
  }
}

class _ExperienceStarRating extends StatelessWidget {
  const _ExperienceStarRating({required this.rating, required this.onRatingUpdate});

  final double rating;
  final ValueChanged<double> onRatingUpdate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _kStarCircleSize,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: Dimensions.p8,
        children: List<Widget>.generate(_kStarCount, (int index) {
          final int starValue = index + 1;
          final bool isSelected = rating >= starValue;
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onRatingUpdate(starValue.toDouble()),
            child: Container(
              width: _kStarCircleSize,
              height: _kStarCircleSize,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? _kStarSelectedFill : AppColors.productCardFill,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white, width: _kStarBorderWidth),
              ),
              child: AppSvgIcon(path: isSelected ? AppIcons.starFilled : AppIcons.starEmpty, width: _kStarIconSize, height: _kStarIconSize),
            ),
          );
        }),
      ),
    );
  }
}

class _AddRateBottomBar extends StatelessWidget {
  const _AddRateBottomBar({required this.isLoading, required this.onSubmit});

  final bool isLoading;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.white,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(Dimensions.p16, Dimensions.p24, Dimensions.p16, Dimensions.p32),
          child: GestureDetector(
            onTap: isLoading ? null : onSubmit,
            behavior: HitTestBehavior.opaque,
            child: Container(
              height: _kActionButtonHeight,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(Dimensions.r16)),
              child: isLoading
                  ? SpinKitLoadingWidget.medium(color: AppColors.white)
                  : Text(
                      appLocalizer.sendRating,
                      style: TextStyles.semiBold18.copyWith(color: AppColors.white, height: 1, fontWeight: FontWeight.w600),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
