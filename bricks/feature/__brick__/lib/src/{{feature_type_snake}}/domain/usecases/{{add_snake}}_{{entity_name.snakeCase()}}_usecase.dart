import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../../../../material/inputs/validator_field/validator_field.dart';
import '../entities/{{entity_type_snake}}_entity.dart';
import '../repositories/{{feature_type_snake}}_repository.dart';

{{#with_add}}
@injectable
class {{add_pascal}}{{entity_name.pascalCase()}}Usecase extends IUseCase<{{entity_type_pascal}}Entity, {{upsert_pascal}}{{entity_name.pascalCase()}}Params> {
  final {{feature_type_pascal}}Repository _repository;

  {{add_pascal}}{{entity_name.pascalCase()}}Usecase(this._repository);

  @override
  Future<Either<Failure, {{entity_type_pascal}}Entity>> call({{upsert_pascal}}{{entity_name.pascalCase()}}Params params) {
    return _repository.{{add_camel}}{{entity_name.pascalCase()}}(params);
  }
}
{{/with_add}}
{{^with_add}}
{{#with_upsert}}
@injectable
class {{add_pascal}}{{entity_name.pascalCase()}}Usecase extends IUseCase<{{entity_type_pascal}}Entity, {{upsert_pascal}}{{entity_name.pascalCase()}}Params> {
  final {{feature_type_pascal}}Repository _repository;

  {{add_pascal}}{{entity_name.pascalCase()}}Usecase(this._repository);

  @override
  Future<Either<Failure, {{entity_type_pascal}}Entity>> call({{upsert_pascal}}{{entity_name.pascalCase()}}Params params) {
    return _repository.{{add_camel}}{{entity_name.pascalCase()}}(params);
  }
}
{{/with_upsert}}
{{/with_add}}

class {{upsert_pascal}}{{entity_name.pascalCase()}}Params extends Equatable {
  final int? id;
  final GlobalKey<FormState> formKey;
  final TextEditingController name;
  final ValidatorFieldController<AttachmentEntity?> imageController;

  const {{upsert_pascal}}{{entity_name.pascalCase()}}Params({
    this.id,
    required this.formKey,
    required this.name,
    required this.imageController,
  });

  {{upsert_pascal}}{{entity_name.pascalCase()}}Params.initial()
      : this(
            id: null,
            formKey: GlobalKey<FormState>(),
            name: TextEditingController(),
            imageController: ValidatorFieldController<AttachmentEntity?>());

  {{upsert_pascal}}{{entity_name.pascalCase()}}Params copyWith({
    int? id,
    TextEditingController? name,
    TextEditingController? mobile,
    ValidatorFieldController<AttachmentEntity?>? imageController,
  }) {
    return {{upsert_pascal}}{{entity_name.pascalCase()}}Params(
      id: id ?? this.id,
      formKey: formKey,
      name: name ?? this.name,
      imageController: imageController ?? this.imageController,
    );
  }

  factory {{upsert_pascal}}{{entity_name.pascalCase()}}Params.fromEntity({{entity_type_pascal}}Entity entity) {
    return {{upsert_pascal}}{{entity_name.pascalCase()}}Params(
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


