part of core;

/// Mixin that provides safe emit functionality by overriding the emit method
/// Prevents state emission when the cubit is closed
mixin SafeEmitMixin<State> on Cubit<State> {
  @override
  void emit(State state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}

// Example usage:
/*
class OnboardingCubit extends Cubit<OnboardingState> with SafeEmitMixin<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  void nextPage() {
    // This emit will be safe automatically
    emit(OnboardingNextPage());
  }
}

class CounterCubit extends Cubit<int> with SafeEmitMixin<int> {
  CounterCubit() : super(0);

  void increment() {
    // This emit will be safe automatically
    emit(state + 1);
  }
}
*/
