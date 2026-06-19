import 'package:equatable/equatable.dart';

class EditCategoryEntity extends Equatable {
  final String id;
  final String? name;
  final String? code;

  const EditCategoryEntity({required this.id, required this.name, required this.code});

  @override
  List<Object> get props {
    return [id, ?name, ?code];
  }
}
