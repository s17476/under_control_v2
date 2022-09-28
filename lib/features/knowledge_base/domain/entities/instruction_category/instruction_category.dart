import 'package:equatable/equatable.dart';

class InstructionCategory extends Equatable {
  final String id;
  final String name;

  const InstructionCategory({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];

  @override
  String toString() => 'InstructionCategory(id: $id, name: $name)';
}
