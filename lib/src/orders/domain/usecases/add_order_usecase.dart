import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../../../../material/inputs/validator_field/validator_field.dart';
import '../entities/order_entity.dart';
import '../repositories/orders_repository.dart';

@injectable
class AddOrderUsecase extends IUseCase<OrderEntity, UpsertOrderParams> {
  final OrdersRepository _repository;

  AddOrderUsecase(this._repository);

  @override
  Future<Either<Failure, OrderEntity>> call(UpsertOrderParams params) {
    return _repository.addOrder(params);
  }
}

class UpsertOrderParams extends Equatable {
  final int? id;
  final GlobalKey<FormState> formKey;
  final TextEditingController name;
  final ValidatorFieldController<AttachmentEntity?> imageController;

  const UpsertOrderParams({this.id, required this.formKey, required this.name, required this.imageController});

  UpsertOrderParams.initial()
    : this(
        id: null,
        formKey: GlobalKey<FormState>(),
        name: TextEditingController(),
        imageController: ValidatorFieldController<AttachmentEntity?>(),
      );

  UpsertOrderParams copyWith({
    int? id,
    TextEditingController? name,
    TextEditingController? mobile,
    ValidatorFieldController<AttachmentEntity?>? imageController,
  }) {
    return UpsertOrderParams(
      id: id ?? this.id,
      formKey: formKey,
      name: name ?? this.name,
      imageController: imageController ?? this.imageController,
    );
  }

  factory UpsertOrderParams.fromEntity(OrderEntity entity) {
    return UpsertOrderParams(
      id: entity.id,
      formKey: GlobalKey<FormState>(),
      name: TextEditingController(text: entity.name),
      imageController: ValidatorFieldController<AttachmentEntity?>(initialValue: entity.image),
    );
  }

  Map<String, dynamic> get toMap => {
    'name': name.text,
    if (imageController.value != null) 'avatar': imageController.value!.path.toMultipartFile,
    if (id != null) '_method': 'PUT',
  };

  @override
  List<Object?> get props => [id, formKey, name, imageController];
}
