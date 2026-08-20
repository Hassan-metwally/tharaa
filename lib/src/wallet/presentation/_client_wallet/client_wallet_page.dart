import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../../core/core.dart';
import '../../../../core/di/di.dart';
import '../../../../material/app_fail_widget.dart';
import '../../../../material/buttons/app_button.dart';
import '../../../../material/inputs/app_text_form_field.dart';
import '../../../../material/inputs/validator_field/validator_field.dart';
import '../../../../material/media/svg_icon.dart';
import '../../../../material/overlay/show_modal_bottom_sheet.dart';
import '../../../../material/shimmer/shimmer_effect_widget.dart';
import '../../../../material/toast/app_toast.dart';
import '../../../common/domain/entity/common_entity.dart';
import '../../../common/presentation/drop_downs/banks/banks_drop_down.dart';
import '../../domain/entities/balance_entity.dart';
import '../../domain/entities/transaction_entity.dart';
import '../widgets/transaction_card.dart';
import '../widgets/transaction_loading_card.dart';
import 'client_wallet_cubit.dart';

class ClientWalletPage extends StatelessWidget {
  const ClientWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<ClientWalletCubit>()
        ..getBalance()
        ..getWalletHistory(),
      child: const _ClientWalletPageBody(),
    );
  }
}

class _ClientWalletPageBody extends StatefulWidget {
  const _ClientWalletPageBody();

  @override
  State<_ClientWalletPageBody> createState() => _ClientWalletPageBodyState();
}

class _ClientWalletPageBodyState extends State<_ClientWalletPageBody> {
  final ScrollController _scrollController = ScrollController();
  late final ClientWalletCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ClientWalletCubit>();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        _cubit.getMoreWalletHistory();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appLocalizer.wallet)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(bottom: 25),
        child: LiquidPullToRefresh(
          backgroundColor: AppColors.primary,
          color: AppColors.backgroundColor,
          onRefresh: () async {
            _cubit.getBalance();
            _cubit.getWalletHistory();
          },
          child: CustomScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverList.list(
                children: [
                  const SizedBox(height: 20),
                  const _BalanceWidget(),
                  const SizedBox(height: 20),
                  Text(appLocalizer.transactionHistory, style: TextStyles.regular14.copyWith(color: AppColors.black)),
                  const SizedBox(height: 8),
                ],
              ),
              BlocBuilder<ClientWalletCubit, ClientWalletState>(
                buildWhen: (previous, current) => previous.getWalletHistoryState != current.getWalletHistoryState,
                builder: (context, globalState) {
                  final state = globalState.getWalletHistoryState;
                  final List<TransactionEntity> transations = state.data ?? [];
                  if (state.isLoading) {
                    return SliverList.separated(
                      itemCount: 4,
                      itemBuilder: (context, index) => const TransactionLoadingCard(),
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 8);
                      },
                    );
                  } else if (state.isFailure) {
                    return SliverFillRemaining(
                      child: AppFailWidget(
                        onRetry: () {
                          context.read<ClientWalletCubit>().getWalletHistory();
                        },
                      ),
                    );
                  } else if (transations.isEmpty) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Text(appLocalizer.noWalletHistory, style: TextStyles.medium16.copyWith(color: AppColors.black)),
                      ),
                    );
                  }
                  return SliverList.separated(
                    itemCount: transations.length,
                    itemBuilder: (context, index) {
                      final transaction = transations[index];
                      return TransactionCard(transaction: transaction, getDateFormatted: (date) => date.EDMMMHMMA);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 8);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const _WithDrawButton(),
    );
  }
}

class _BalanceWidget extends StatelessWidget {
  const _BalanceWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 6,
        children: [
          SizedBox(height: 12),
          Center(
            child: Text(
              appLocalizer.currentBalance,
              style: TextStyles.regular14.copyWith(color: AppColors.black),
              textAlign: TextAlign.center,
            ),
          ),
          Center(
            child: BlocSelector<ClientWalletCubit, ClientWalletState, Async<BalanceEntity>>(
              selector: (state) {
                return state.getBalanceState;
              },
              builder: (context, state) {
                if (state.isSuccess == false) {
                  return ShimmerWidget(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "00.00",
                            style: TextStyles.bold24.copyWith(color: AppColors.black),
                          ),
                          TextSpan(
                            text: " ${appLocalizer.saudiRiyal}",
                            style: TextStyles.regular12.copyWith(color: AppColors.primary, height: 2.5),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                final balance = state.data?.currentBalance ?? 0;
                return Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: balance.toString(),
                        style: TextStyles.bold24.copyWith(color: AppColors.black),
                      ),
                      TextSpan(
                        text: " ${appLocalizer.saudiRiyal}",
                        style: TextStyles.regular12.copyWith(color: AppColors.primary, height: 2.5),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _WithDrawButton extends StatelessWidget {
  const _WithDrawButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientWalletCubit, ClientWalletState>(
      builder: (ctx, state) {
        final balance = state.getBalanceState.data?.currentBalance ?? 0;
        if (balance <= 0) {
          return const SizedBox();
        }
        return Container(
          color: AppColors.backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10).copyWith(bottom: 20),
          child: SafeArea(
            top: false,
            child: AppButton(
              text: appLocalizer.withdrawalRequest,
              onPressed: () => _WithdrawBalanceBottomSheet.show(context: context, providerWalletCubit: ctx.read()),
            ),
          ),
        );
      },
    );
  }
}

class _WithdrawBalanceBottomSheet extends StatefulWidget {
  final ClientWalletCubit providerWalletCubit;
  const _WithdrawBalanceBottomSheet({required this.providerWalletCubit});

  static Future<bool?> show({required BuildContext context, required ClientWalletCubit providerWalletCubit}) async =>
      await showAppModalBottomSheet(
        context: context,
        child: _WithdrawBalanceBottomSheet(providerWalletCubit: providerWalletCubit),
      );

  @override
  State<_WithdrawBalanceBottomSheet> createState() => _WithdrawBalanceBottomSheetState();
}

class _WithdrawBalanceBottomSheetState extends State<_WithdrawBalanceBottomSheet> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController _accountNumberController;
  late final TextEditingController _ibanNumberController;
  late final TextEditingController _amountController;
  late final TextEditingController _accountNameController;
  late final ValidatorFieldController<CommonEntity?> _bankController;

  @override
  void initState() {
    super.initState();
    _accountNumberController = TextEditingController();
    _ibanNumberController = TextEditingController();
    _amountController = TextEditingController();
    _accountNameController = TextEditingController();
    _bankController = ValidatorFieldController<CommonEntity?>();
  }

  @override
  void dispose() {
    _accountNumberController.dispose();
    _ibanNumberController.dispose();
    _amountController.dispose();
    _accountNameController.dispose();
    _bankController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.providerWalletCubit,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppSvgIcon(path: "", width: 40, height: 40),
              const SizedBox(height: 12),
              Text(appLocalizer.withdrawalRequest, style: TextStyles.medium18.copyWith(color: AppColors.black)),
              const SizedBox(height: 8),
              Text(
                appLocalizer.pleaseEnterBankAccountDetails,
                style: TextStyles.regular14.copyWith(color: AppColors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              BlocBuilder<ClientWalletCubit, ClientWalletState>(
                builder: (context, state) {
                  final balance = state.getBalanceState.data?.currentBalance ?? 0;
                  return AppTextFormField(
                    controller: _amountController,
                    inputType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                      EnglishNumbersFormatter(),
                      NoContainSpaceFormatter(),
                    ],
                    label: appLocalizer.settlementAmount,
                    hint: appLocalizer.enterAmount,
                    maxLength: 50,
                    hasCounter: true,
                    validator: (text) {
                      final validationMessage = Validator(text).positiveNumberValidator;
                      if (validationMessage != null) return validationMessage;

                      final amount = double.tryParse(text?.replaceAll(',', '') ?? '0') ?? 0;
                      if (amount > balance) {
                        return appLocalizer.amountExceedsBalance;
                      }
                      return null;
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              BanksDropDown(bankController: _bankController),
              const SizedBox(height: 16),
              AppTextFormField(
                controller: _accountNameController,
                label: appLocalizer.accountName,
                hint: appLocalizer.enterAccountName,
                maxLength: 50,
                hasCounter: true,
                validator: (text) => Validator(text).defaultValidator,
              ),
              const SizedBox(height: 16),
              AppTextFormField(
                controller: _accountNumberController,
                inputType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly, EnglishNumbersFormatter(), NoContainSpaceFormatter()],
                label: appLocalizer.accountNumber,
                hint: appLocalizer.enterAccountNumber,
                maxLength: 13,
                validator: (text) => Validator(text).bankAccountNumber,
              ),
              const SizedBox(height: 16),
              AppTextFormField(
                controller: _ibanNumberController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
                  EnglishNumbersFormatter(),
                  NoContainSpaceFormatter(),
                ],
                label: appLocalizer.ibaneNumber,
                labelTextStyle: TextStyles.medium14.copyWith(color: AppColors.black),
                hint: '**** **** **** ****',
                maxLength: 24,
                hasCounter: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                validator: (text) => Validator(text).ibanValidator,
              ),
              const SizedBox(height: 32),
              Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: BlocProvider.value(
                      value: widget.providerWalletCubit,
                      child: BlocConsumer<ClientWalletCubit, ClientWalletState>(
                        listener: (context, state) {
                          if (state.withDrawState.isSuccess) {
                            AppRouter.pop();
                            AppToasts.success(context, message: appLocalizer.withdrawSuccessMessage);
                            widget.providerWalletCubit.getBalance();
                          } else if (state.withDrawState.isFailure) {
                            AppToasts.error(context, message: state.withDrawState.errorMessage ?? '');
                          }
                        },
                        builder: (ctx, state) {
                          return AppButton(
                            isLoading: state.withDrawState.isLoading,
                            text: appLocalizer.agree,
                            onPressed: () => onWithdrawl(context, widget.providerWalletCubit),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: AppButton(
                      text: appLocalizer.cancel,
                      textStyle: TextStyles.medium16.copyWith(color: AppColors.black800),
                      buttonColor: AppColors.black100,
                      onPressed: () => AppRouter.pop(result: false),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onWithdrawl(BuildContext context, ClientWalletCubit providerWalletCubit) async {
    formKey.currentState?.save();
    if (!formKey.currentState!.validate()) {
      return;
    }
    final bank = _bankController.value;
    if (bank == null) {
      _bankController.validate();
      return;
    }
    final amount = double.tryParse(_amountController.text.replaceAll(',', '')) ?? 0;
    final accountName = _accountNameController.text.trim();
    final accountNumber = _accountNumberController.text.trim();
    final iban = _ibanNumberController.text.trim().toUpperCase();

    providerWalletCubit.withdrawBalance(amount: amount, bank: bank, accountName: accountName, accountNumber: accountNumber, iban: iban);
  }
}
