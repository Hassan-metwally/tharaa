part of core;

typedef DomainServiceType<T> = Future<Either<Failure, T>>;

typedef GenericVoidCallback<T> = void Function(T value);
