import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../../../core/di/di.dart';
import '../../../domain/entity/menu/contact_us_entity.dart';
import '../../../domain/use_cases/menu/get_contact_us_data_use_case.dart';
import '../../../domain/use_cases/menu/send_contact_us_message_use_case.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit() : super(const ContactUsState.initial()) {
    initDependency();
  }

  static ContactUsCubit of(BuildContext context) => BlocProvider.of<ContactUsCubit>(context);

  late final GetContactUsDataUseCase _getContactDataUseCase;
  late final SendContactUsMessageUseCase _sendContactUsMessageUseCase;

  void initDependency() {
    _getContactDataUseCase = injector<GetContactUsDataUseCase>();
    _sendContactUsMessageUseCase = injector<SendContactUsMessageUseCase>();
  }

  void getData() async {
    emit(state.copyWith(dataState: const Async.loading()));
    final result = await _getContactDataUseCase(NoParams());
    result.fold(
      (failer) {
        emit(state.copyWith(dataState: Async.failure(failer)));
      },
      (data) {
        emit(state.copyWith(dataState: Async.success(data)));
      },
    );
  }

  void sendMessage(SendContactUsMessageParams params) async {
    emit(state.copyWith(sendMessageState: const Async.loading()));
    final result = await _sendContactUsMessageUseCase(params);
    result.fold(
      (failure) {
        emit(state.copyWith(sendMessageState: Async.failure(failure)));
      },
      (_) {
        emit(state.copyWith(sendMessageState: const Async.successWithoutData()));
      },
    );
    emit(state.copyWith(sendMessageState: const Async.initial()));
  }

  @override
  void emit(ContactUsState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
