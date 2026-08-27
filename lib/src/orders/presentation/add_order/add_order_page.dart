import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/core.dart';
import '../../../../../../core/di/di.dart';
import '../../../../../../material/buttons/app_button.dart';
import '../../../../../../material/toast/app_toast.dart';
import '../../../../material/inputs/app_text_form_field.dart';
import '../../../../material/inputs/media_field.dart';
import '../../domain/usecases/add_order_usecase.dart';

import 'add_order_cubit.dart';

class AddOrderPage extends StatelessWidget {
  const AddOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => injector<AddOrderCubit>(), child: const _AddOrderBody());
  }
}

class _AddOrderBody extends StatefulWidget {
  const _AddOrderBody();

  @override
  State<_AddOrderBody> createState() => _AddOrderBodyState();
}

class _AddOrderBodyState extends State<_AddOrderBody> {
  late final AddOrderCubit _orderCubit;
  @override
  void initState() {
    super.initState();
    _orderCubit = context.read<AddOrderCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("appLocalizer.add"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: AppColors.black50, // border color
            height: 1.0,
          ),
        ),
      ),
      body: BlocSelector<AddOrderCubit, AddOrderState, UpsertOrderParams>(
        selector: (state) {
          return state.params;
        },
        builder: (context, paramsState) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: paramsState.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("appLocalizer.enterFollowingData", style: TextStyles.regular14),
                          const SizedBox(height: 16),
                          AppTextFormField(
                            controller: paramsState.name,
                            label: "appLocalizer.name",
                            // hint: appLocalizer.enterName,
                          ),
                          const SizedBox(height: 30),
                          MediaFieldWidget(
                            controller: paramsState.imageController,
                            label: "appLocalizer.image",
                            hint: "appLocalizer.enterImage",
                            validationMessage: "appLocalizer.attachImage",
                            // hasRequiredSymbol: true,
                            // canPickPdf: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                BlocConsumer<AddOrderCubit, AddOrderState>(
                  listener: (context, state) {
                    if (state.addOrderState.isSuccess) {
                      AppRouter.pop();
                      AppToasts.success(context, message: "appLocalizer.AddedSuccessfully");
                    } else if (state.addOrderState.isFailure) {
                      AppToasts.error(context, message: state.addOrderState.errorMessage ?? '');
                    }
                  },
                  builder: (context, state) {
                    return SafeArea(
                      top: false,
                      child: AppButton(
                        isLoading: state.addOrderState.isLoading,
                        text: "appLocalizer.add",
                        onPressed: () {
                          paramsState.formKey.currentState?.save();
                          if (paramsState.formKey.currentState?.validate() ?? false) {
                            _orderCubit.addOrder();
                          }
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
