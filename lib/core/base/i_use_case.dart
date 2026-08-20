part of core;

// Parameters have to be put into a container object so that they can be
// included in this abstract base class method definition.
abstract class IUseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

// This will be used by the code calling the use case whenever the use case
// doesn't accept any parameters.
class NoParams extends Equatable {
  Future<Map<String, dynamic>> get toMap async => {};

  @override
  List<Object?> get props => <Object?>[];
}
