import 'package:equatable/equatable.dart';

class CommonEntity extends Equatable {
  final int id;
  final String name;

  const CommonEntity({required this.id, required this.name});

  const CommonEntity.initial() : id = 0, name = '';

  @override
  List<Object?> get props => [id, name];
}
