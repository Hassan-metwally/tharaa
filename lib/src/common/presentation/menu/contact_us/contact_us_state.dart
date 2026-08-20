part of "contact_us_cubit.dart";

class ContactUsState extends Equatable {
  final Async<ContactUsEntity> dataState;
  final Async<void> sendMessageState;

  const ContactUsState({required this.dataState, required this.sendMessageState});

  const ContactUsState.initial() : this(dataState: const Async.initial(), sendMessageState: const Async.initial());

  ContactUsState copyWith({Async<ContactUsEntity>? dataState, Async<void>? sendMessageState}) {
    return ContactUsState(dataState: dataState ?? this.dataState, sendMessageState: sendMessageState ?? this.sendMessageState);
  }

  @override
  List<Object?> get props => [dataState, sendMessageState];
}
