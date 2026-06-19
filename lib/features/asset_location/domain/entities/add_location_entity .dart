import 'package:equatable/equatable.dart';

class AddLocationEntity extends Equatable {
  final String name;

  const AddLocationEntity({required this.name});

  @override
  List<Object> get props => [name];
}
