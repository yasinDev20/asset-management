import 'package:equatable/equatable.dart';

class EditBrandEntity extends Equatable {
  final String id;
  final String? name;

  const EditBrandEntity({required this.id, this.name});

  @override
  List<Object> get props => [id, ?name];
}
