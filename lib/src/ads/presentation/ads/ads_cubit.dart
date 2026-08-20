import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../../domain/entities/ad_entity.dart';
import '../../domain/usecases/get_all_ads_usecase.dart';

part 'ads_state.dart';

@injectable
class AdsCubit extends Cubit<AdsState> {
  final GetAllAdsUsecase _getAllAdsUsecase;
  AdsCubit(this._getAllAdsUsecase) : super(AdsState.initial());

  Future<void> getAllAds() async {
    emit(state.copyWith(getAllAdsState: const Async.loading()));
    final result = await _getAllAdsUsecase(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(getAllAdsState: Async.failure(failure))),
      (data) => emit(state.copyWith(getAllAdsState: Async.success(data))),
    );
  }

  @override
  void emit(AdsState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
