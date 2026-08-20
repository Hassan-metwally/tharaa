import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../repositories/address_repository.dart';

@Injectable()
class DeleteLocationUseCase extends IUseCase<void, DeleteLocationParams> {
  final AddressRepository _repository;

  DeleteLocationUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(DeleteLocationParams params) async => await _repository.deleteLocation(params);
}

class DeleteLocationParams extends Equatable {
  final int id;

  const DeleteLocationParams({required this.id});

  @override
  List<Object?> get props => [id];
}
