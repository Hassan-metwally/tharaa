part of core;

class Async<T> extends Equatable {
  final T? data;
  final Failure? failure;
  final bool _successWithoutData;
  final bool? _loading;
  final bool? _paginationLoading;

  const Async._(this.data, this._successWithoutData, this.failure, this._loading, this._paginationLoading);

  String? get errorMessage => failure?.message;

  bool get isLoading => _loading ?? false;

  bool get isPaginationLoading => _paginationLoading ?? false;

  bool get isSuccess => (_successWithoutData || data != null) && (failure == null);

  bool get isFailure => failure != null;

  bool get isInitial =>
      (data == null) && (failure == null) && (_successWithoutData == false) && (_loading == null) && (_paginationLoading == null);

  const Async.loading() : this._(null, false, null, true, false);

  const Async.paginationLoading(T data) : this._(data, false, null, false, true);

  const Async.success(T data) : this._(data, false, null, false, false);

  const Async.successWithoutData() : this._(null, true, null, false, false);

  const Async.failure(Failure failure) : this._(null, false, failure, false, false);

  const Async.initial() : this._(null, false, null, null, null);

  @override
  String toString() {
    return "Async : [data]: $data , [Failure]: ${failure.runtimeType} , [isFailure] : $isFailure , [isLoading] : $isLoading , [isSuccess] : $isSuccess ,[isInitial] $isInitial  [isPaginationLoading] $isPaginationLoading";
  }

  @override
  List<Object?> get props => [data, _successWithoutData, _loading, isFailure, isLoading, isSuccess, isInitial, failure, _paginationLoading];
}
