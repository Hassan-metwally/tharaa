import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';

typedef MoreState = Async<void>;

@Injectable()
class MoreCubit extends Cubit<MoreState> with SafeEmitMixin {
  MoreCubit() : super(const Async.initial());
}
