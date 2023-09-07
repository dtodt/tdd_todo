import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int id;
  final String description;
  final bool checked;

  const Task({
    required this.id,
    required this.description,
    this.checked = false,
  });

  @override
  List<Object?> get props => [id, description, checked];
}
