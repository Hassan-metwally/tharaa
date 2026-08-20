import 'package:equatable/equatable.dart';

class FaqEntity extends Equatable {
  final int id;
  final String name;
  final String description;

  const FaqEntity({required this.id, required this.name, required this.description});

  factory FaqEntity.fromJson(Map<String, dynamic> json) {
    return FaqEntity(id: json['id'], name: json['question'], description: json['answer']);
  }

  @override
  List<Object?> get props => [id, name, description];
}
