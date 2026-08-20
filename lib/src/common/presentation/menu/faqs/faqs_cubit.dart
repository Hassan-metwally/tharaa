// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../../core/core.dart';
// import '../../../../../core/di/di.dart';
// import '../../../domain/entity/menu/faq_entity.dart';
// import '../../../domain/use_cases/menu/get_faq_use_case.dart';

// class FaqsCubit extends Cubit<Async<List<FaqEntity>>> {
//   static FaqsCubit of(BuildContext context) => BlocProvider.of<FaqsCubit>(context);

//   final GetFaqUseCase _getFaqPagesDataUseCase = injector<GetFaqUseCase>();

//   FaqsCubit() : super(const Async.initial()) {
//     getFaqData();
//   }

//   void getFaqData() async {
//     emit(const Async.loading());
//     final result = await _getFaqPagesDataUseCase(NoParams());
//     result.fold(
//       (failer) {
//         emit(Async.failure(failer));
//       },
//       (data) {
//         emit(Async.success(data));
//       },
//     );
//   }

//   @override
//   void emit(Async<List<FaqEntity>> state) {
//     if (!isClosed) {
//       super.emit(state);
//     }
//   }
// }
