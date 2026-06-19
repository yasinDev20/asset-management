import 'package:equatable/equatable.dart';

class AddCategoryEntity extends Equatable {
  final String name;
  final String code;

  const AddCategoryEntity({required this.name, required this.code});

  @override
  List<Object> get props {
    return [name, code];
  }
}
